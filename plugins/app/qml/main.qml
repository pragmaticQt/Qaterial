import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml 2.15

import Qaterial 1.0 as Qaterial


ApplicationWindow {
    id: appWindow
    visible: true
    width: 1024
    height: 768
    title: "Playground"
    color: "darkgray"

    Component.onCompleted: {
        Qaterial.Logger.info("Qml: version is " + Qaterial.Version.readable)
        Qaterial.Logger.debug("Qml: " + "Component.onCompleted")

        Qaterial.Fonts.load(Qaterial.Fonts.LatoRegular)
    }

    Connections {
        target: Qaterial.Fonts
        function onLoaded() {
            loader.setSource( Qt.resolvedUrl("qrc:/TextUsingQaterialFonts.qml"),
                             {"font.family": Qaterial.Fonts.fontFamily, "text": "some text"} )
        }
    }

    Grid {
        anchors.fill: parent
        columns: 2

        TextUsingQaterialFonts {
            text: "some text"
        }

        Loader {
            id: loader
        }

        Qaterial.TextField {
            drawline: true //background in aquamarine and outline in pink
        }

        Row {
            Image {
                source: Qaterial.Icons.youtube
            }
            Image {
                source: Qaterial.Icons.facebook
            }
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

        //        Flow {
        //            id: flow
        //            Qaterial.Layout
        //            {
        //                items: flow.children

        //                width: flow.width
        //                height: flow.height

        //                spacing: flow.spacing

        //                leftPadding: flow.leftPadding
        //                rightPadding: flow.rightPadding
        //                topPadding: flow.topPadding
        //                bottomPadding: flow.bottomPadding

        //                layoutDirection: Qt.LayoutDirectionAuto
        //                flow: Qaterial.Layout.LeftToRight
        //            }
        //        }

        Qaterial.TextFile {
            id: textFile
        }

        Qaterial.TextTheme {
            id: textTheme
        }

        Qaterial.Theme {
            id: theme
        }


        Item
        {
            width: stepper.width
            height: stepper.height

            Qaterial.Stepper
            {
                id: stepper

                // Stepper has implicitWidth / Height

                // Dimension properties
                indicatorWidth: 64
                indicatorHeight: indicatorWidth

                contentItemWidth: 150
                contentItemHeight: 32

                separatorHeight: 10
                separatorWidth: 10

                // Clickable property which allow the user to click on the step to display it
                clickable: false
                // Vertical property which display vertically the stepper instead of horizontally
                vertical: false

                // HorizontalStepper model is a StepperModel Item which is a list of StepperElement
                // Those StepperElement can have properties like text, done, alertMessage, etc ...
                model: Qaterial.StepperModel
                {
                    Qaterial.StepperElement {}
                    Qaterial.StepperElement {}
                    Qaterial.StepperElement {}
                } // StepperModel

                // Separator, Indicator and ContentItem are 3 customizable Components
                separator: Rectangle
                {
                    color: Qaterial.Style.accentColor
                    height: 10
                    width: 10
                }
                indicator: Rectangle
                {
                    color: "pink"
                    width: 64
                    height: 64
                }
                contentItem: Rectangle
                {
                    color: Qaterial.Style.blue
                    width: 150
                    height: 32
                }
            } // HorizontalStepper
        } // Item

        Qaterial.TreeView
        {
            id: treeView

            width: 300
            height: parent ? Math.min(contentHeight, parent.height) : contentHeight

            property QtObject selectedElement

            model: Qaterial.FolderTreeModel
            {
                // sortField: Qaterial.FolderTreeModel.Type/Name/Size/Time
                // sortReversed: true
                // sortCaseSensitive: false
                //
                // showDotAndDotDot: true
                // showDrives: false
                // showDirs: false
                // showFiles: false
                // showHidden: true
                // showOnlyReadable: true
                //
                // nameFilters: [ "*.qml", "*.cpp" ]
                // caseSensitive: true
                //
                // path: file:///Path/To/Folder
                Component.onCompleted: () => fetch()
            }

            itemDelegate: Qaterial.ItemDelegate
            {
                id: control

                property QtObject model
                property Qaterial.FolderTreeModel folderTreeModel: model ? model.qtObject : null
                property int depth
                property int index

                height: 24
                leftPadding: depth * 20

                readonly property bool selected: model && model === treeView.selectedElement

                contentItem: RowLayout
                {
                    Qaterial.ColorIcon
                    {
                        source:
                        {
                            if(!model)
                                return ""

                            if(model.fileIsDir)
                                return control.model.expanded ? Qaterial.Icons.folderOutline : Qaterial.Icons.folder
                            if(control.model.fileCompleteSuffix.includes("vcxproj"))
                                return Qaterial.Icons.microsoftVisualStudioCode
                            if(control.model.fileCompleteSuffix.includes("json"))
                                return Qaterial.Icons.codeJson
                            if(control.model.fileCompleteSuffix.includes("js"))
                                return Qaterial.Icons.nodeJs
                            if(control.model.fileCompleteSuffix.includes("qrc"))
                                return Qaterial.Icons.database
                            return Qaterial.Icons.codeTags
                        }
                        color:
                        {
                            if(control.selected || control.hovered)
                                return Qaterial.Style.accentColor
                            Qaterial.Style.hintTextColor()
                        }
                        Behavior on rotation { NumberAnimation { duration: 200;easing.type: Easing.OutQuart } }
                    }
                    Qaterial.LabelCaption
                    {
                        Layout.fillWidth: true
                        text: (control.model ? control.model.fileName : "")
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter

                        color:
                        {
                            if(control.selected)
                                return Qaterial.Style.accentColor
                            if(control.hovered)
                                return Qaterial.Style.primaryTextColor()
                            return Qaterial.Style.hintTextColor()
                        }
                    }
                }

                onClicked: function()
                {
                    if(model && model.fileIsDir)
                    {
                        // fetch content of folder if expand is about to happen
                        if(!model.expanded)
                            folderTreeModel.fetch()

                        // Then expand or retract
                        model.expanded = !model.expanded
                    }
                }
            }
        }

        Qaterial.TreeView
        {
            id: treeView2

            width: 300
            height: parent ? Math.min(contentHeight, parent.height) : contentHeight

            property QtObject selectedElement

            model: Qaterial.TreeModel
            {
                Qaterial.TreeElement
                {
                    text: "Applications"
                    Qaterial.TreeElement { text: "Calendar" }
                    Qaterial.TreeElement { text: "Chrome" }
                    Qaterial.TreeElement { text: "Webstorm" }
                }
                Qaterial.TreeElement
                {
                    text: "Documents"
                    Qaterial.TreeElement { text: "OSS" }
                    Qaterial.TreeElement
                    {
                        text: "Qaterial"
                        Qaterial.TreeElement
                        {
                            text: "src"
                            Qaterial.TreeElement { text: "main.cpp" }
                        }
                        Qaterial.TreeElement
                        {
                            text: "qml"
                            Qaterial.TreeElement { text: "main.qml" }
                            Qaterial.TreeElement { text: "main.qrc" }
                        }
                        Qaterial.TreeElement { text: "CMakeLists.txt" }
                    }
                }
            }

            itemDelegate: Qaterial.ItemDelegate
            {
                id: control2

                property QtObject model
                property int depth
                property int index

                height: 24
                leftPadding: depth * 20

                contentItem: RowLayout
                {
                    Qaterial.ColorIcon
                    {
                        source: Qaterial.Icons.chevronRight
                        color: Qaterial.Style.primaryTextColor()
                        visible: control2.model && control2.model.children && control2.model.children.count
                        Binding on rotation
                        {
                            when: control2.model && control2.model.expanded
                            value: 90
                            restoreMode: Binding.RestoreBindingOrValue
                        }
                        Behavior on rotation { NumberAnimation { duration: 200;easing.type: Easing.OutQuart } }
                    }
                    Qaterial.Label
                    {
                        Layout.fillWidth: true
                        text: control2.model ? control2.model.text : ""
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                        Binding on color
                        {
                            when: model === treeView2.selectedElement
                            value: Qaterial.Style.accentColor
                        }
                    }
                }

                onClicked: function()
                {
                    if(model.children.count !== 0)
                        model.expanded = !model.expanded
                    else
                        treeView2.selectedElement = model
                }
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
