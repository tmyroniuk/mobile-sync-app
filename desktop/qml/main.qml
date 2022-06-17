import QtQuick 2.3
import QtQuick.Controls 2.3

Window {
    id: main
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    property var ntf

    function createNotification(device, app, header, text) {
        var component = Qt.createComponent("NotificationWindow.qml");
        var incubator = component.incubateObject(main, {deviceName: device, appName: app, headerText: header, contentText: text});
        if (incubator.status !== Component.Ready) {
            incubator.onStatusChanged = function(status) {
                if (status === Component.Ready) {
                    print("Object", incubator.object, "is now ready!");
                }
            };
        } else {
            print("Object", incubator.object, "is ready immediately!");
        }
        ntf = component
    }

}
