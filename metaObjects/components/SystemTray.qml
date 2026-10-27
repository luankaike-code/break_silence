import QtQuick
import Qt.labs.platform

SystemTrayIcon {
    id: trayIcon
    visible: true
    tooltip: qsTr("BreakSilence")

    required property bool configurationWindowIsvisible

    signal toggleConfigurationWindowVisibilityRequested
    signal showCurrentConfigurationRequested

    icon.source: "qrc:/assets/breaksilence_icon.svg"
    menu:
        Menu {
            MenuItem {
                text: configurationWindowIsvisible ? qsTr("Ocultar janela de configuração") :  qsTr("Exibir Janela de configuração")
                onTriggered: toggleConfigurationWindowVisibilityRequested()
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
