import QtQuick 2.0

import "Global.js" as Global

// This is the main page, and the list from the main model is loaded,
// items from the list that are completed are by the label "Completed lists"

Rectangle{
    id:pageMain
    visible: true
    color: "white"
    width: mainWindow.width
    height: mainWindow.height

    Image {
        id: checkList
        visible: true
        source: "/images/Images/tada-mark-bg.gif"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
    }
    Text {
        id: myListText
        text: qsTr("My Lists")
        anchors.left: checkList.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 15
        font.pointSize: 18
    }
    Text {
        id: lists
        text: qsTr("MY LISTS")
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: checkList.bottom
        anchors.topMargin: 40
    }
    Rectangle{
        id:lineSeparator
        width: parent.width
        height: 1
        anchors.top: lists.bottom
        border.color: "black"
        color: "black"
    }
     Loader{id: pageLoader}
    NewListText{
        id: createList
        anchors.left: myListText.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 30
        redText: qsTr("Create a new list")

        MouseArea{
            anchors.fill: createList
            onClicked: {loadMain.visible = false ; loadEnterList.visible = true ; loadCheckList.visible = false;}
        }
    }

    Rectangle{
        id: listViewBox
        width: parent.width
        height: 200
        anchors.top: lineSeparator.bottom
        anchors.topMargin: 10
        anchors.left: pageMain.left
        anchors.leftMargin: 10
        color: "white"

    ListView{
        anchors.fill: parent
        id: toDoList
        visible: true
        model: todomodelMain
        delegate: myDelegate

        Component {
            id: myDelegate
            Item {
                id: wrapper
                width: listViewBox.width; height: 25
                Row {NewItemListText {id:item; blueText: name }
                    Rectangle{height: 20;width: 5}
                    Rectangle{
                        id:leftText1
                        height: 20
                        width: notDone.width
                    Text{id:notDone;
                        anchors.centerIn: leftText1
                        text: notdone
                        color: "#808080"}}
                     Rectangle{height: 20;width: 5}
                    Rectangle{
                        id:leftText2
                        height: 20
                        width: leftText.width
                    Text{id:leftText
                        anchors.centerIn: leftText2
                        text:qsTr("left")
                        color:"#808080" }}}  //Text { text:+getDescription;horizontalAlignment: Text.AlignVCenter}
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                                wrapper.ListView.view.currentIndex = index
                                loadCheckList.item.checkListText = todomodelMain.get(index).name
                                loadCheckList.item.chekListDescription = todomodelMain.get(index).description
                                Global.globalIndex = wrapper.ListView.view.currentIndex
                                todomodelMain.setIndex(index)
                                todomodelCheck.clearList()
                                todomodelCheck.filterItem(todomodelMain.get(Global.globalIndex).id)
                                loadCheckList.item.checkListModel = todomodelCheck
                                loadCheckList.visible = true


                                 }}
                }

        }

    } Component.onCompleted: {}}
    Text{id:completedListsText
        anchors.top: listViewBox.bottom
        anchors.topMargin: 10
        text: qsTr("Completed lists:")
        anchors.left: parent.left
        anchors.leftMargin: 10
        }

    Rectangle{
        id: completedLists
        anchors.top: listViewBox.bottom
        anchors.topMargin: 10
        anchors.left: completedListsText.right
        anchors.leftMargin: 5
        width: parent.width
        height: 20
        color:"transparent"
        ListView{
            id: completedListView
             orientation: ListView.Horizontal
             anchors.fill: parent
             visible: true
             model: todomodelMain
             delegate: myDelegateCompleted
             Component{
                 id: myDelegateCompleted
                 Item{
                     id: wrapper
                     width: itemsDoneText.width+5; height: 25
                     Row{Text{id:itemsDoneText;text: doneitems}}

                 }
             }

        }
    }


}
