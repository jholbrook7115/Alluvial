import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

ColumnLayout {
    width: parent.width * 0.8
    height: 80
    x: 0
    y: parent.height - 80
    Layout.fillHeight: true
    Layout.minimumHeight: 80
    Layout.maximumHeight: 80

    Rectangle {
        id: playbackBar
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "#56B3BF"
        Layout.fillWidth: true
        Layout.minimumWidth: 300
        Layout.fillHeight: true
        Layout.minimumHeight: 80
        Layout.maximumHeight: 80

        Row {
            id: sliderRow
            x: parent.width * 0.05
            y: parent.height * 0.05
            width: parent.width * 0.9
            height: parent.height * 0.25

            Slider {
                id: playbackSlider
                x: 0
                y: 0
                width: parent.width
                height: parent.height
            }
        }

        RowLayout {
            id: buttonsRow
            x: parent.width * 0.05
            y: parent.height * 0.35
            width: parent.width * 0.9
            height: parent.height * 0.5

            RowLayout {
                id: playbackOptions
                x: 0
                y: 0
                width: layout.implicitWidth
                height: layout.implicitHeight
                Layout.fillWidth: true
                Layout.minimumWidth: 50
                Layout.maximumWidth: 80

                ToolButton {
                    id: shuffleButton
                    x: parent.width * 0.05
                    y: parent.Center
                    width: parent.width * 0.4
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

/*                    transitions: [
                        Transition {
                            from: "pressed"; to: "released"
                            PropertyAnimation {
                                target: shuffleButton
                                properties: "iconSource"
                                duration: 500
                            }
                        },
                        Transition {
                            from: "released"; to: "pressed"
                            PropertyAnimation {
                                target: shuffleButton
                                properties: "iconSource"
                                duration: 500
                            }
                        }

                    ]
*/

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
                    x: parent.width * 0.55
                    y: parent.Center
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
                x: parent.width * 0.5 - ( this.width / 2 )
                y: 0
                width: layout.implicitWidth
                height: layout.implicitHeight
                Layout.fillWidth: true
                Layout.minimumWidth: 160
                Layout.maximumWidth: 160

                ToolButton {
                    id: leftSkipButton
                    x: parent.width * 0.05
                    y: parent.Center
                    width: parent.width * 0.12
                    text: "<<"
                    iconName: "skip_left"
                    iconSource: "icons/previous.png"
                }

                ToolButton {
                    id: rewindButton
                    x: parent.width * 0.21
                    y: parent.Center
                    width: parent.width * 0.12
                    text: "<"
                    iconName: "rewind"
                    iconSource: "icons/player_start.png"
                }

                ToolButton {
                    id: playButton
                    x: parent.width * 0.375
                    y: parent.Center
                    width: parent.width * 0.25
                    state: "pause"
                    onClicked: {
                        changePausedState()
                    }
                    text: state

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
                            name: "play"
                            PropertyChanges {
                                target: playButton
                                iconName: "play"
                                iconSource: "icons/player_play.png"
                            }
                        },
                        State {
                            name: "pause"
                            PropertyChanges {
                                target: playButton
                                iconName: "pause"
                                iconSource: "icons/player_pause.png"
                            }
                        }
                    ]
                }

                ToolButton {
                    id: fastForwardButton
                    x: parent.width * 0.67
                    y: parent.Center
                    width: parent.width * 0.12
                    text: ">"
                    iconName: "fast_forward"
                    iconSource: "icons/player_fwd.png"
                }

                ToolButton {
                    id: rightSkipButton
                    x: parent.width * 0.83
                    y: parent.Center
                    width: parent.width * 0.12
                    text: ">>"
                    iconName: "skip_track"
                    iconSource: "icons/next_track.png"
                }
            }
        }
    }
}
