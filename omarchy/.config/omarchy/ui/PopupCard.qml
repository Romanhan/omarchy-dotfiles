import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.Commons

PopupWindow {
  id: root

  required property Item anchorItem
  required property QtObject bar
  property var owner: null
  property int margin: 0
  property int padding: Style.spacing.popupPadding
  property int contentWidth: Style.space(280)
  property int contentHeight: Style.space(200)
  property color borderColor: Color.popups.border
  property real _grow: 0
  readonly property string barPos: root.bar ? root.bar.position : "top"
  property bool open: false
  property bool centerOnBar: false
  // "click" — uses HyprlandFocusGrab so clicking outside dismisses the popup.
  // "hover" — passive overlay; the owning widget controls open via hover.
  property string triggerMode: "click"

  readonly property var coordinatorKey: owner || root
  readonly property var anchorWindow: anchorItem ? anchorItem.QsWindow.window : null
  readonly property var popupScreen: anchorWindow ? anchorWindow.screen : null
  readonly property bool containsMouse: cardHover.hovered
  readonly property real screenW: popupScreen ? popupScreen.width : 0
  readonly property real screenH: popupScreen ? popupScreen.height : 0
  readonly property real barW: anchorWindow ? anchorWindow.width : 0
  readonly property real barH: anchorWindow ? anchorWindow.height : 0
  readonly property real availableCardWidth: screenW > 0
    ? Math.max(120, screenW - ((bar && (bar.position === "left" || bar.position === "right")) ? barW : 0) - root.margin * 2)
    : 0
  readonly property real availableCardHeight: screenH > 0
    ? Math.max(120, screenH - ((bar && (bar.position === "top" || bar.position === "bottom")) ? barH : 0) - root.margin * 2)
    : 0
  readonly property real verticalContentInset: padding * 2

  function fittedContentWidth(width, cap) {
    var desired = Math.max(1, Number(width) || 1)
    var maxWidth = root.availableCardWidth > 0 ? root.availableCardWidth : desired
    if (cap !== undefined && Number(cap) > 0) maxWidth = Math.min(maxWidth, Number(cap))
    return Math.round(Math.min(desired, maxWidth))
  }

  function fittedContentHeight(implicitHeight, cap) {
    var desired = Math.max(root.verticalContentInset, (Number(implicitHeight) || 0) + root.verticalContentInset)
    var maxHeight = root.availableCardHeight > 0 ? root.availableCardHeight : desired
    if (cap !== undefined && Number(cap) > 0) maxHeight = Math.min(maxHeight, Number(cap))
    return Math.round(Math.min(desired, maxHeight))
  }

  function cappedContentHeight(height) {
    var desired = Math.max(root.padding * 2, Number(height) || root.padding * 2)
    var maxHeight = root.availableCardHeight > 0 ? root.availableCardHeight : desired
    return Math.round(Math.min(desired, maxHeight))
  }

  function close() {
    if (owner && "close" in owner) owner.close()
    else root.open = false
  }

  default property alias contentItem: contentHolder.children

  visible: open || root._grow > 0
  color: "transparent"
  implicitWidth: contentWidth
  implicitHeight: contentHeight

  onOpenChanged: {
    if (!bar) return
    if (open) bar.requestPopout(coordinatorKey)
    else if (bar.activePopout === coordinatorKey) bar.releasePopout(coordinatorKey)
    if (open) card.playOpen()
    else card.playClose()
  }

  Component.onCompleted: { if (root.open) card.playOpen() }

  // Outside-click dismissal via Hyprland's focus grab. While `active`, input
  // is routed only to the listed windows; clicking anywhere else clears the
  // grab and we close the popup. Skipped for hover-mode popups so the cursor
  // can move freely between the trigger and the popup.
  HyprlandFocusGrab {
    active: root.open && root.triggerMode === "click"
    windows: root.anchorWindow ? [root, root.anchorWindow] : [root]
    onCleared: root.close()
  }

  anchor {
    id: popupAnchor
    window: anchorItem ? anchorItem.QsWindow.window : null
    adjustment: PopupAdjustment.Slide
    edges: Edges.Top | Edges.Left
    gravity: Edges.Bottom | Edges.Right
    rect.width: 1
    rect.height: 1

    onAnchoring: {
      if (!root.anchorItem || !root.bar) return

      var target = root.anchorItem
      var popupWidth = root.implicitWidth
      var popupHeight = root.implicitHeight
      var window = target.QsWindow.window
      if (!window) return

      var R = Style.cornerRadius

      if (root.centerOnBar) {
        var cx = 0;
        var cy = 0;
        if (root.bar.position === "top" || root.bar.position === "bottom") {
          cx = window.width / 2 - popupWidth / 2
          cy = root.bar.position === "bottom" ? -popupHeight : window.height
          cx = Math.max(0, Math.min(cx, window.width - popupWidth))
        } else {
          cx = root.bar.position === "left" ? window.width : -popupWidth
          cy = window.height / 2 - popupHeight / 2
          cy = Math.max(0, Math.min(cy, window.height - popupHeight))
        }

        popupAnchor.rect.x = Math.round(cx)
        popupAnchor.rect.y = Math.round(cy)
        return
      }

      function findPill(item, win) {
        var o = item
        while (o && o.parent) {
          if (o.parent.width === win.width && o.parent.height === win.height && o.parent !== win)
            return o
          o = o.parent
        }
        return null
      }
      var pill = findPill(target, window)
      var pillRight, pillBottom
      if (pill) {
        var ppos = pill.mapToItem(window.contentItem, 0, 0)
        pillRight = ppos.x + pill.width
        pillBottom = ppos.y + pill.height
      } else {
        pillRight = window.width
        pillBottom = window.height
      }
      var rx = 0, ry = 0
      if (root.bar.position === "top") {
        rx = pillRight - popupWidth - R
        ry = window.height
      } else if (root.bar.position === "bottom") {
        rx = pillRight - popupWidth - R
        ry = -popupHeight
      } else if (root.bar.position === "left") {
        rx = window.width
        ry = pillBottom - popupHeight - R
      } else { // right
        rx = -popupWidth
        ry = pillBottom - popupHeight - R
      }

      popupAnchor.rect.x = Math.round(rx)
      popupAnchor.rect.y = Math.round(ry)
    }
  }

  Item {
    id: card

    // Anchor to the bar-facing edge and grow along the axis away from the bar
    // so the popup reads as a drawer extending out of the bar (no separate
    // floating-window feel). `_grow` animates 0 -> 1 on open.
    anchors.top:    (root.bar && root.bar.position === "bottom") ? undefined : parent.top
    anchors.bottom: (root.bar && root.bar.position === "bottom") ? parent.bottom : undefined
    anchors.left:   (root.bar && root.bar.position === "right")  ? undefined : parent.left
    anchors.right:  (root.bar && root.bar.position === "right")  ? parent.right : undefined
    width:  (root.bar && (root.bar.position === "left" || root.bar.position === "right")) ? parent.width  * root._grow : parent.width
    height: (root.bar && (root.bar.position === "left" || root.bar.position === "right")) ? parent.height : parent.height * root._grow

    NumberAnimation { id: growAnim;    target: root; property: "_grow";   from: 0; to: 1; duration: 250; easing.type: Easing.OutQuint }
    NumberAnimation { id: shrinkAnim;  target: root; property: "_grow";   from: 1; to: 0; duration: 250; easing.type: Easing.OutQuint }

    function playOpen() {
      shrinkAnim.stop()
      root._grow = 0
      growAnim.start()
    }
    function playClose() {
      growAnim.stop()
      shrinkAnim.start()
    }

    Rectangle {
      anchors.fill: parent
      clip: true
      color: Color.popups.background
      topLeftRadius: (root.barPos === "top" || root.barPos === "left") ? 0 : Style.cornerRadius
      topRightRadius: (root.barPos === "top" || root.barPos === "right") ? 0 : Style.cornerRadius
      bottomLeftRadius: (root.barPos === "bottom" || root.barPos === "left") ? 0 : Style.cornerRadius
      bottomRightRadius: (root.barPos === "bottom" || root.barPos === "right") ? 0 : Style.cornerRadius

      Item {
        id: contentHolder
        anchors.fill: parent
        anchors.topMargin: root.padding
        anchors.rightMargin: root.padding
        anchors.bottomMargin: root.padding
        anchors.leftMargin: root.padding
      }

      HoverHandler {
        id: cardHover
      }
    }
  }
}
