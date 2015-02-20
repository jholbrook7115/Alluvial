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
        height: 250
        width:parent.width
        anchors.top:parent.top
        anchors.left:parent.left

    }

    SearchResultsAlbumSubList{
        id:albumResultsRow
        height: 250
        width: parent.width
        anchors.top:songResultsRow.bottom
        anchors.left:parent.left

    }

    /* width: {
            function displayAlbums()twoChainz.width }
    */
    function determineRowType(){

    }

}

