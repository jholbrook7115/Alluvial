import QtQuick 2.4
import QtQuick.Layouts 1.1

Rectangle {

    id: searchResultsRoot
    state: "showSongSearchResults"

    SearchResultsHeader {
        id: searchResultsButtons
        z: 2
    }

    SearchResultsSongSubList{
        id:songResultsRow
        anchors.top: searchResultsButtons.bottom
        anchors.bottom: parent.bottom
        anchors.left:parent.left
    }

    SearchResultsAlbumSubList{
        id:albumResultsRow
        anchors.top: searchResultsButtons.bottom
        anchors.bottom: parent.bottom
        anchors.left:parent.left
    }

    states: [ State {
            name: "showSongSearchResults"
            PropertyChanges {
                target: songResultsRow
                z: 1
                enabled: true
                opacity: 1
            }
            PropertyChanges {
                target: albumResultsRow
                z: 0
                enabled: false
                opacity: 0
            }
        },
        State {
            name: "showAlbumSearchResults"
            PropertyChanges {
                target: songResultsRow
                z: 0
                enabled: false
                opacity: 0
            }
            PropertyChanges {
                target: albumResultsRow
                z: 1
                enabled: true
                opacity: 1
            }
        }


    ]

}
