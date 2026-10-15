import QtQuick
import "components"

ConfigurationWindow {
    id: root


    SystemTray {
        configurationWindowIsvisible: root.visible
        onToggleConfigurationWindowVisibilityRequested: root.visible? root.hide() : root.show()
    }
}
