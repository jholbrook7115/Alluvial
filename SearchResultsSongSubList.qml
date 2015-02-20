import QtQuick 2.0
import QtQuick.Layouts 1.1

Rectangle {
    width: searchBar.width
    height: parent.height
    anchors.top: searchBar.bottom
    anchors.left:parent.left
    color: "#56B3BF"
    Text{
        id:songHeaderText
        text:"Songs"
        font.bold: true
        font.pixelSize: 30

        color: "#000000"
        anchors.top:parent.top
        anchors.topMargin: 5
    }
    GridLayout{
        id:songListGrid
        anchors.top:songHeaderText.bottom
        columns: 4

        Text{text:"Song-name"; color: "#6A7E25"; font.pixelSize: 20; font.bold: true}
        Text{text:"Artist"; color: "#6A7E25"; font.pixelSize: 20; font.bold: true}
        Text{text:"Album"; color: "#6A7E25"; font.pixelSize: 20; font.bold: true}
        Text{text:"Song-Length"; color: "#6A7E25"; font.pixelSize: 20; font.bold: true}

        Text{text:"Song-name"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Artist"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Album"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Song-Length"; color: "#FF00EF"; font.pixelSize: 15}

        Text{text:"Song-name"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Artist"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Album"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Song-Length"; color: "#FF00EF"; font.pixelSize: 15}

        Text{text:"Song-name"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Artist"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Album"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Song-Length"; color: "#FF00EF"; font.pixelSize: 15}

        Text{text:"Song-name"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Artist"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Album"; color: "#FF00EF"; font.pixelSize: 15}
        Text{text:"Song-Length"; color: "#FF00EF"; font.pixelSize: 15}

    }




    //ideally this function will build an array from data that we will get from the server upon requets from the client's search bar
    //for now however, it creates a mock array which will hold dummy variables that will populate the ListModel below
    //NOTE: WIP
    function buildSongMetaDataArray(){
        var songMetaDataList = [0, 1, 2, 3, 4,];
        var songMetaData = [0, 1, 2, 3];
        for(i=0; i<10;i++){
            songMetaData[0] = "Song-Name";
            songMetaData[1] = "Artist";
            songMetaData[2] = "Album";
            songMetaData[3] = "5:24";
            }
        }

}
