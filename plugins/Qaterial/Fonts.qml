pragma Singleton
import QtQuick 2.15

FontLoader {
    id: fontLoader

    enum FontType {
        LatoRegular,
        RobotoMedium,
        RobotoRegular,
        RobotoMonoRegular
    }

    readonly property alias fontFamily: fontLoader.name

    readonly property bool  ready: fontLoader.status === FontLoader.Ready

    signal loaded()

    function load(font) {
//        console.info(_fonts.get(font))
        if (_fonts.has(font))
            fontLoader.source = Qt.resolvedUrl(_fonts.get(font))
        else
            fontLoader.source = ""
    }

    onStatusChanged: {
//        console.info(status)
        if (status === FontLoader.Ready) {
            fontLoader.loaded()
        }
    }

    readonly property var _fonts: (new Map([
            [Fonts.LatoRegular,       "qrc:/Qaterial/Fonts/Lato/Lato-Regular.ttf"],
            [Fonts.RobotoMedium,      "qrc:/Qaterial/Fonts/Roboto/Roboto-Medium.ttf"],
            [Fonts.RobotoRegular,     "qrc:/Qaterial/Fonts/Roboto/Roboto-Regular.ttf"],
            [Fonts.RobotoMonoRegular, "qrc:/Qaterial/Fonts/RobotoMono/RobotoMono-Regular.ttf"]
    ]))

}
