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
        minSoundDelayInMs: { return configurationWindow.getMinSoundDelayInMs() }
        maxSoundDelayInMs: { return configurationWindow.getMaxSoundDelayInMs() }
        minSoundVolumeNormalized: { return configurationWindow.getMinSoundVolumeNormalized() }
        maxSoundVolumeNormalized: { return configurationWindow.getMaxSoundVolumeNormalized() }
        isToMonitorFolder: { return configurationWindow.getIsToMonitorFolder() }

        onSoundPlayed: function(soundPath) {
            if (configurationWindow.getIsToNotifyPlayedSound())
                systemTray.showMessage(qsTr("Som tocado"), qsTr("O som %1 foi tocado").arg(soundPath))
        }

        onErrorSoundNotFound: function(soundPath) {
            systemTray.showMessage(qsTr("Erro: som não encontrado"), qsTr("O som %1 não foi encontrado").arg(soundPath))
            configurationWindow.show()
        }

        onErrorFolderNotHasSound: {
            systemTray.showMessage(qsTr("Erro: a pasta não contém sons"), qsTr("Nenhum som foi encontrado na pasta"))
            configurationWindow.show()
        }
    }

    SystemTray {
        id: systemTray
        configurationWindowIsvisible: configurationWindow.visible
        onToggleConfigurationWindowVisibilityRequested: configurationWindow.visible? configurationWindow.hide() : configurationWindow.show()
    }
}