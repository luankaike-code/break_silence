import QtQuick

import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: root
    title: qsTr("Opções extras")
    visible: false
    height: parent.height-100
    width: parent.width-100

    Material.theme: parent.Material.theme

    modal: true
    anchors.centerIn: parent

    required property int inputWidth

    function getIsToMonitorFolder() {
        return isToMonitorFolderCheckbox.checked
    }

    function getMinSoundDelay() {
        return minSoundDelayInput.getValue()
    }

    function getMaxSoundDelay() {
        return maxSoundDelayInput.getValue()
    }

    function getMinSoundVolume() {
        return minSoundVolumeInput.text === ""? 0 : parseFloat(minSoundVolumeInput.text)/100
    }

    function getMaxSoundVolume() {
        return maxSoundVolumeInput.text === ""? 0 : parseFloat(maxSoundVolumeInput.text)/100
    }

    function setErrorInvalidMinMaxDelayInterval() {
        rootFunctions.setCurrentError("O intervalo de mínimo e mximo do tempo é inválido", [minSoundDelayInput, maxSoundDelayInput])
    }

    function setErrorInvalidMinMaxVolumeInterval() {
        rootFunctions.setCurrentError("O intervalo de mínimo e mximo do volume é inválido", [minSoundDelayInput, maxSoundDelayInput])
    }

    function clearErrors() {
        labelError.text = ""
        minSoundDelayInput.isEmphasisError = false
        maxSoundDelayInput.isEmphasisError = false
    }

    QtObject {
        id: rootVariables

        property variant timeMagnitudes: [
            { value: 1, text: qsTr("Ms") },
            { value: 1000, text: qsTr("Seg") },
            { value: 1000*60, text: qsTr("Min") },
            { value: 1000*60*60, text: qsTr("Hr") },
        ]
    }

    QtObject {
        id: rootFunctions

        function setCurrentError(errorText, inputsToEmphasis=[]) {
            root.clearErrors()
            labelError.text = qsTr(errorText)

            for (const inputToEmphasis of inputsToEmphasis) {
                if (inputToEmphasis)
                    inputToEmphasis.isEmphasisError = true
            }
            root.open()
        }
    }

    InformativeDialog {
        id: informativeDialogMonitorarFolder
        title: qsTr('Como funciona o "monitorar pasta"')
        text: qsTr("Se ativado, a pasta sempre será reanalisada em busca de novos sons. Isso permite que novos sons Possam serem adicionados mesmo se o programa estiver em execução.")
    }

    ScrollView {
        id: a
        anchors.fill: parent

        ColumnLayout {
            width: a.width
            x: a.width/2-width/2
            Layout.alignment: Qt.AlignHCenter

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                InputNumberWithMagnitude {
                    id: minSoundDelayInput
                    placeholderText: qsTr("Tempo mínimo")
                    conteinerWidth: root.inputWidth

                    model: rootVariables.timeMagnitudes
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                InputNumberWithMagnitude {
                    id: maxSoundDelayInput
                    placeholderText: qsTr("Tempo máximo")
                    conteinerWidth: root.inputWidth

                    inputDefaultValue: 30
                    currentIndex: 2

                    model: rootVariables.timeMagnitudes
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                InputNumber {
                    id: minSoundVolumeInput
                    placeholderText: qsTr("Volume mínimo")
                    text: "80"

                    Layout.preferredWidth: root.inputWidth
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter

                InputNumber {
                    id: maxSoundVolumeInput
                    placeholderText: qsTr("Volume máximo")
                    text: "100"

                    Layout.preferredWidth: root.inputWidth
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

                    onClicked: informativeDialogMonitorarFolder.open()
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
                Layout.alignment: Qt.AlignCenter

                Label {
                    id: labelError
                    text: ""
                    Material.foreground: Material.Red
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignCenter

                Button {
                    text: qsTr("fechar")
                    onClicked: root.close()
                }
            }
        }
    }
}
