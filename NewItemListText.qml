import QtQuick 2.0


// Model for blue animated buttons


Rectangle{
    id:listButton
    width: newList.width
    height: 20
    color: "transparent"
    property alias blueText: newList.text

    Text {
    id: newList
    //text: qsTr("My Lists")
    font.underline: newList
    color: "blue"
    anchors.centerIn: listButton
    }

    MouseArea{
        id:mouseArea
        anchors.fill: listButton
        hoverEnabled: true
        onHoveredChanged: {
            listButton.color = "blue"
            newList.color = "white"
        }
      onExited: {
          listButton.color = "transparent"
          newList.color = "blue"
      }
    }


}
