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
    Grid {
        anchors.fill: parent
        columns: 5
        Image {
            source: Qaterial.Icons.heart
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
