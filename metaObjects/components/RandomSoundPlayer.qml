import QtQuick
import QtQuick.Controls
import QtMultimedia

import BreakSilence.APP.MetaObjects

Item {
    id: root

    signal soundFinished
    signal soundPlayed(soundPath: string)

    signal errorSoundNotFound(soundPath: string)
    signal errorToPlaySound(soundPath: string, error: string)
    signal errorFolderNotHasSound

    required property string folderPath
    required property bool isToMonitorFolder
    required property int minSoundDelayInMs
    required property int maxSoundDelayInMs
    required property real minSoundVolumeNormalized
    required property real maxSoundVolumeNormalized

    property bool running

    function play() {
        running = true
        updateTimerInterval()
        timer.start()
    }

    function resumeTimer() {
        if(running)
            return

        console.log(qsTr("retornando o temporizador do RandomSoundPlayer"))
        running = true
        timer.start()
    }

    function pauseTimer() {
        if(!running)
            return

        console.log(qsTr("pausando o temporizador do RandomSoundPlayer"))
        running = false
        timer.stop()
    }

    function updateTimerInterval() {
        timer.interval = backend.getDelayToNextSoundInMs()

        console.log(qsTr("delay até o próximo som: %1 MS").arg(timer.interval))
    }

    function nextSound() {
        updateTimerInterval()
        console.log(root.running)
        if(root.running)
            timer.start()
    }

    function playSound() {
        mediaPlayer.source = ""
        mediaPlayer.source = backend.getRandomSoundOnFolder()
        audioOutput.volume = backend.getVolumeNormalizedToNextSound()

        if(!mediaPlayer.source || mediaPlayer.source.toString().trim() === "")
            return

        console.log(qsTr("som tocado: %1").arg(mediaPlayer.source))
        console.log(qsTr("volume do som: %1").arg(audioOutput.volume))

        mediaPlayer.play()
    }

    RandomSoundPlayerBackend {
        id: backend

        folderPath: root.folderPath
        isToMonitorFolder: root.isToMonitorFolder
        minSoundDelayInMs: root.minSoundDelayInMs
        maxSoundDelayInMs: root.maxSoundDelayInMs
        minSoundVolumeNormalized: root.minSoundVolumeNormalized
        maxSoundVolumeNormalized: root.maxSoundVolumeNormalized

        onErrorSoundNotFound: function (soundPath) {
            root.errorSoundNotFound(soundPath)
            console.log(qsTr("som não encontrado: $1").arg(soundPath))
        }

        onErrorFolderNotHasSound: {
            root.errorFolderNotHasSound()
            console.log(qsTr("a pasta não contém sons"))
        }
    }

    Timer {
        id: timer
        interval: backend.getDelayToNextSoundInMs()
        running: false
        repeat: false

        onTriggered: {
            playSound()
        }
    }

    MediaPlayer {
        id: mediaPlayer
        audioOutput: AudioOutput {
            id: audioOutput
            volume: 0.8
        }

        onPlaybackStateChanged: {
            switch(playbackState) {
                case MediaPlayer.PlayingState:
                    root.soundPlayed(mediaPlayer.source)
                    break
                case MediaPlayer.StoppedState:
                    root.soundFinished()
                    root.nextSound()
                    break
            }
        }

        onErrorChanged: {
            if (error !== MediaPlayer.NoError) {
                console.log(qsTr("error ao tocar o audio (%1): %2").arg(source).arg(errorString))
                root.errorToPlaySound(source, errorString)
                root.nextSound()
            }
        }
    }
}
