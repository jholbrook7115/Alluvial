import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Item {
    width: 50
    height: 50

    Button {
        id: button1
        width: 50
        text: qsTr("")
        antialiasing: true
        scale: 1
        clip: false
        iconSource: "490px-Magnifying_glass_icon.svg.png"
        tooltip: "Search"
        isDefault: false
        anchors.fill: parent
    }
}

