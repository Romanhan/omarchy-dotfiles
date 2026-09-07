import QtQuick
import qs.Commons
import qs.Ui

// Reveal toggle for the dynamic island: shows a chevron that flips as the
// hidden bar widgets expand (revealed) or collapse back to the core set.
BarWidget {
  id: root
  moduleName: "island-reveal"

  // The host injects `bar` after the custom component has been created. Keep
  // the initial evaluation strictly boolean so startup never tries to assign
  // an undefined host property to this bool.
  readonly property bool revealed: !!bar && bar.islandRevealed === true

  function toggleTrayManager() {
    if (!bar || typeof bar.moduleWidgets !== "function") return
    var trays = bar.moduleWidgets("romanhan.tray")
    for (var i = 0; i < trays.length; i++) {
      if (bar.targetBelongsToWindow
          && !bar.targetBelongsToWindow(trays[i], root.QsWindow.window)) continue
      trays[i].managePopupOpen = !trays[i].managePopupOpen
      return
    }
  }

  implicitWidth: Style.space(22)
  implicitHeight: barSize

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "\uF104"
    horizontalMargin: 0
    verticalPadding: 0
    fontSize: Style.bar.iconFont
    tooltipText: root.revealed
      ? "Hide bar widgets · Right-click for tray settings"
      : "Show more bar widgets · Right-click for tray settings"
    opacity: 0.85
    textRotation: root.revealed ? 180 : 0

    Behavior on textRotation {
      NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    onPressed: function(buttonCode) {
      if (buttonCode === Qt.LeftButton && root.bar) root.bar.toggleIslandReveal()
      else if (buttonCode === Qt.RightButton) root.toggleTrayManager()
    }
  }
}
