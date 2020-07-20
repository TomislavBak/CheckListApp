import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
// All the pages are loaded in to the window
Window {
    id:mainWindow
    visible: true
    width: 640
    height: 500
    title: qsTr("Check List")   

  Loader{id:loadMain ; source: "MainPage.qml";visible: true}
  Loader{id:loadEnterList; source: "EnterListWindow.qml";visible: false}
  Loader{id:loadCheckList ; source: "CheckListPage.qml";visible: false}
  Loader{id:loadEditPage ; source: "EditListPage.qml";visible: false}


}
