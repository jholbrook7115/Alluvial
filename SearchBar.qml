import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.2

Rectangle {
    id:searchTextRoot
    height: 30
    width: parent.width

    TextField{
        id: searchBarTextField

        anchors.fill:parent
        onEditingFinished: {
            //TODO: send the text in the field to somewhere which will actually do something with it
            console.log("Search text input");
            var inputText = getText(0,128);
            mainWindow.state="showSearchResultsPane"
            searchBarTextField.selectAll();
            searchBarTextField.focus=false;
        }
    }
/*Jefferson Holbrook
A lot of the following code with opacity is a bit buggy and could be done better
For now, though, it works.*/
    MouseArea{
        anchors.fill: parent
        opacity: 1
        hoverEnabled: true
        /*
        onEntered: {
            if(searchBarTextField.opacity != 0.5){ }
            else{
                searchBarTextField.opacity = 1;
            }
        }
        onExited: {
            if(searchBarTextField.focus==false){
                searchBarTextField.opacity = 0.5;
            }
        }
        */
        onClicked: {
            searchBarTextField.forceActiveFocus();
        }
    }

}

