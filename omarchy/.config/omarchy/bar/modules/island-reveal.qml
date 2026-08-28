import QtQuick
import qs.Commons
import qs.Ui

// Reveal toggle for the dynamic island: shows a chevron that flips as the
// hidden bar widgets expand (revealed) or collapse back to the core set.
BarWidget {
  id: root
  moduleName: "island-reveal"

  readonly property bool revealed: bar ? bar.islandRevealed : false

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
    tooltipText: root.revealed ? "Hide bar widgets" : "Show more bar widgets"
    opacity: 0.85
    textRotation: root.revealed ? 180 : 0

    Behavior on textRotation {
      NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    onPressed: function(buttonCode) {
      if (buttonCode === Qt.LeftButton && root.bar) root.bar.toggleIslandReveal()
    }
  }
}