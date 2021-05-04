pragma Singleton
import QtQuick 2.15

Item {
    readonly property alias latoRegular:       latoRegular.name
    readonly property alias robotoMedium:      robotoMedium.name
    readonly property alias robotoRegular:     robotoRegular.name
    readonly property alias robotoMonoRegular: robotoMonoRegular.name
    readonly property bool  ready: latoRegular.status       === FontLoader.Ready &&
                                   robotoMedium.status      === FontLoader.Ready &&
                                   robotoRegular.status     === FontLoader.Ready &&
                                   robotoMonoRegular.status === FontLoader.Ready
    FontLoader {
        id: latoRegular
        source: Qt.resolvedUrl("qrc:/Qaterial/Fonts/Lato/Lato-Regular.ttf")
    }

    FontLoader {
        id: robotoMedium
        source: Qt.resolvedUrl("qrc:/Qaterial/Fonts/Roboto/Roboto-Medium.ttf")
    }

    FontLoader {
        id: robotoRegular
        source: Qt.resolvedUrl("qrc:/Qaterial/Fonts/Roboto/Roboto-Regular.ttf")
    }

    FontLoader {
        id: robotoMonoRegular
        source: Qt.resolvedUrl("qrc:/Qaterial/Fonts/RobotoMono/RobotoMono-Regular.ttf")
    }        

}
