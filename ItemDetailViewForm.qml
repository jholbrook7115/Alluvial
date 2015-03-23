import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Item {
    id: listView
    transformOrigin: Item.Center

    property string hexcolor: "#000000"

    Rectangle {
        x:0
        y:0
        anchors.fill: parent
        color: hexcolor
        gradient: Gradient{
            GradientStop{position: 0.0; color:"#FFFFFF" }
            //GradientStop{position: 0.7; color:"#75534A" }
            GradientStop{position: 1.0; color:"#000000" }
        }
    }

    states: [
        State {
            name: "showButtonsBehindAlbumImage"
            //change opacity to show buttons behind album art
            PropertyChanges {
                target: albumFullView
                opacity: 0.5
            }
            PropertyChanges {
                target: goToArtistButton
                z: albumArt.z +1

            }
        },
        State {
            name: "showAlbumArt"
            PropertyChanges {
                target: albumFullView
                opacity: 1.0
            }
            PropertyChanges {
                target: goToArtistButton
                z:albumArt.z -1
            }
        }
    ]
    Rectangle{
        id: albumFullView
        anchors.fill: parent
        anchors.margins: 10

        Image {
            id: albumArt
            source: "./container-background.jpg"
            fillMode: Image.PreserveAspectFit
            asynchronous: true
            height:parent.height
            width: parent.width
            opacity: 1


//          height: parent.height - artistText.height - albumText.height
//          width: parent.width

        }
        MouseArea{
            height: parent.height
            width:parent.width
            hoverEnabled: true
            onClicked: {
                if(listView.state=="showButtonsBehindAlbumImage"){
                    console.log("Changing state > FROM: showButtonBehindAlbumImage > TO: showAlbumArt");
                    listView.state="showAlbumArt";
                }
                else if(listView.state=="showAlbumArt"){
                    console.log("Changing state > FROM: showAlbumArt > TO: showButtonBehindAlbumImage");
                    listView.state="showButtonsBehindAlbumImage";
                }
                else{
                    console.log("Changing state > FROM: no state found (initial state) > TO: showButtonBehindAlbumImage")
                    listView.state="showButtonsBehindAlbumImage";
                }
            }
        }

        Button{
            id: goToArtistButton
            x: parent.width * 0.5 - this.width *0.5
            y: parent.height * 0.5
            text: "More By This artist"
            z:-1

        }

        Text {
            id: artistText
            anchors.bottom: albumText.top
            x: parent.width * 0.5 - this.width * 0.5
            text: "Artist: T-Swizzle"
            font.pixelSize: 16
        }

        Text {
            id: albumText
            anchors.bottom: parent.bottom
            x: parent.width * 0.5 - this.width * 0.5
            text: "Album: 1989"
            font.family: "Arial"
            font.bold: true
            font.pixelSize: 16
        }

    }

    /*
    ColumnLayout {
        anchors.fill:parent

        Rectangle {
            id: albumDetail
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.05
            height: parent.height * 0.5
            width: parent.width
            color: "transparent"

            Image {
                id: albumArt
                source: "./container-background.jpg"
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                height:listView.height
                width: listView.width
//                height: parent.height - artistText.height - albumText.height
//                width: parent.width

            }

            Text {
                id: artistText
                anchors.bottom: albumText.top
                x: parent.width * 0.5 - this.width * 0.5
                text: "Artist: T-Swizzle"
                font.pixelSize: 16
            }

            Text {
                id: albumText
                anchors.bottom: parent.bottom
                x: parent.width * 0.5 - this.width * 0.5
                text: "Album: 1989"
                font.family: "Arial"
                font.bold: true
                font.pixelSize: 16
            }
        }
*/
/*
        Rectangle {
            id: songListBackground
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 0.4
            color: "transparent"

            ColumnLayout {
                id:trackListView
                anchors.fill: parent

                ListModel {
                    id: trackListing
                    ListElement {
                        name: "Grey"
                        color: "transparent"
                    }

                    ListElement {
                        name: "Red"
                        colorCode: "red"
                    }

                    ListElement {
                        name: "Blue"
                        colorCode: "blue"
                    }

                    ListElement {
                        name: "Green"
                        colorCode: "green"
                    }
                }

                Component {
                    id: songDelegate
                    Row {
                        x: parent.width * 0.1
                        height: trackName.height
                        width: parent.width * 0.8

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            color: colorCode

                            Text {
                                id: trackName
                                x: parent.x
                                text: name
                                font.pixelSize: 20
                            }
                        }

                    }
                }

                ListView {
                    id: songList
                    //flickableDirection: Flickable.HorizontalAndVerticalFlick
                    anchors.fill: parent
                    delegate: songDelegate
                    model: trackListing
                }
            }
        }
    }
    */
}

