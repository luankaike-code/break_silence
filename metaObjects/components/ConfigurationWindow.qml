import QtQuick

import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import BreakSilence.APP.MetaObjects

BaseWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("BreakSilence - Configuration")
    id: root

    signal sessionStarted

    function getFolderPath() {
        return folderInput.text
    }


    function getIsToMonitorFolder() {
        return isToMonitorFolderCheckbox.checked
    }

    function getMinSoundDelay() {
        return minSoundDelayInput.getValue()
    }

    function getMaxSoundDelay() {
        return maxSoundDelayInput.getValue()
    }

    function clearCurrentError() {
        labelError.text = ""
        folderInput.isEmphasisError = false
        minSoundDelayInput.isEmphasisError = false
        maxSoundDelayInput.isEmphasisError = false
    }

    function setCurrentError(errorText, inputsToEmphasis=[]) {
        labelError.text = qsTr(errorText)

        for (const inputToEmphasis of inputsToEmphasis) {
            if (inputToEmphasis)
                inputToEmphasis.isEmphasisError = true
        }
    }

    ConfigurationWindowBackend {
        id: configurationWindowBackend
        folderPath: { return root.getFolderPath() }
        minSoundDelayInMs: { return root.getMinSoundDelay() }
        maxSoundDelayInMs: { return root.getMaxSoundDelay() }
        isToMonitorFolder: { return root.getIsToMonitorFolder() }

        onSessionStarted: {
            root.hide()
            root.sessionStarted()
        }

        onErrorInvalidMinMaxDelayInterval: setCurrentError("O intervalo de mínimo e mximo é inválido", [minSoundDelayInput, maxSoundDelayInput])
        onErrorInvalidFolder:setCurrentError("O caminho para a pasta de audios é inválida", [folderInput])
        onErrorEmptyFolder: setCurrentError("A pasta de audios não contém nenhum aquivo de audio válido", [folderInput])
    }

    QtObject {
        id: rootVariables
        property int inputWidth: 350
        property int emphasisConteinersHeight: 50
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
                id: folderInput
                placeholderText: qsTr("Caminho para a pasta de audios")
                Layout.minimumWidth: rootVariables.inputWidth-buttonFolderDialog.width-folderInputConteiner.spacing
            }

            ButtonFolderDialog {
                id: buttonFolderDialog
                onFolderChoosed: (folderPath) => {
                    folderInput.text = folderPath
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            InputNumberWithMagnitude {
                id: minSoundDelayInput
                placeholderText: qsTr("Tempo mínimo")
                conteinerWidth: rootVariables.inputWidth

                model: [
                    { value: 1, text: qsTr("Ms") },
                    { value: 1000, text: qsTr("Seg") },
                    { value: 1000*60, text: qsTr("Min") },
                    { value: 1000*60*60, text: qsTr("Hr") },
                ]
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            InputNumberWithMagnitude {
                id: maxSoundDelayInput
                placeholderText: qsTr("Tempo máximo")
                conteinerWidth: rootVariables.inputWidth

                inputDefaultValue: 30
                currentIndex: 2

                model: [
                    { value: 1, text: qsTr("Ms") },
                    { value: 1000, text: qsTr("Seg") },
                    { value: 1000*60, text: qsTr("Min") },
                    { value: 1000*60*60, text: qsTr("Hr") },
                ]
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
                id: isToMonitorFolderCheckbox
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.minimumHeight: rootVariables.emphasisConteinersHeight

            Label {
                id: labelError
                text: ""
                Material.foreground: Material.Red
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            Layout.minimumHeight: rootVariables.emphasisConteinersHeight

            Button {
                text: "Iniciar"
                onClicked: {
                    clearCurrentError()
                    configurationWindowBackend.startSession()
                }
            }
        }
    }
}
