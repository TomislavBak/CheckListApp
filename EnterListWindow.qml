import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4

import "Global.js" as Global

// The page is oppened when "Create a new list button" is clicked, when
// "Create this list" button is pressed , a new item is created in the main
// list

Rectangle{
    id:pageEnterList
    visible: true
    width:mainWindow.width
    height:mainWindow.height
    color: "white"

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
            onClicked: {loadEnterList.visible = false; loadMain.visible = true}
        }

    }
    Text {
        id: nameListText
        text: qsTr("Name your new list")
        anchors.top: checkList.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 10
        color: "black"
        font.pointSize: 15
    }
    Text{
        id: nameEcampleText
        text: qsTr("(Ex: 'Things i need to do today')")
        anchors.left: nameListText.right
        anchors.leftMargin: 5
        anchors.top: checkList.bottom
        anchors.topMargin: 30
        anchors.bottom: inputList.top
        color:"#808080"
        font.pointSize: 7
    }

    TextField{
        id: inputList
        property alias getTextEditor:inputList.text
        width: parent.width
        height: 40
        anchors.top: nameListText.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
        textColor: "black"
        focus: true

    }


    NewListText{
        id: cancelText
        redText: qsTr("Cancel")
        anchors.left: orText.right
        anchors.leftMargin: 3
        anchors.top: inputList.bottom
        anchors.topMargin: 10
        MouseArea{
            anchors.fill: cancelText
            onClicked: {loadEnterList.visible = false;loadMain.visible = true }
        }

    }
    Text {
        id: orText
        text: qsTr("or")
        color: "black"
        anchors.left: acceptNewList.right
        anchors.leftMargin: 3
        anchors.top: inputList.bottom
        anchors.topMargin: 10
    }

    Loader{id: pageLoaderCheckList}
    Image {
        id: acceptNewList
        visible: true
        source: "/images/Images/b-create_this_list.gif"
        anchors.top: inputList.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        MouseArea{
            anchors.fill: acceptNewList
            onClicked: {loadCheckList.visible = false;loadMain.visible = true;loadEnterList.visible=false;
                        todomodelMain.addList(inputList.getTextEditor,qsTr(""));
                        todomodelCheck.clearList()
                        inputList.text = qsTr("")
                        }

        }
    }

}

