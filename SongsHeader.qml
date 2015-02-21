import QtQuick 2.4
import QtQuick.Layouts 1.0

Rectangle {
    width: 200
    height: 50
    color: "#00000000"
    visible: true

    Text {
        id: text1
        x: 56
        y: 0
        text: qsTr("Songs")
        visible: true
        font.pointSize: 28
    }

Image {
    id: songsExpando
    x: 0
    y: 0
    width: 50
    height: 50
    visible: true
    source: "490px-Magnifying_glass_icon.svg.png"

    states: [
        State {
            name: "unexpanded"
            PropertyChanges {
                target: songsExpando
                rotation: 0
            }

            PropertyChanges {
                target: songsMouseArea
                onClicked: songsExpando.state = "expanded"
            }
        },

        State {
            name: "expanded"
            PropertyChanges {
                target: songsExpando
                rotation: 90
            }

            PropertyChanges {
                target: songsMouseArea
                onClicked: [
                    songsExpando.state = "unexpanded",
                    songsResultsView.state = "unexpanded"
                ]
            }
        }

    ]

    transitions: [
        Transition {
            from: "unexpanded"
            to: "expanded"
            RotationAnimation {
                duration: 259
                direction: RotationAnimation.Shortest
            }
        },

        Transition {
            from: "expanded"
            to: "unexpanded"
            RotationAnimation {
                duration: 259
                direction: RotationAnimation.Shortest
            }
        }
    ]

    MouseArea {
        id: songsMouseArea
        antialiasing: false
        anchors.fill: parent
        opacity: 0
        onClicked: [
            songsExpando.state = "expanded",
            songsResultsView.state = "expanded"
        ]
    }
}
}

