import QtQuick 2.4
import QtQuick.Layouts 1.1

Rectangle {
//To Start I am focuing on getting just a list of songs as a result of the user's search
    //other stuff coming soon!

    id: searchResultsRoot

    Rectangle{
        width: 5
        height: 5
        anchors.right: parent.right
        anchors.top: parent.top
        color: "#56FF00"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                mainViewRoot.state="albumToFront";
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

    /* width: {
            function displayAlbums()twoChainz.width }
    */
    function determineRowType(){

    }

}
