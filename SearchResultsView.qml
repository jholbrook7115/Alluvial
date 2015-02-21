import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

Item {
    id: item1
    width: 1000
    height: 500

    SongsHeader {
        id: songsHeader
        x: 8
        y: 8
    }

    GridLayout {
        id: gridLayout1
        x: 4
        y: -240
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 4
        anchors.bottom: parent.bottom
        Layout.maximumWidth: parent.width
        anchors.bottomMargin: 0
        anchors.top: songsHeader.bottom
        anchors.topMargin: 6
        columns: 1

        SplitView {
            id: splitView1
            height: 35
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            Layout.maximumWidth: parent.width
            anchors.rightMargin: 0

            Column {
                id: trackNumbersText
                width: 200
                height: parent.height
                Layout.minimumWidth: columnHeaderText.width

                Text {
                    id: trackNumAnchor
                    text: qsTr("TrNum")
                    font.pixelSize: 12
                }
            }

            Column {
                id: tracksText
                width: 200
                height: parent.height
                Layout.minimumWidth: trackAnchor.width

                Text {
                    id: trackAnchor
                    text: qsTr("Track")
                    font.pixelSize: 12
                }
            }

            Column {
                id: artistText
                width: 200
                height: parent.height
                Layout.minimumWidth: artistAnchor.width

                Text {
                    id: artistAnchor
                    text: qsTr("Artist")
                    font.pixelSize: 12
                }
            }
            Column {
                id: albumText
                width: 200
                height: parent.height
                Layout.minimumWidth: albumAnchor.width

                Text {
                    id: albumAnchor
                    text: qsTr("Album")
                    font.pixelSize: 12
                }
            }
        }
    }

}

