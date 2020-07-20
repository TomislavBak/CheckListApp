import QtQuick 2.0

// Model for red animated buttons

Rectangle{
    id:listButton
    width: newList.width
    height: 20
    color: "transparent"
    property alias redText: newList.text

    Text {
    id: newList
    //text: qsTr("Create new list")
    font.underline: newList
    color: "red"
    anchors.centerIn: listButton
    }

    MouseArea{
        id:mouseArea
        anchors.fill: listButton
        hoverEnabled: true
        onHoveredChanged: {
            listButton.color = "red"
            newList.color = "white"
        }
      onExited: {
          listButton.color = "transparent"
          newList.color = "red"
      }
    }


}


