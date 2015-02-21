import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2



Item {
    id: item1
    width: 500
    height: 50

    Rectangle {
        id: background
        height: 50
        color: "#262626"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: searchBarButton1.left
        anchors.rightMargin: 0

        TextInput {
            id: searchInput
            color: "#f8f8f2"
            text: qsTr("Search...")
            anchors.fill: parent
            font.pointSize: 26
            selectionColor: "#996def"
        }
    }

    SearchBarButton {
        id: searchBarButton1
        x: 450
        y: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
    }

}

