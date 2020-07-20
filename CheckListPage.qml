import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

import "Global.js" as Global

// This page loads the current model list from checklist model, if item is checked
// the list is saved and the main list is updated.


Rectangle{
    id:root
    visible: true
    width:mainWindow.width
    height:mainWindow.height
    property alias checkListText: listName.text;
    property alias checkListModel:theCheckList.model;
    property alias chekListDescription:descriptionName.text
    property alias anotherItemButtonVisibility:anotherItem.visible

    Image {
        id: checkList
        source: "/images/Images/tada-mark-bg.gif"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
    }
    NewItemListText{
        id: myListText
        anchors.left: checkList.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 15
        blueText: qsTr("My List")
        MouseArea{
            anchors.fill: myListText
            onClicked: {todomodelCheck.saveList(todomodelMain.get(Global.globalIndex).id)
                        todomodelCheck.clearList()
                        todomodelCheck.filterItem(todomodelMain.get(Global.globalIndex).id)
                        todomodelMain.setNotDone(Global.globalIndex,todomodelCheck.getNotDoneCoutner())
                        loadCheckList.visible = false;loadMain.visible=true;loadEnterList.visible=false}
        }
    }
    Text{
    id: thisListText
    anchors.left: myListText.right
    anchors.leftMargin: 10
    anchors.top: parent.top
    anchors.topMargin: 15
    text: qsTr("This list:")}

    NewListText{
        id: editListText
        visible: true
        anchors.left: thisListText.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 15
        redText: qsTr("Edit")
        MouseArea{
        anchors.fill: editListText
        onClicked: {loadEditPage.visible=true;loadEditPage.item.getTextEditor = todomodelMain.get(Global.globalIndex).name;
                    loadMain.visible = false; loadEnterList.visible = false; loadCheckList.visible = false;
                     loadEditPage.item.getTextDescription = todomodelMain.get(Global.globalIndex).description}}
    }
    Text{
        id:dash
        anchors.left: editListText.right
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 15
        text: qsTr("|")
    }
    NewListText{
        id: shareListText
        anchors.left: dash.right
        anchors.leftMargin: 2
        anchors.top: parent.top
        anchors.topMargin: 15
        redText: qsTr("Share")
    }

    Text {
        id: listName
        anchors.top : checkList.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        color: "black"
        font.pointSize: 18
    }
    Text{
        id: descriptionName
        anchors.top: listName.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pointSize: 10
        color: "#808080"

    }

    Rectangle{
        id: checkBoxList
        anchors.top: descriptionName.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: parent.width
        height: 300

        ListView{
            id:theCheckList
            height:  parent.height
            width:  parent.width
            clip: true
            model:todomodelCheck
            delegate: myDelegate
            Component {
                id: myDelegate
                Item {
                    id: wrapper
                    width: parent.width; height: 25
                    Row {
                        CheckBox{
                            id:checkBox
                            checked: doneCheck
                            onClicked:  { wrapper.ListView.view.currentIndex = index
                                          todomodelCheck.setCheck(index);}}
                         Text{text:descriptionCheck}}

                    }

            }
        }
    }

    NewListText{
        id:anotherItem
        redText: "Add another item"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: root.bottom
        anchors.bottomMargin: 5
        MouseArea{
            anchors.fill: anotherItem
            onClicked: {addElement.visible = true;anotherItem.visible = false}
        }
    }
    AddNewCheckElement{
        id:addElement
        visible: false
        anchors.left: root.left
        anchors.leftMargin: 10
        anchors.bottom: root.bottom
        anchors.bottomMargin: 15
        anchors.right: root.right
        anchors.rightMargin: 10

    }



}
