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
        return extraOptions.getIsToMonitorFolder()
    }

    function getMinSoundDelay() {
        return extraOptions.getMinSoundDelay()
    }

    function getMaxSoundDelay() {
        return extraOptions.getMaxSoundDelay()
    }

    QtObject {
        id: rootVariables

        property int inputWidth: 350
        property int emphasisConteinersHeight: 50
    }

    QtObject {
        id: rootFunctions

        function clearErrors() {
            labelError.text = ""
            folderInput.isEmphasisError = false
            extraOptions.clearErrors()
        }

        function setCurrentError(errorText, inputsToEmphasis=[]) {
            labelError.text = qsTr(errorText)

            for (const inputToEmphasis of inputsToEmphasis) {
                if (inputToEmphasis)
                    inputToEmphasis.isEmphasisError = true
            }
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

        onErrorInvalidMinMaxDelayInterval: extraOptions.setErrorInvalidMinMaxDelayInterval()
        onErrorInvalidFolder: rootFunctions.setCurrentError("O caminho para a pasta de audios é inválida", [folderInput])
        onErrorEmptyFolder: rootFunctions.setCurrentError("A pasta de audios não contém nenhum aquivo de audio válido", [folderInput])
    }

    ConfigurationWindowExtraOptions {
        id: extraOptions
        inputWidth: rootVariables.inputWidth
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
            Layout.alignment: Qt.AlignCenter

            Button {
                text: extraOptions.visible? qsTr("Mostrar opções extras") : qsTr("Mostrar opções extras")
                onClicked: extraOptions.visible = !extraOptions.visible
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
                    rootFunctions.clearErrors()
                    configurationWindowBackend.startSession()
                }
            }
        }
    }
}
