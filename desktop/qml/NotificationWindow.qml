import QtQuick 2.3
import QtQuick.Controls 2.3

Window {
    id: notification
    width: 400; height: 100
    x: Screen.width + 5; y: Screen.height - height - 25
    color: "transparent"
    opacity: 1
    flags: Qt.Popup | Qt.NoDropShadowWindowHint | Qt.WindowStaysOnTopHint

    visible: x >= Screen.width ? false : true

    property string deviceName
    property string appName
    property string headerText
    property string contentText

    Rectangle {
        id: background
        color: "#1e1e1e"
        opacity: 0.8
        anchors.fill: parent
        border.color: "#474b53"
        border.width: 2
        radius: 10
    }

    Text {
        text: deviceName + " - "
        id: device
        height: 14
        width: notification.width / 2
        font.family: "Helvetica"
        font.pointSize: 12
        font.bold: true
        color: "white"
        horizontalAlignment: Text.AlignRight
    }

    Text {
        text: appName
        id: app
        height: 14
        width: notification.width / 2
        font.family: "Helvetica"
        font.pointSize: 12
        font.bold: true
        color: "white"
        anchors.left: device.right
    }

    Text {
        text: headerText
        id: header
        x: parent.x + 10; y: parent.y + 10
        width: parent.width - 20
        height: 28
        maximumLineCount: 1
        font.family: "Helvetica"
        font.pointSize: 14
        font.bold: true
        color: "white"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        anchors.top: device.bottom
    }

    Text {
        x: parent.x + 10; y: parent.y + 10
        width: parent.width - 20
        maximumLineCount: 2
        text: contentText
        id: content
        font.family: "Helvetica"
        font.pointSize: 12
        font.bold: true
        color: "white"
        anchors.top: header.bottom
    }

    ListView {
        id: actions
        x: parent.x + parent.width / 2 + 10; y: parent.y + 10
        width: parent.width - 20
        height: 30;
        anchors.top: content.bottom


        orientation: ListView.Horizontal
        interactive: false
        model: ListModel {
            ListElement {
                name: "Reply"
            }
            ListElement {
                name: "Cancel"
            }
        }
        delegate: Text {
            text: name
            width: 100
            height: parent.height
            verticalAlignment: Text.AlignBottom
            maximumLineCount: 1
            font.family: "Helvetica"
            font.pointSize: 14
            font.bold: true
            color: "#8d91e3"
        }
    }


    Behavior on x {
        SpringAnimation { spring: 8; damping: 10 }
    }

    Behavior on y {
        SpringAnimation { spring: 8; damping: 10 }
    }

    function hideWindow() {
        x = Screen.width + 5
    }

    function showWindow() {
        x = Screen.width - width - 5
    }

    onClosing: {
        close.accepted = false
        application.hideWindow()
    }

    Component.onCompleted: showWindow()

    Timer {
        interval: 15000; running: true; repeat: false
        onTriggered: hideWindow()
    }
}
