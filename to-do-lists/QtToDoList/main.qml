import QtQuick

Window {
  id: root
  visible: true

  color: "#EBEBEB"

  Item {
    id: tasksSection

    anchors {
      fill: parent
      margins: 20
      topMargin: 80
      bottomMargin: 0
    }

    Text {
      id: tasksSectionTitle

      font {
        bold: true
        pointSize: 24
      }

      text: qsTr("Your tasks")
    }

    ListView {
      id: tasksListView

      anchors {
        top: tasksSectionTitle.bottom
        topMargin: 30
        bottom: parent.bottom
      }
      width: parent.width

      model: tasksModel

      spacing: 20

      delegate: Task {
        width: tasksSection.width
        height: 54

        text: title

        onClicked: {
          restApiClient.sendDeleteTaskRequest(id)
        }
      }
    }
  }

  InputSection {
    id: inputSection

    anchors {
      bottom: parent.bottom
      left: parent.left
      right: parent.right
      margins: 20
      bottomMargin: 30
    }

    onAddClicked: function (task) {
      restApiClient.sendPostTaskRequest(task)
    }
  }

  Component.onCompleted: {
    restApiClient.sendGetTasksRequest()
  }
}
