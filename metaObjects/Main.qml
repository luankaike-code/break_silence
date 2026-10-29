import QtQuick
import "components"

ConfigurationWindow {
    id: configurationWindow
    visible: true

    function getCurrentConfigurationString() {
        return qsTr(`
        caminho da pasta com os sons: %1
        intervalo de tempo: %2 MS - %3 MS
        intervalo de volume: %4 - %5
        é para monitorar a pasta: %6
        é para notificar o som que tocar: %7
        `).arg(configurationWindow.getFolderPath())
            .arg(configurationWindow.getMinSoundDelayInMs())
            .arg( configurationWindow.getMaxSoundDelayInMs())
            .arg(configurationWindow.getMinSoundVolumeNormalized()).arg( configurationWindow.getMaxSoundVolumeNormalized())
            .arg(configurationWindow.getIsToMonitorFolder())
            .arg(configurationWindow.getIsToNotifyPlayedSound())
    }

    onSessionStarted: {
        console.log(qsTr("Sessão iniciada"))
        console.log(configurationWindow.getCurrentConfigurationString())
        randomSoundPlayer.play()
        rootVariables.sessionIsStarted = true
    }

    onClosing: (closeEvent) => {
        closeEvent.accepted = false
        configurationWindow.hide()
    }

    QtObject {
        id: rootVariables

        property bool sessionIsStarted: false

        onSessionIsStartedChanged: randomSoundPlayer.running = sessionIsStarted
    }

    RandomSoundPlayer {
        id: randomSoundPlayer
        folderPath: { return configurationWindow.getFolderPath() }
        minSoundDelayInMs: { return configurationWindow.getMinSoundDelayInMs() }
        maxSoundDelayInMs: { return configurationWindow.getMaxSoundDelayInMs() }
        minSoundVolumeNormalized: { return configurationWindow.getMinSoundVolumeNormalized() }
        maxSoundVolumeNormalized: { return configurationWindow.getMaxSoundVolumeNormalized() }
        isToMonitorFolder: { return configurationWindow.getIsToMonitorFolder() }

        onRunningChanged: {
            if(running)
                return

            systemTray.showMessage(qsTr("Sessão pausada"), qsTr("A sessão está pausada, nenhum som tocará enquanto estiver"))
        }

        onSoundPlayed: function(soundPath) {
            if (configurationWindow.getIsToNotifyPlayedSound())
                systemTray.showMessage(qsTr("Som tocado"), qsTr("O som %1 foi tocado").arg(soundPath))
        }

        onErrorSoundNotFound: function(soundPath) {
            systemTray.showMessage(qsTr("Erro: som não encontrado"), qsTr("O som %1 não foi encontrado").arg(soundPath))
            configurationWindow.show()
        }

        onErrorToPlaySound: function(soundPath, error) {
            systemTray.showMessage(qsTr("Erro: som não pode ser tocado"), qsTr("O som %1 não foi tocado. Erro dado: %2").arg(soundPath).arg(error))
        }

        onErrorFolderNotHasSound: {
            systemTray.showMessage(qsTr("Erro: a pasta não contém sons"), qsTr("Nenhum som foi encontrado na pasta"))
            configurationWindow.show()
        }
    }

    SystemTray {
        id: systemTray
        configurationWindowIsvisible: configurationWindow.visible
        sessionIsStarted: rootVariables.sessionIsStarted
        soundPlayerIsPlaying: randomSoundPlayer.running
        onToggleConfigurationWindowVisibilityRequested: {
            if(configurationWindow.visible) {
                configurationWindow.hide()
            } else {
                rootVariables.sessionIsStarted = false
                configurationWindow.show()
            }
        }

        onToggleSoundPlayerRequested: randomSoundPlayer.running? randomSoundPlayer.pauseTimer() : randomSoundPlayer.resumeTimer()

        onShowCurrentConfigurationRequested: function() {
            systemTray.showMessage(qsTr("Configuração atual"), configurationWindow.getCurrentConfigurationString())
        }
    }
}