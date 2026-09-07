import QtQuick
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "omarchy.indicators"

  readonly property var indicatorEntries: settings.items && settings.items.length
    ? settings.items : ["Dictation", "ScreenRecording", "Reminder", "NightLight", "Dnd", "StayAwake"]
  readonly property bool revealInactiveIndicators: false
  signal refreshRequested()

  function refresh() { refreshRequested() }
  function setIndicatorItemHovered(hovered) {}

  implicitWidth: indicators.implicitWidth
  implicitHeight: indicators.implicitHeight

  IpcHandler {
    target: "omarchy.indicators"
    function refresh(): void { root.broadcast("refresh") }
    function status(): string {
      var active = []
      for (var i = 0; i < indicatorRepeater.count; i++) {
        var slot = indicatorRepeater.itemAt(i)
        if (slot.visible) active.push(slot.indicatorId)
      }
      return JSON.stringify({active: active, width: root.implicitWidth,
        expanded: root.bar ? root.bar.islandRevealed : false})
    }
  }

  Grid {
    id: indicators
    rows: root.vertical ? -1 : 1
    columns: root.vertical ? 1 : -1
    spacing: 0

    Repeater {
      id: indicatorRepeater
      model: root.indicatorEntries

      Loader {
        id: indicatorSlot
        required property var modelData
        readonly property string indicatorId: typeof modelData === "string" ? modelData : modelData.id
        visible: !!item && item.active === true
        source: Qt.resolvedUrl("../indicators/" + indicatorId + ".qml")
        width: visible ? item.implicitWidth : 0
        height: visible ? item.implicitHeight : 0

        onLoaded: {
          item.bar = Qt.binding(function() { return root.bar })
          item.moduleName = indicatorId
          item.settings = typeof modelData === "string" ? {} : modelData
          item.indicatorHost = root
          item.indicatorBlock = "active"
        }
      }
    }
  }
}
