import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0


Window {
    id:settingsWindow
    width: 500
    height: 400
    visible: true
    color: "#d3d3d3"
    property string localFolderDir: "file path"
    property string spotifyUserName: "Spotify UserName"
    property string spotifyPassword: "spotify Password"
    Settings{

    }

    /*
    Settings{
        category: "CredentialsAndLogins"
        Settings{
            category: "SpotifyCreds"
        }
        Settings{
            category: "SoundcloudCreds"
        }


    }
    Settings{
        //property alias fileSaveyThingyDirectory: fileBrowserDialog.fileUrl
    }
*/
    FileDialog{
        id: fileBrowserDialog
        title: "Please Select a File or Directory"
        selectExisting: true
        selectMultiple: false
        selectFolder: true

        //when a file is selected
         onAccepted: {
             console.log("File/Directory Chosen: " + fileBrowserDialog.fileUrls);
             //TODO: store the file url with the other settings
             //folder = fileBrowserDialog.f
             localFolderDir = fileBrowserDialog.fileUrl;
             fileBrowserDialog.close();
         }
         onRejected: {
             console.log("File Browser closed by cancel button");
             fileBrowserDialog.close();
         }
    }

    TabView{
        id: tabSettingsWindow
        width:settingsWindow.width
        height: settingsWindow.height-75


        Tab{
            id: tabSettingsCredentials
            title: "Streaming Sources"
            width: parent.width
            height:parent.height

            Rectangle{
                id:soundCloudCred
                anchors.fill:parent
                anchors.leftMargin: 5
                anchors.rightMargin: 8
                Text{
                    id: spotifyTitle
                    text: "Spotify Credentials"
                    font.pixelSize: 20
                    height:30
                    font.bold: true
                    anchors.top:parent.top
                }
                TextField{
                    id:spotifyUserName
                    text:"Spotify username"
                    width:parent.width
                    height: 30
                    anchors.top: spotifyTitle.bottom

                }
                TextField{
                    id: spotifyPassWord
                    text:"Spotify password"
                    width:parent.width
                    height: 30
                    anchors.top: spotifyUserName.bottom
                    //anchors.bottom: spotifyCred.bottom
                    //input for
                }
                Text{
                    id:soundCloudTitle
                    text: "SoundCloud Credentials"
                    font.bold: true
                    font.pixelSize: 20
                    anchors.top:spotifyPassWord.bottom
                }

                TextField{
                    id: soundCloudUserName
                    width: parent.width
                    height: 30
                    anchors.top:soundCloudTitle.bottom
                    text:"SoundCloud username"
                }

                TextField{
                    id: soundCloudPassWord
                    anchors.top: soundCloudUserName.bottom
                    width: parent.width
                    height: 30
                    text:"SoundCloud password"
                }
                Text{
                    id:localFilePathTitle
                    height: 30
                    text: "Local File Path"
                    font.pixelSize: 20
                    font.bold: true
                    anchors.top: soundCloudPassWord.bottom
                }
                TextField{
                    id: localFilePath
                    width: (parent.width - filePathBrowseButton.width)
                    height: 30
                    text: localFolderDir
                    anchors.top: localFilePathTitle.bottom
                    anchors.left:parent.left

                }

                Button{
                    id:filePathBrowseButton
                    text:"Browse"
                    anchors.top: localFilePathTitle.bottom
                    anchors.right: parent.right
                    height: localFilePath.height
                    onClicked: {
                        console.log("filePathBrowserButton clicked");
                        fileBrowserDialog.open();
                    }
                }

            }
        }
        Tab{
            id: tabSettingsPlayback
            title: "PlayBack"
            width:settingsWindow.width
            height: settingsWindow.height-75
        }
        Tab{
            id: tabSettingsServerSettings
            title: "Server Settings"
            width:settingsWindow.width
            height: settingsWindow.height-75
        }
        Tab{
            id: tabSettingsAccountMgt
            title: "Account Mgt"
            width:settingsWindow.width
            height: settingsWindow.height-75
        }

        Tab{
            id: tabSettingsMisc
            title: "Misc"
            width:settingsWindow.width
            height: settingsWindow.height-75
        }
    }
    Button{
        id:cancelButton
        text:"Cancel"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            //if( current_settings_values != config_file_values){
            //      prompt user if they want to quit without saving settings
            // }
            console.log("(SettingsWindow) >> Clicked:Cancel Setting Button");
            settingsWindow.close();
        }
    }
    Button{
        id:okayButton
        text:"OK"
        anchors.right: cancelButton.left
        anchors.bottom: parent.bottom
        onClicked: {
//            if(current_settings_values != config_file_values){
//            save settings to the config file
//            }
            console.log("(SettingsWindow) >> Clicked:Ok Setting Button");
            settingsWindow.close();
        }
    }
    Button{
        id:applyButton
        text:"Apply"
        anchors.right: okayButton.left
        anchors.bottom: parent.bottom
        onClicked: {
//            if(current_settings_values != config_file_values){
//              save settings to the config file
//            }
            console.log("(SettingsWindow) >> Clicked:Apply Setting Button");
        }

    }




}

