import QtQuick 2.0

/*  This view will hold the Album View and SearchResults View and use states and transitions to
    alternate between the two views as needed, based on the users actions
*/
Rectangle {
    id:mainViewRoot
    width: parent.width
    height: parent.height

    SearchResults{
        id:searchResultsPane
        width: parent.width
        height: parent.height
        anchors.top: searchBarTextField.bottom
        z:0
        color: "#000000"


    }

    AlbumView{
        id:albumViewPane
        width:parent.width
        height:parent.height
        anchors.top: searchBarTextField.bottom
        z:1
    }


    states:[
        State{
            name: "albumToFront"
            PropertyChanges {
                target: albumViewPane
                z: searchResultsPane.z+1;
            }
        },
        State{
            name: "searchResultsToFront"
            when:(searchResultsPane.z <= albumViewPane)
            PropertyChanges {
                target: searchResultsPane
                z: albumViewPane.z+1;
            }
        }

    ]

    SearchBar{
        id:searchBarTextField
        width: parent.width
        height: 35
        anchors.top: parent.top
        anchors.left: parent.left
    }

}

