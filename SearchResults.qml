import QtQuick 2.4
import QtQuick.Layouts 1.1

Rectangle {

    id: searchResultsRoot

    Rectangle{
        width: 10
        height: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.rightMargin: 15
        color: "#56FF00"
        z: 2
        MouseArea{
            anchors.fill: parent
            onClicked: {
                mainWindow.state="showItemDetailView";
                searchBarTextField.focus=true;
            }
        }
    }

    SearchResultsSongSubList{
        id:songResultsRow
        width:parent.width
        anchors.top:parent.top
        height: parent.height * 0.5
        anchors.left:parent.left
        z:1
    }

    SearchResultsAlbumSubList{
        id:albumResultsRow
        width: parent.width
        height: parent.height * 0.5
        anchors.bottom: parent.bottom
        anchors.left:parent.left
    }

}
