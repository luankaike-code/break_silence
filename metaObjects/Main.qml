import QtQuick
import "components"

Window {
    id: root
    width: 640
    height: 480
    visible: false
    title: qsTr("THIS WINDOW WAS NOT SUPPOSED TO BE VISIBLE")

    Component.onCompleted: configurationWindow.show()

    ConfigurationWindow {
        id: configurationWindow
        visible: true
        onSessionStarted: console.log("session started")
    }

    SystemTray {
        configurationWindowIsvisible: configurationWindow.visible
        onToggleConfigurationWindowVisibilityRequested: configurationWindow.visible? configurationWindow.hide() : configurationWindow.show()
    }
}