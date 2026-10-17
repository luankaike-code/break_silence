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
        onSessionStarted: {
            console.log("Session started")
            randomSoundPlayer.play()
        }
    }

    RandomSoundPlayer {
        id: randomSoundPlayer
        folderPath: { return configurationWindow.getFolderPath() }
        minSoundDelay: { return configurationWindow.getMinDelaySound() }
        maxSoundDelay: { return configurationWindow.getMaxDelaySound() }
        isToMonitorFolder: { return configurationWindow.getIsToMonitorFolder() }
    }

    SystemTray {
        configurationWindowIsvisible: configurationWindow.visible
        onToggleConfigurationWindowVisibilityRequested: configurationWindow.visible? configurationWindow.hide() : configurationWindow.show()
    }
}