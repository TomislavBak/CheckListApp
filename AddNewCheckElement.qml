import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

import "Global.js" as Global

// This page opens when Add another item is opened, the name of
// the new item is from the TextEditor and a new item is created.

Rectangle{
    id:addItem
    width: parent.width
    height: 40


    TextField{
        id: enternewCheck
        visible: true
        anchors.top: addItem.top
        anchors.left: addItem.left
        anchors.right: addItem.right
        textColor: "black"
    }

    Image {
        id: addThisItem
        source: "/images/Images/b-add_this_item.gif"
        anchors.left: addItem.left
        anchors.top: enternewCheck.bottom
        anchors.topMargin: 10
        MouseArea{
            anchors.fill: addThisItem
            onClicked: { todomodelCheck.saveList(todomodelMain.get(Global.globalIndex).id)
                        todomodelCheck.addItemIndex(todomodelMain.get(Global.globalIndex).id,enternewCheck.text,false)
                        todomodelCheck.clearList()
                        todomodelCheck.filterItem(todomodelMain.get(Global.globalIndex).id)
                        enternewCheck.text = qsTr("")
                        }
        }
    }
    NewListText{
        id:close
        anchors.left: addThisItem.right
        anchors.leftMargin: 2
        anchors.top: enternewCheck.bottom
        anchors.topMargin: 10
        redText: qsTr("Close")
        MouseArea{
            anchors.fill: close
            onClicked: {addItem.visible = false;loadCheckList.item.anotherItemButtonVisibility = true}
        }
    }




}
