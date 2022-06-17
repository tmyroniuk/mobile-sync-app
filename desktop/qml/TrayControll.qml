import QtQuick 2.9
import QtQuick.Controls 2.5
import Qt.labs.platform 1.1

SystemTrayIcon {
    visible: true
    iconSource: "qrc:/ico/QCicon.png"

    menu: Menu {
        MenuItem {
            text: qsTr("Quit")
            onTriggered: {
                hide()
                Qt.callLater(Qt.quit)
            }
        }
    }
}
