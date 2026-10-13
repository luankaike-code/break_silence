import QtQuick
import Qt.labs.platform

SystemTrayIcon {
    id: trayIcon
    visible: true
    tooltip: qsTr("Menu de controle")

    property variant mainWindow

    icon.source: "qrc:/icon.png"
    menu:
        Menu {
            MenuItem {
                text: mainWindow.visible ? "Ocultar Janela" : "Exibir Janela"
                onTriggered: {
                    mainWindow.visible = !mainWindow.visible
                }
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
                mainWindow.visible = !mainWindow.visible
            }
        }
}
