import QtQuick 2.0

/*  This view will hold the Album View and SearchResults View and use states and transitions to
    alternate between the two views as needed, based on the users actions
*/
Rectangle {

    SearchResults{
        id:searchResultsPane
        width: parent.width
        height: parent.height
        color: "#000000"
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

}

