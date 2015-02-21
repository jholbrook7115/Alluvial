import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {
    id: item1
    width: 640
    height: 800

    SearchResultsView {
        id: songsResultsView
        width: parent.width
        y: 140
        height: 660
        anchors.right: parent.right
        anchors.rightMargin: -49
        anchors.left: parent.left
        anchors.leftMargin: 65
    }

    SearchBarComponent {
        id: searchBarComponent1
        anchors.top: parent.top
        anchors.topMargin: 34
        anchors.bottom: songsResultsView.top
        anchors.bottomMargin: 32
        anchors.right: parent.right
        anchors.rightMargin: 111
        anchors.left: parent.left
        anchors.leftMargin: 111
    }

}
