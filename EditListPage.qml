import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4

import "Global.js" as Global

// The page is opended when the Edit button in the CheckListPage is clicked,
// new name and description are saved if clicked Save in the bottom, new description
// for the embedded list items is saved if clicked on the green check button, items
// are deleted if pressed on the x button.

Rectangle{
    id:root
    visible: true
    width:mainWindow.width
    height:mainWindow.height
    color: "transparent"
    property alias getTextEditor:inputList.text
    property alias getTextDescription:descriptionEdit.text

    Text{
        id:editListText
        text: qsTr("Edit this list")
        font.pointSize: 18
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Rectangle{
        id:lineSeparator
        width: parent.width
        height: 1
        anchors.top: editListText.bottom
        border.color: "black"
        color: "black"
    }

    NewListText{
        id: cancelText
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: lineSeparator.bottom
        anchors.topMargin: 2
        redText: qsTr("Cancel")
        MouseArea{
            anchors.fill: cancelText
            onClicked: {loadEditPage.visible = false;loadCheckList.visible = true}
        }
    }
    Text{
        id: slash
        anchors.left: cancelText.right
        anchors.top: lineSeparator.bottom
        anchors.topMargin: 2
        text: qsTr("|")
    }
    NewListText{
        id: deleteText
        anchors.left: slash.right
        anchors.top: lineSeparator.bottom
        anchors.topMargin: 2
        redText: qsTr("Delete this list")
        MouseArea{
            anchors.fill: deleteText
            onClicked: {todomodelMain.deleteItem(Global.globalIndex);loadEditPage.visible = false;loadMain.visible = true}}
    }
    Text{id:titleText;
         anchors.top: cancelText.bottom;
         anchors.topMargin: 15
         anchors.left: parent.left
         anchors.leftMargin: 10
         text: qsTr("TITLE")}
    TextField{
        id: inputList
        width: parent.width
        height: 40
        anchors.top: titleText.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        placeholderText: qsTr("")
        focus: true
        textColor: "black"
    }
    Text{id:descriptionText;
        anchors.top: inputList.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
         text: qsTr("DESCRIPTION")}
    TextField{
        id: descriptionEdit
        height: 50
        anchors.top: descriptionText.bottom
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        textColor: "black"

    }
    Text{id:itemsText;
        anchors.top: descriptionEdit.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
         text: qsTr("ITEMS")}
    Rectangle{
        id: checkBox
        width: parent.width
        height: 200
        anchors.top: itemsText.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    ListView{
        anchors.fill: parent
        id: toDoList
        visible: true
        model: todomodelCheck
        delegate: myDelegate
        Component {
            id: myDelegate
            Item {
                id: wrapper
                width: parent.width; height: 25
                Row {TextField {id:editItem; text: descriptionCheck ; textColor: "black"
                    Column{
                        anchors.left: editItem.right
                    Image{
                        id:saveItem
                        visible: true
                        source: "/images/Images/checkmark-11.png"
                        MouseArea{anchors.fill: saveItem
                                  onClicked: { wrapper.ListView.view.currentIndex  = index
                                              todomodelCheck.newDescription(index ,editItem.text)
                                              }}}

                    Image {
                        id: deleteItem1
                        source: "/images/Images/grey_delete.gif"
                        MouseArea{anchors.fill: deleteItem1 ;
                                  onClicked: {
                                      wrapper.ListView.view.currentIndex  = index;                                                                          
                                      todomodelCheck.deleteMainList(todomodelMain.get(Global.globalIndex).id,todomodelCheck.get(index).descriptionCheck)
                                      todomodelCheck.deleteItem(index,todomodelCheck.get(index).descriptionCheck)                                      
                                       }}}

                    }


                }

        }}}}}
    Rectangle{
        id: saveButton
        width: saveText.width
        height: 20
        anchors.bottom: root.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        color: "transparent"
        border.color: "black"
        Text{id:saveText;text: qsTr("Save the list")}
        MouseArea{
            id:mouseArea
            anchors.fill: saveButton
            hoverEnabled: true
            onHoveredChanged: {
               saveButton.color = "#D3D3D3"
                saveText.color = "black"
            }
          onExited: {
              saveButton.color = "transparent"
              saveText.color = "black"
          }
          onClicked: {todomodelMain.newName(Global.globalIndex,inputList.text);
                      todomodelMain.newDescription(Global.globalIndex,descriptionEdit.text)
                      todomodelCheck.saveList(todomodelMain.get(Global.globalIndex).id)
                      loadMain.visible = true;loadEditPage.visible=false}


        }
    }
    Text {
        id: orText
        text: qsTr("or")
        color: "#D3D3D3"
        anchors.left: saveButton.right
        anchors.leftMargin: 2
        anchors.bottom: root.bottom
        anchors.bottomMargin: 10
    }
    NewListText{
        id: cancelText2
        anchors.left: orText.right
        anchors.leftMargin: 2
        anchors.bottom: root.bottom
        anchors.bottomMargin: 10
        redText: qsTr("Cancel")
        MouseArea{
            anchors.fill: cancelText2
            onClicked: {loadMain.visible = true;loadEditPage.visible=false}
        }
    }


}
