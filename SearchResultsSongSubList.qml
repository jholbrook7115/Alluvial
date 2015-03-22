import QtQuick 2.0
import QtQuick.Layouts 1.1
import Alluvial.Globals 1.0

Rectangle {
    width: searchBarTextField.width
    anchors.top: searchBarTextField.bottom
    anchors.left:parent.left
    //color: "#56B3BF"



    RowLayout{
        id:songHeaderText
        height: nameHeaderBox.height
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
        anchors.bottom: parent.bottom
        height: parent.height - songHeaderText.height - searchResultsButtons.height
        width: parent.width

        ColumnLayout {
            id: songSearchResults
            height: parent.height
            width: parent.width

            ListModel {
                id: songListModel
                ListElement { name: "song0"; artist: "artist"; album: "album"; length: 215; hash: '#1'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song1"; artist: "artist"; album: "album"; length: 346; hash: '#2'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song2"; artist: "artist"; album: "album"; length: 75; hash: '#3'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song3"; artist: "artist"; album: "album"; length: 345; hash: '#4'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: 423; hash: '#5'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: 124; hash: '#6'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: 1456; hash: '#7'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: 563; hash: '#8'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: 543; hash: '#9'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: 463; hash: '#10'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: 82; hash: '#11'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: 129; hash: '#12'; albumArt: 'rawr.jpg'; size: 1024}
                ListElement { name: "song4"; artist: "artist"; album: "album"; length: 180; hash: '#13'; albumArt: 'rawr.jpg'; size: 1024}
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
                            console.log("Opening: " + name + "\nPrior song length: " + Globals.length)
                            mainWindow.state = "showItemDetailView"
                            Globals.hash = hash
                            Globals.songName = name
                            Globals.album = album
                            Globals.albumArt = albumArt
                            Globals.artist = artist
                            Globals.length = length
                            Globals.size = size
                            console.log("Current song length: " + Globals.length)
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
                            text: {
                                if (length % 60 < 10)
                                {
                                    Math.floor(length / 60).toString() + ':0' + Math.floor(length % 60).toString()
                                }
                                else
                                {
                                    Math.floor(length / 60).toString() + ':' + Math.floor(length % 60).toString()
                                }
                            }
                        }

                    }

                }
            }

            ListView {
                id: searchResultsBySong
                anchors.fill: parent
                model: songListModel
                delegate:  songDelegate
                boundsBehavior: Flickable.StopAtBounds
            }

            Scrollbar {
                flickable: searchResultsBySong;
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
