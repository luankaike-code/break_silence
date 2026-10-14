import QtQuick

import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

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

        Dialog {
            id: informativeDialog
            title: qsTr('Como funciona o "monitorar pasta"')
            width: 500

            anchors.centerIn: parent
            modal: true

            standardButtons: Dialog.Ok

            Label {
                width: informativeDialog.width-40
                anchors.centerIn: parent
                wrapMode: Text.WordWrap
                text: qsTr("Se ativado, a pasta sempre será reanalisada em busca de novos sons. Isso permite que novos sons Possam serem adicionados mesmo se o programa estiver em execução.")
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            spacing: 1

            Label {
                text: qsTr("Monitorar a pasta")
            }

            ButtonImage {
                source: "qrc:/assets/question_mark-svgrepo_com.svg"

                onClicked: informativeDialog.open()
                width: 10
                transform: Translate {
                    x: -1
                    y: -5
                }
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
