import QtQuick
import Qt.labs.platform

SystemTrayIcon {
    id: trayIcon
    visible: true
    tooltip: qsTr("BreakSilence")

    required property bool configurationWindowIsvisible
    required property bool sessionIsStarted
    required property bool soundPlayerIsPlaying

    signal toggleConfigurationWindowVisibilityRequested
    signal toggleSoundPlayerRequested
    signal showCurrentConfigurationRequested

    icon.source: "qrc:/assets/breaksilence_icon.svg"
    menu:
        Menu {
            MenuItem {
                text: configurationWindowIsvisible ? qsTr("Ocultar janela de configuração") :  qsTr("Exibir Janela de configuração")
                onTriggered: toggleConfigurationWindowVisibilityRequested()
            }

            MenuItem {
                visible: sessionIsStarted
                text: soundPlayerIsPlaying ? qsTr("Pausar") : qsTr("Retomar")
                onTriggered: toggleSoundPlayerRequested()
            }

            MenuSeparator {}

            MenuItem {
                text: qsTr("Exibir configuração atual")
                onTriggered: showCurrentConfigurationRequested()
            }

            MenuSeparator {}

            MenuItem {
                text: qsTr("Sair")
                onTriggered: Qt.quit()
            }
        }

        onActivated: function(reason) {
            if (reason === SystemTrayIcon.Trigger) {
                toggleConfigurationWindowVisibilityRequested()
            }
        }
}
