import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

Item {
    id: listView
    transformOrigin: Item.Center

    Rectangle {
        anchors.fill: parent
        color: "#ffffff"
    }

    ColumnLayout {
        anchors.fill:parent

        Rectangle {
            id: albumDetail
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.05
            height: parent.height * 0.5
            width: parent.width

            Image {
                id: albumArt
                source: "./container-background.jpg"
                fillMode: Image.PreserveAspectFit
                height: parent.height - artistText.height - albumText.height
                width: parent.width
                opacity: 0.6
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

        Rectangle {
            id: songListBackground
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height * 0.4

            ColumnLayout {
                id:trackListView
                anchors.fill: parent

                ListModel {
                    id: trackListing
                    ListElement {
                        name: "Grey"
                        colorCode: "grey"
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
}

