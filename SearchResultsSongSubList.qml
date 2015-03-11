import QtQuick 2.0
import QtQuick.Layouts 1.1

Rectangle {
    width: searchBarTextField.width
    anchors.top: searchBarTextField.bottom
    anchors.left:parent.left
    //color: "#56B3BF"

    Text {
        anchors.top: parent.top
        id: songSearchTitle
        text:"Songs"
        font.bold: true
        font.pixelSize: 30
        color: "#000000"
    }

    RowLayout{
        id:songHeaderText
        anchors.top:songSearchTitle.bottom
        anchors.topMargin: 5
        width: parent.width

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            height: nameHeader.height
            color: "#FFFFFF"
        }

        Rectangle {
            id: nameHeaderBox
            anchors.left: parent.left
            width: parent.width * 0.4

            Text {
                id: nameHeader
                text:"Song Title"
                font.bold: true
                font.pixelSize: 16
                color: "#000000"
                width: parent.width
            }
        }

        Rectangle {
            id: artistHeaderBox
            anchors.left: nameHeaderBox.right
            width: parent.width * 0.2

            Text {
                id: artistHeader
                text:"Artist"
                font.bold: true
                font.pixelSize: 16
                color: "#000000"
                width: parent.width
            }
        }

        Rectangle {
            id: albumHeaderBox
            anchors.left: artistHeaderBox.right
            width: parent.width * 0.2

            Text {
                id: albumHeader
                text:"Album"
                font.bold: true
                font.pixelSize: 16
                color: "#000000"
                width: parent.width
            }
        }

        Rectangle {
            id: lengthHeaderBox
            anchors.left: albumHeaderBox.right
            width: parent.width * 0.2

            Text {
                id: lengthHeader
                text:"Length"
                font.bold: true
                font.pixelSize: 16
                color: "#000000"
                width: parent.width
            }
        }

    }
    Rectangle {
        anchors.top: songHeaderText.bottom
        height: parent.height - songHeaderText.height - songSearchTitle.height
        width: parent.width

        ColumnLayout {
            id: songSearchResults
            height: parent.height
            width: parent.width

            ListModel {
                id: songListModel
                ListElement { name: "song0"; artist: "artist"; album: "album"; length: "3:43"}
                ListElement { name: "song1"; artist: "artist"; album: "album"; length: "3:16"}
                ListElement { name: "song2"; artist: "artist"; album: "album"; length: "4:04"}
                ListElement { name: "song3"; artist: "artist"; album: "album"; length: "5:00"}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: "9:11"}
            }

            Component {
                id: songDelegate
                Row {
                    width: parent.width
                    height: 20

                    MouseArea {
                        width: parent.width
                        height: 20
                        onDoubleClicked:
                        {
                            console.log("Opening: " + name)
                            mainWindow.state = "showItemDetailView"

                        }
                    }

                    Rectangle {

                        Text {
                            x: nameHeaderBox.x
                            text: name
                        }
                        Text {
                            x: artistHeaderBox.x
                            text: artist
                        }
                        Text {
                            x: albumHeaderBox.x
                            text: album
                        }
                        Text {
                            x: lengthHeaderBox.x
                            text: length
                        }

                    }

                }
            }

            ListView {
                id: searchResultsBySong
                anchors.fill: parent
                model: songListModel
                delegate:  songDelegate
            }

        }
    }


    //ideally this function will build an array from data that we will get from the server upon requets from the client's search bar
    //for now however, it creates a mock array which will hold dummy variables that will populate the ListModel below
    //NOTE: WIP
    function buildSongMetaDataArray(){
        var songMetaDataList = [0, 1, 2, 3, 4,];
        var songMetaData = [0, 1, 2, 3];
        for(i=0; i<10;i++){
            songMetaData[0] = "Song-Name";
            songMetaData[1] = "Artist";
            songMetaData[2] = "Album";
            songMetaData[3] = "5:24";
            }
        }

}
