import QtQuick

Window {
  id: root

  visible: true
  title: qsTr("Hello World")

  Grid {
    columns: 3

    Repeater {
      id: repeater

      readonly property real tileSize: root.width / 3

      model: 18

      AnimatedImage {
        id: animatedGif
        width: repeater.tileSize
        height: repeater.tileSize

        source: "assets/phoneAnimation.gif"

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
