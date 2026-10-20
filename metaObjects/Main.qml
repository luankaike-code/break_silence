import QtQuick
import "components"

ConfigurationWindow {
    id: configurationWindow
    visible: true
    onSessionStarted: {
        console.log("Session started")
        randomSoundPlayer.play()
    }

    onClosing: (closeEvent) => {
        closeEvent.accepted = false
        configurationWindow.hide()
    }

    RandomSoundPlayer {
        id: randomSoundPlayer
        folderPath: { return configurationWindow.getFolderPath() }
        minSoundDelay: { return configurationWindow.getMinSoundDelay() }
        maxSoundDelay: { return configurationWindow.getMaxSoundDelay() }
        isToMonitorFolder: { return configurationWindow.getIsToMonitorFolder() }
    }

    SystemTray {
        configurationWindowIsvisible: configurationWindow.visible
        onToggleConfigurationWindowVisibilityRequested: configurationWindow.visible? configurationWindow.hide() : configurationWindow.show()
    }
}