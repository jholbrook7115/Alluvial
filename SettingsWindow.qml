import QtQuick 2.3
import QtQuick.Window 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0
import AlluvialSettings 0.1

/*
  Settings Titles used:
  "spotifyUsername"
  "spotifyPassword"
  "soundcloudUserName"
  "soundcloudPassword"
  "filePath"

  */

Window {
    id:settingsWindow
    width: 500
    height: 400
    visible: true
    modality: Qt.WindowModal
    color: "#d3d3d3"

    //The list of settings which are saved/loaded from the settinsg file
    property string localFolderDirTF: clientSettings.value("filePath", "No Previous Directory Saved").toString();
    property string spotifyCredUserNameTF: clientSettings.value("spotifyUserName", "Username").toString();
    property string spotifyCredPasswordTF: clientSettings.value("spotifyPassword", "Password").toString();
    property string  soundcloudCredUserNameTF: clientSettings.value("soundcloudUserName", "Username").toString();
    property string soundcloudCredPasswordTF: clientSettings.value("soundcloudPassword", "Password").toString();

    FileDialog{
        id: fileBrowserDialog
        title: "Please Select a File or Directory"
        selectExisting: true
        selectMultiple: false
        selectFolder: true
        modality: Qt.WindowModal

        //when a file is selected
         onAccepted: {
             console.log("File/Directory Chosen: " + fileBrowserDialog.fileUrl);
             //clientSettings.setValue("filePath", fileBrowserDialog.fileUrl);
             //TODO: store the file url with the other settings
             //folder = fileBrowserDialog.f
             localFolderDirTF = fileBrowserDialog.fileUrl;

             fileBrowserDialog.close();
         }

         //TODO: instead of close, how about add a dialog to get the user to choose a valid directory?
         onRejected: {
             console.log("File Browser closed by cancel button");
             fileBrowserDialog.close();
         }
    }

    TabView{
        id: tabSettingsWindow
        width:settingsWindow.width
        height: settingsWindow.height
        anchors.bottom: cancelButton.top

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
                    id:spotifyUN
                    text:spotifyCredUserNameTF
                    onEditingFinished:{
                         spotifyCredUserNameTF = spotifyUN.text;
                    }

                    placeholderText: "Spotify Username"
                    width:parent.width
                    height: 30
                    anchors.top: spotifyTitle.bottom

                }
                TextField{
                    id: spotifyPW

                    placeholderText: "Spotify Password"
                    echoMode: TextInput.Password
                    width:parent.width
                    height: 30
                    anchors.top: spotifyUN.bottom
                    text:spotifyCredPasswordTF
                    onEditingFinished: {
                        spotifyCredPasswordTF = spotifyPW.text;
                    }

                }
                Text{
                    id:soundCloudTitle
                    text: "SoundCloud Credentials"
                    font.bold: true
                    font.pixelSize: 20
                    anchors.top:spotifyPW.bottom
                }
                TextField{
                    id: soundCloudUN
                    width: parent.width
                    height: 30
                    anchors.top:soundCloudTitle.bottom
                    text: soundcloudCredUserNameTF
                    onEditingFinished: {
                        soundcloudCredUserNameTF = soundCloudUN.text;
                    }
                    placeholderText: "SoundCloud Username"
                }
                TextField{
                    id: soundCloudPW
                    anchors.top: soundCloudUN.bottom
                    width: parent.width
                    height: 30
                    echoMode: TextInput.Password
                    text: soundcloudCredPasswordTF
                    onEditingFinished: {
                        soundcloudCredPasswordTF = soundCloudPW.text;
                    }
                    placeholderText: "SoundCloud Password"
                }
                Text{
                    id:localFilePathTitle
                    height: 30
                    text: "Local File Path"
                    font.pixelSize: 20
                    font.bold: true
                    anchors.top: soundCloudPW.bottom
                }
                TextField{
                    id: localFilePath
                    width: (parent.width - filePathBrowseButton.width)
                    height: 30
                    readOnly: true
                    text: localFolderDirTF
                    placeholderText: "[Choose a File Path]"
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
            clientSettings.setValue("spotifyUserName", spotifyCredUserNameTF);
            clientSettings.setValue("spotifyPassword", spotifyCredPasswordTF);
            clientSettings.setValue("soundcloudUserName", soundcloudCredUserNameTF);
            clientSettings.setValue("soundcloudPassword", soundcloudCredPasswordTF);
            clientSettings.setValue("filePath", localFolderDirTF);
            clientSettings.sync();

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
            clientSettings.setValue("spotifyUserName", spotifyCredUserNameTF);
            clientSettings.setValue("spotifyPassword", spotifyCredPasswordTF);
            clientSettings.setValue("soundcloudUserName", soundcloudCredUserNameTF);
            clientSettings.setValue("soundcloudPassword", soundcloudCredPasswordTF);
            clientSettings.setValue("filePath", localFolderDirTF);
            clientSettings.sync();
            /*
            clientSettings.setValue("spotifyUserName", spotifyUN.text);
            clientSettings.setValue("spotifyPassword", spotifyPW.text);
            clientSettings.setValue("soundcloudUserName", soundCloudUN.text);
            clientSettings.setValue("soundcloudPassword", soundCloudPW.text);
            clientSettings.setValue("filePath", fileBrowserDialog);
            */
        }

    }



}

