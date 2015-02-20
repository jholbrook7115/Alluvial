import QtQuick 2.0
import QtQuick.Layouts 1.1

Rectangle {
    width: parent.width
    height: parent.height

    GridLayout{
        id:albumGrid
        columns: 4 //should change this to be set by the width of the MainView

        AnimatedImage{
            id:albumArt1
            width: ((parent.width/4)-10)
            height: ((parent.height)-20)
            anchors.margins: 5
            asynchronous: true
            source:"It's Happening.gif"
        }

        AnimatedImage{
            id:albumArt2
            width: ((parent.width/4)-10)
            height: ((parent.height)-20)
            anchors.margins: 5
            asynchronous: true
            source:"It's Happening.gif"
        }
        AnimatedImage{
            id:albumArt3
            width: ((parent.width/4)-10)
            height: ((parent.height)-20)
            anchors.margins: 5
            asynchronous: true
            source:"It's Happening.gif"
        }
    }

}

