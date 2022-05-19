import QtQuick

Window {
  id: root

  visible: true
  title: qsTr("Hello World")

  Grid {
    columns: 10

    Repeater {
      id: repeater

      readonly property real tileSize: root.width / 10

      model: 200

      Image {
        id: animatedGif
        width: repeater.tileSize
        height: repeater.tileSize

        source: "assets/logo.png"

        PropertyAnimation {
          target: animatedGif
          from: 0
          to: 360
          property: "rotation"
          loops: PropertyAnimation.Infinite
          running: true
          duration: 1000
        }
      }
    }
  }
}
