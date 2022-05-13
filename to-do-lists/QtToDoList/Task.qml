import QtQuick

Rectangle {
  id: root

  signal clicked
  property alias text: taskText.text

  radius: 10

  Row {
    id: leftWrapper

    anchors {
      left: parent.left
      leftMargin: 15
      verticalCenter: parent.verticalCenter
    }

    spacing: 15

    Rectangle {
      id: indicator

      anchors.verticalCenter: parent.verticalCenter

      width: 24
      height: 24

      opacity: 0.4

      color: "#218165"
      radius: 5
    }

    Text {
      id: taskText

      anchors.verticalCenter: parent.verticalCenter

      width: root.width * 0.8
      clip: true
    }
  }

  Rectangle {
    id: circle

    anchors {
      right: parent.right
      rightMargin: 15
      verticalCenter: parent.verticalCenter
    }

    width: 12
    height: 12

    color: "transparent"
    border {
      color: "#218165"
      width: 2
    }
    radius: 5
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      root.clicked()
    }
  }
}
