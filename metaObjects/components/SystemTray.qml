import QtQuick
import Qt.labs.platform

SystemTrayIcon {
    id: trayIcon
    visible: true
    tooltip: qsTr("BreakSilence")

    required property bool configurationWindowIsvisible

    signal toggleConfigurationWindowVisibilityRequested

    icon.source: "qrc:/assets/breaksilence_icon.svg"
    menu:
        Menu {
            MenuItem {
                text: configurationWindowIsvisible ? "Ocultar Janela" : "Exibir Janela"
                onTriggered: toggleConfigurationWindowVisibilityRequested()
            }

            MenuItem {
                text: "Enviar Notificação"
                onTriggered: {
                    trayIcon.showMessage("Olá!", "Esta é uma notificação da bandeja.")
                }
            }

            MenuSeparator {}

            MenuItem {
                text: "Sair"
                onTriggered: Qt.quit()
            }
        }

        onActivated: function(reason) {
            if (reason === SystemTrayIcon.Trigger) {
                toggleConfigurationWindowVisibilityRequested()
            }
        }
}
