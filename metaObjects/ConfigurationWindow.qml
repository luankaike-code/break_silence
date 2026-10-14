import QtQuick

import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "components"

BaseWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("BreakSilence - Configuration")
    id: root

    QtObject {
        id: rootVariables
        property int inputWidth: 300
        property int emphasisConteinersHeight: 100
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.minimumHeight: rootVariables.emphasisConteinersHeight

            Label {
                text: "BreakSilence"
                font.pixelSize: 22
                font.bold: true
            }
        }

        RowLayout {
            id: folderInputConteiner
            Layout.alignment: Qt.AlignHCenter

            Input {
                placeholderText: qsTr("Caminho para a pasta de audios")
                Layout.minimumWidth: rootVariables.inputWidth-buttonFolderDialog.width-folderInputConteiner.spacing
            }

            ButtonFolderDialog {
                id: buttonFolderDialog
            }
        }

        RowLayout {
            id: timeInputsConteiner
            Layout.alignment: Qt.AlignHCenter

            Input {
                placeholderText: qsTr("Tempo maxímo")
                Layout.minimumWidth: rootVariables.inputWidth/2 - timeInputsConteiner.spacing/2
            }

            Input {
                placeholderText: qsTr("Tempo minímo")
                Layout.minimumWidth: rootVariables.inputWidth/2 - timeInputsConteiner.spacing/2
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter

            Label {
                text: qsTr("Monitorar a pasta")
            }

            CheckBox {

            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.minimumHeight: rootVariables.emphasisConteinersHeight

            Button {
                text: "Iniciar"
            }
        }
    }
}
