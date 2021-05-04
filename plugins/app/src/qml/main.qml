import QtQuick 2.15
import QtQuick.Controls 2.15

import Qaterial 1.0 as Qaterial

ApplicationWindow {
    id: appWindow
    visible: true
    width: 640
    height: 480
    title: "Playground"

    Component.onCompleted: {
        Qaterial.Logger.info("Qml: version is " + Qaterial.Version.readable)
        Qaterial.Logger.debug("Qml: " + "Component.onCompleted")
    }

    FontLoader { id: webFont; source: Qt.resolvedUrl(":/Qaterial/Fonts/Lato/Lato-Regular.ttf") }

    Grid {
        anchors.fill: parent
        columns: 2

        Text { text: "Lato-Regular font"; font.family: webFont.name }

        Qaterial.RawMaterialButton {
            drawline: true //background in aquamarine and outline in pink
        }

        Image {
            source: Qaterial.Icons.heart
        }

        Qaterial.AMaterialColorPaletteGrid {
            id: aMaterialColorPaletteGrid
            onAccepted: alertDialog.open()
        }

        Qaterial.AlertDialog {
            id: alertDialog
            title: qsTr("Qaterial Alert Dialog")
        }

        Text {
            id: clipboardText
            //        text: Qaterial.Clipboard.text
        }

        Qaterial.ColorTheme {
            id: colorTheme
        }

        Qaterial.IconDescription {
            id: iconDescription
        }

        Qaterial.IconLabelImpl {
            id: iconLabelImpl
        }

        Qaterial.IconLabelPositionner {
            id: iconLabelPositionner
        }

        Flow {
            id: flow
            Qaterial.Layout
            {
                items: flow.children

                width: flow.width
                height: flow.height

                spacing: flow.spacing

                leftPadding: flow.leftPadding
                rightPadding: flow.rightPadding
                topPadding: flow.topPadding
                bottomPadding: flow.bottomPadding

                layoutDirection: Qt.LayoutDirectionAuto
                flow: Qaterial.Layout.LeftToRight
            }
        }

        Qaterial.TextFile {
            id: textFile
        }

        Qaterial.TextTheme {
            id: textTheme
        }

        Qaterial.Theme {
            id: theme
        }
    }
}
