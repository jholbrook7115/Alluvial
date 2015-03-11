import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0

ApplicationWindow {
    id:superRootWindow
    title: qsTr("Alluvial")
    width: 800
    height: 600
    visible: true

    property variant settingsWindow;

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem{
                text: qsTr("&Settings")
                onTriggered: {
                    var component = Qt.createComponent("SettingsWindow.qml");
                    if(component.status === Component.Ready){
                        settingsWindow = component.createObject(superRootWindow);
                        settingsWindow.show;
                    }


                }
            }

            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }
    Window{
        width: 650
        height: 550


    }

    Item {
        id: mainWindow

        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        state: "itemDetailView"

        //TODO: gotta talk about these state names.  They seem confusing to me since
        //they are also the names of the ids used in this file

        states: [
            State {
                name: "showSearchResultsPane"
                PropertyChanges {
                    target: searchResultsPane
                    opacity: 1
                    z: 1
                }
                PropertyChanges {
                    target: itemDetailViewForm
                    opacity: 0
                    z: -1
                    enabled: false
                }
            },

            State {
                name: "showItemDetailView"
                PropertyChanges {
                    target: searchResultsPane
                    opacity: 0
                    z: -1
                    enabled: false
                }
                PropertyChanges {
                    target: itemDetailViewForm
                    opacity: 1
                    z: 1
                }
            }

        ]


        SearchResults{
            id:searchResultsPane
            color: "#000000"

            anchors.left: parent.left
            anchors.right: playListPanel.left
            anchors.top: searchBarTextField.bottom
            anchors.bottom: playBackBar.top
        }

        ItemDetailViewForm {
            id: itemDetailViewForm
            anchors.left: parent.left
            anchors.right: playListPanel.left
            anchors.top: searchBarTextField.bottom
            anchors.bottom: playBackBar.top
        }

        PlayBackBar {
            id: playBackBar
            z: 2
        }
        PlaylistPanel{
            id: playListPanel
            z: 2
        }

        SearchBar{
            id:searchBarTextField
            height: 35
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: playListPanel.left
        }
    }
}
