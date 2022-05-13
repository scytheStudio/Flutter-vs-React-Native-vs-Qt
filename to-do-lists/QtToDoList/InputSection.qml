import QtQuick
import QtQuick.Controls

Item {
  id: root

  signal addClicked(string task)

  width: parent.width
  height: 60

  Rectangle {
    id: inputFieldBackground

    anchors.verticalCenter: parent.verticalCenter

    width: 250
    height: textEdit.implicitHeight

    border {
      width: 1
      color: "#C0C0C0"
    }
    radius: 60

    TextInput {
      id: textEdit

      width: parent.width
      clip: true
      cursorVisible: false
      padding: 15

      Text {
        anchors.fill: parent
        visible: textEdit.displayText === ""

        color: "#C0C0C0"
        padding: textEdit.padding
        text: qsTr("Write a task")
      }
    }
  }

  Rectangle {
    id: addButton

    anchors.right: parent.right

    width: 60
    height: 60

    border {
      width: 1
      color: "#C0C0C0"
    }
    radius: height / 2

    Text {
      anchors.centerIn: parent
      text: "+"
    }

    MouseArea {
      anchors.fill: parent

      onClicked: {
        const task = textEdit.displayText
        textEdit.clear()
        Qt.inputMethod.hide()
        if (task !== "") {
          root.addClicked(task)
        }
      }
    }
  }
}
