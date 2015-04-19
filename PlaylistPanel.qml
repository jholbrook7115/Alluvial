import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtMultimedia 5.0

ColumnLayout {

    id: playlistPanel

    width: 150
    anchors.top: parent.top
    anchors.bottom: playBackBar.top
    anchors.left: parent.left
    Layout.fillWidth: true
    Layout.minimumWidth: 100
    Layout.fillHeight: true

    states: [
        State {
            name: "hidePlaylist"
            PropertyChanges {
                target: playListPanel
                width:0
            }
        },
        State {
            name: "showPlaylist"
            PropertyChanges {
                target: playListPanel
                width: 150
            }
        }
    ]

    Button{
        y: parent.height/2
        anchors.left: parent.right

        onClicked: {
            if(playListPanel.state=="showPlaylist"){
                playListPanel.state="hidePlaylist"
            }
            else if(playListPanel.state=="hidePlaylist"){
                playListPanel.state="showPlaylist"
            }
            else {
                playListPanel.state="hidePlaylist"
            }
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height

        color: '#E0E0E0'
        Layout.fillWidth: true
        Layout.minimumWidth: 100
        Layout.fillHeight: true
        Layout.minimumHeight: parent.height

        ComboBox {
            objectName: "dropdownPlaylistOptions"
            id: dropdownPlaylistOptions
            width: parent.width
            x:0
            y:0

            model: playlistModel

            signal activePlaylistChanged(int currentIndex);

            onCurrentIndexChanged: {
                dropdownPlaylistOptions.activePlaylistChanged(dropdownPlaylistOptions.currentIndex);
                console.log("Calling changeTrackListings " + currentIndex);
            }
        }

        Rectangle {
            id: playlistTrackListing
            x: 10
            y: dropdownPlaylistOptions.height + 5
            width: parent.width
            height: parent.height
            color: "transparent"

            Layout.fillWidth: true
            Layout.minimumWidth: playListPanel.width
            Layout.fillHeight: true
            Layout.minimumHeight: playListPanel.height

            Component {
                id: track
                Rectangle {
                    color: "red"
                    id: trackItem
                    height: 20
                    width: parent.width
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            mainWindow.state = "showItemDetailView"
                            console.log("Song clicked from playlist pane: " + name)
                        }
                    }

                }
            }

            ListModel {
                    id: qmlModel
                    ListElement { name: "qml entry1 (red)"; colour: "red" }
                    ListElement { name: "qml entry2 (orange)"; colour: "orange" }
                    ListElement { name: "qml entry3 (yellow)"; colour: "yellow" }
                    ListElement { name: "qml entry4 (green)"; colour: "green" }
                    ListElement { name: "qml entry5 (blue)"; colour: "blue" }
                    ListElement { name: "qml entry6 (purple)"; colour: "purple" }
                }

            ListView {
                id: trackListings
                objectName: "trackListings"
                anchors.fill: parent

                delegate: Rectangle {
                    id: trackItem
                    height: 20
                    width: parent.width
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            mainWindow.state = "showItemDetailView"
                            console.log("Song clicked from playlist pane: " + name)
                        }
                    }
                    Text {
                        text: '•' + name
                    }
                }

                function setTrackListings(songNames)
                {
                    console.log("setTrackListings has been called:" + songNames);
                    console.log("Track Model Count: " + trackListings.model.count);

                    for ( var i = trackListings.model.count-1 ; i >= 0 ; i-- )
                    {
                        console.log("Song " + (i+1) + " Pre Delete: " + trackListings.model.get(i).name);
                    }

                    console.log("Song names length: " + songNames.length);
                    for (var i = 0 ; i < songNames.length ; i++)
                    {
                        var data = {name: songNames[i]};
                        cppModel.append(data);
                        console.log("Appending data " + i + ":" + songNames[i] + ": " + data.name);
                    }

                    /*for (var i = 0 ; i < trks.count ; i++)
                    {
                        console.log("Song " + (i+1) + ": " + trks.get(i).name);
                    }*/
                    //console.log("Tracks Model length: " + trackListings.model.count)
                }

            }

        }
    }
}
