import QtQuick
import QtQuick.Controls
import QtMultimedia

import BreakSilence.APP.MetaObjects

Item {
    id: root

    signal soundFinished

    signal errorSoundNotFound(soundPath: string)
    signal errorFolderNotHasSound

    required property string folderPath
    required property bool isToMonitorFolder
    required property int minSoundDelayInMs
    required property int maxSoundDelayInMs
    required property real minSoundVolumeNormalized
    required property real maxSoundVolumeNormalized

    function play() {
        playTimer()
    }

    function stop() {
        timer.stop()
        mediaPlayer.stop()
    }

    function playTimer() {
        timer.interval = backend.getDelayToNextSoundInMs()
        console.log("delay to next sound:", timer.interval, "Ms")
        timer.start()
    }

    function playSound() {
        mediaPlayer.source = backend.getRandomSoundOnFolder()
        audioOutput.volume = backend.getVolumeNormalizedToNextSound()

        if(!mediaPlayer.source || mediaPlayer.source.toString().trim() === "")
            return

        console.log("played sound:", mediaPlayer.source)
        console.log("sound volume:", audioOutput.volume)

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
            console.log("sound not found:", soundPath)
        }

        onErrorFolderNotHasSound: {
            root.errorFolderNotHasSound()
            console.log("folder not has sound")
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
            if (playbackState === MediaPlayer.StoppedState) {
                root.soundFinished()
                playTimer()
            }
        }

        onErrorChanged: {
            if (error !== MediaPlayer.NoError) {
                console.log("error to play audio:", errorString)
            }
        }
    }
}
