import QtQuick 2.15
import QtQuick.Controls 2.15

import Qaterial 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Playground"

    Component.onCompleted: {
        Logger.info("Qml: version is " + Version.readable)
        Logger.debug("Qml: " + "Component.onCompleted")
    }

}
