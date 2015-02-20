import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0

ApplicationWindow {
    title: qsTr("Alluvial")
    width: 800
    height: 600
    visible: true

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    Item {
        id: mainWindow

        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        states: [
            State {
                name: "mainView"
                PropertyChanges {
                    target: mainView
                    z: 1
                }
                PropertyChanges {
                    target: itemDetailView
                    z: 0
                }
            },

            State {
                name: "itemDetailView"
                PropertyChanges {
                    target: mainView
                    z: 0
                }
                PropertyChanges {
                    target: itemDetailView
                    z: 1
                }
            }

        ]

        Item {
            id: mainView

            MainView {
                    anchors.left: parent.left
                    anchors.right: playListPanel.left
                    anchors.top: parent.top
                    anchors.bottom: playBackBar1.top
                    x: 0
                    y: 0
            }
        }
        Item {
            id: itemDetailView

            ItemDetailViewForm {
                anchors.left: parent.left
                anchors.right: playListPanel.left
                anchors.top: parent.top
                anchors.bottom: playBackBar1.top
                x: 0
                y: 0
            }
        }

        PlayBackBar {
            id: playBackBar1
        }
        PlaylistPanel{
            id: playListPanel
        }
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
