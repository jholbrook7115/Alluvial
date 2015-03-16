import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import Alluvial.Globals 1.0

ColumnLayout {
    width: parent.width * 0.8
    height: 100
    x: 0
    y: parent.height - 100
    Layout.fillHeight: true
    Layout.minimumHeight: 80
    Layout.maximumHeight: 80

    QtObject {
        id: activeSongMeta
        property string hash: '#0'
        property string songName: "Shake it off"
        property string album: "1989"
        property string albumArt: "rawr.jpg"
        property string artist: "Taylor Swift"
        property int length: 100
        property double size: 1024

        onHashChanged: {
            playbackSlider.value = 0
            timer.running = true
        }
    }

    Rectangle {
        id: playbackBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "#607D8B"

        RowLayout {
            id: sliderRow
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.05
            anchors.top: parent.top
            height: parent.height * 0.5

            Timer {
                id: timer
                interval: 1000
                repeat: true
                triggeredOnStart: false
                onTriggered: {
                    if (playbackSlider.value >= playbackSlider.maximumValue)
                    {
                        timer.stop
                        playButton.state == 'pause'
                    }
                    else
                    {
                        playbackSlider.value += 1
                    }
                }
            }

            Slider {
                id: playbackSlider
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                maximumValue: activeSongMeta.length
                stepSize: 1
                tickmarksEnabled: false

                states: [
                    State {
                        name: 'newSong'
                        PropertyChanges {
                            target: activeSongMeta
                            hash: Globals.hash
                            songName: Globals.songName
                            album: Globals.album
                            albumArt: Globals.albumArt
                            artist: Globals.artist
                            length: Globals.length
                            size: Globals.size
                        }
                    }
                ]

                onValueChanged: {
                    if (Globals.hash !== activeSongMeta.hash)
                    {
                        console.log("Different song chosen" + Globals.hash)
                        timer.running = false
                        playbackSlider.state = 'newSong'
                    }

                    if (playbackSlider.value >= playbackSlider.maximumValue)
                    {
                        playButton.state = 'pause'
                    }
                }

            }

            Item {
                id: statusBar
                anchors.left: playbackSlider.left
                anchors.right: playbackSlider.right
                anchors.top: playbackSlider.bottom
                anchors.bottom: parent.bottom

                Text {
                    id: songStart
                    text: "0:00"
                    anchors.left: parent.left
                }

                Text {
                    id: songPosition
                    text: {
                        if (playbackSlider.value % 60 < 10)
                        {
                            Math.floor(playbackSlider.value / 60).toString() + ':0' + Math.floor(playbackSlider.value % 60).toString()
                        }
                        else
                        {
                            Math.floor(playbackSlider.value / 60).toString() + ':' + Math.floor(playbackSlider.value % 60).toString()
                        }
                    }

                    anchors.centerIn: parent
                }

                Text {
                    id: songEnd
                    text: {
                        if (playbackSlider.maximumValue % 60 < 10)
                        {
                            Math.floor(playbackSlider.maximumValue / 60).toString() + ':0' + Math.floor(playbackSlider.maximumValue % 60).toString()
                        }
                        else
                        {
                            Math.floor(playbackSlider.maximumValue / 60).toString() + ':' + Math.floor(playbackSlider.maximumValue % 60).toString()
                        }
                    }
                    anchors.right: parent.right
                }
            }
        }

        RowLayout {
            id: buttonsRow
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.05
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.05
            anchors.bottom: parent.bottom
            height: parent.height * 0.5

            RowLayout {
                id: playbackOptions
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.05
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width * 0.3

                ToolButton {
                    id: shuffleButton
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    y: (parent.height - this.height) / 2
                    text: "SHF"
                    state: "released"

                    onClicked: {
                        changeButtonState()
                    }

                    states: [
                        State {
                            name: "pressed"
                            PropertyChanges {
                                target: shuffleButton
                                iconName: "pressed_shuffle"
                                iconSource: "icons/pressed_shuffle.png"
                            }
                        },
                        State {
                            name: "released"
                            PropertyChanges {
                                target: shuffleButton
                                iconName: "released_shuffle"
                                iconSource: "icons/shuffle.png"
                            }
                        }
                    ]

                    function changeButtonState() {
                        if (state == "pressed")
                        {
                            state = "released"
                        }
                        else
                        {
                            state = "pressed"
                        }
                    }
                }

                ToolButton {
                    id: repeatButton
                    anchors.right: parent.right
                    anchors.rightMargin: parent.width * 0.05
                    y: (parent.height - this.height) / 2
                    width: parent.width * 0.4
                    text: "RPT"
                    state: "released"

                    onClicked: {
                        changeButtonState()
                    }

                    states: [
                        State {
                            name: "pressed"
                            PropertyChanges {
                                target: repeatButton
                                iconName: "pressed_repeat"
                                iconSource: "icons/pressed_repeat.png"
                            }
                        },
                        State {
                            name: "released"
                            PropertyChanges {
                                target: repeatButton
                                iconName: "released_repeat"
                                iconSource: "icons/repeat.png"
                            }
                        }

                    ]

                    function changeButtonState() {
                        if (state == "pressed")
                        {
                            state = "released"
                        }
                        else
                        {
                            state = "pressed"
                        }
                    }
                }

            }

            RowLayout {
                id: mediaOptions
                anchors.centerIn: parent
                Layout.fillWidth: true
                Layout.minimumWidth: 160
                Layout.maximumWidth: 160

                ToolButton {
                    id: leftSkipButton
                    x: parent.width * 0.05
                    y: (parent.height - this.height) / 2
                    width: parent.width * 0.12
                    text: "<<"
                    iconName: "skip_left"
                    iconSource: "icons/previous.png"
                }

                ToolButton {
                    id: rewindButton
                    x: parent.width * 0.21
                    y: (parent.height - this.height) / 2
                    width: parent.width * 0.12
                    text: "<"
                    iconName: "rewind"
                    iconSource: "icons/player_start.png"
                }

                ToolButton {
                    id: playButton
                    x: parent.width * 0.375
                    y: (parent.height - this.height) / 2
                    width: parent.width * 0.25
                    state: "play"
                    onClicked: {
                        if (playbackSlider.value >= playbackSlider.maximumValue)
                        {
                            playButton.state = 'pause'
                        }
                        else
                        {
                            changePausedState()
                        }
                    }

                    function changePausedState() {
                        if (state == "pause")
                        {
                            state = "play"
                        }
                        else
                        {
                            state = "pause"
                        }
                    }

                    states: [
                        State {
                            name: "pause"
                            PropertyChanges {
                                target: playButton
                                iconName: "play"
                                iconSource: "icons/player_play.png"
                            }
                            PropertyChanges {
                                target: timer
                                running: false
                            }
                        },
                        State {
                            name: "play"
                            PropertyChanges {
                                target: playButton
                                iconName: "pause"
                                iconSource: "icons/player_pause.png"
                            }
                            PropertyChanges {
                                target: timer
                                running: true
                            }
                        }
                    ]
                }

                ToolButton {
                    id: fastForwardButton
                    x: parent.width * 0.67
                    y: (parent.height - this.height) / 2
                    width: parent.width * 0.12
                    text: ">"
                    iconName: "fast_forward"
                    iconSource: "icons/player_fwd.png"
                }

                ToolButton {
                    id: rightSkipButton
                    x: parent.width * 0.83
                    y: (parent.height - this.height) / 2
                    width: parent.width * 0.12
                    text: ">>"
                    iconName: "skip_track"
                    iconSource: "icons/next_track.png"
                }
            }

            RowLayout {
                id: volumeOptions
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.05
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                Slider {
                    id: volumeSlider
                    anchors.right: parent.right
                    width: 10
                    minimumValue: 0
                    maximumValue: 100
                    stepSize: 1
                }

            }
        }
    }
}
