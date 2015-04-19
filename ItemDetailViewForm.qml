import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import Alluvial.Globals 1.0

Item {
    id: listView
    transformOrigin: Item.Center

    property string hexcolor: "#5599FF"

    Rectangle {
        anchors.fill: parent
        color: "#FFFFFF"
    }

    QtObject {
        id: songMeta
        property string hash: Globals.hash
        property string songName: Globals.songName
        property string album: Globals.album
        property string albumArt: Globals.albumArt
        property string artist: Globals.artist
        property int length: Globals.length
        property double size: Globals.size

        onHashChanged: {
            songName: Globals.songName
            album: Globals.album
            albumArt: Globals.albumArt
            artist: Globals.artist
            length: Globals.length
            size: Globals.size
        }
    }

    ColumnLayout {
        anchors.fill:parent

        Rectangle {
            id: albumDetail
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.05
            anchors.fill: parent
            anchors.bottomMargin: parent.height * 0.05
			color: "transparent"

            Image {
                id: albumArt
                source: songMeta.albumArt
                fillMode: Image.PreserveAspectFit
                height: parent.height - artistText.height - albumText.height - songText.height - spacer.height
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: parent.width * 0.05
                anchors.rightMargin: parent.width * 0.05
            }

            Rectangle {
                id: spacer
                anchors.bottom: songText.top
                height: songText.height
            }

            Text {
                id: songText
                anchors.bottom: artistText.top
                x: parent.width * 0.5 - this.width * 0.5
                text: "Song: " + songMeta.songName
                font.bold: true
                font.pixelSize: 16
            }

            Text {
                id: artistText
                anchors.bottom: albumText.top
                x: parent.width * 0.5 - this.width * 0.5
                text: "Artist: " + songMeta.artist
                font.pixelSize: 16
            }

            Text {
                id: albumText
                anchors.bottom: parent.bottom
                x: parent.width * 0.5 - this.width * 0.5
                text: "Album: " + songMeta.album
                font.family: "Arial"
                font.bold: true
                font.pixelSize: 16
            }
        }
    }
}

