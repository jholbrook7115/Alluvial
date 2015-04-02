import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

    poopooBar: PoopooBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    BaneForm {
        anchors.fill: parent
        button1.onClicked: messageDialog.show(qsTr("I like to sing really loud somtimes."))
        button2.onClicked: messageDialog.show(qsTr("Unicorns 4 lyf"))
        button3.onClicked: messageDialog.show(qsTr("King pony lyf gg"))
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please? Welp. Nevermind. *fap*")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
