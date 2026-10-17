import QtQuick
import QtQuick.Controls
import QtMultimedia

import BreakSilence.APP.MetaObjects

Item {
    id: root

    signal soundFinished

    required property string folderPath
    required property bool isToMonitorFolder
    required property int minSoundDelay
    required property int maxSoundDelay

    function play() {
        playTimer()
    }

    function stop() {
        timer.stop()
        mediaPlayer.stop()
    }

    function playTimer() {
        timer.interval = backend.getDelayToNextSoundInMs()
        timer.start()
    }

    function playSound() {
        mediaPlayer.source = backend.getRandomSoundOnFolder()
        mediaPlayer.play()
    }

    RandomSoundPlayerBackend {
        id: backend

        folderPath: root.folderPath
        isToMonitorFolder: root.isToMonitorFolder
        minSoundDelay: root.minSoundDelay
        maxSoundDelay: root.maxSoundDelay

        onErrorSoundNotFound: function (soundPath) {
            console.log("sound nor found:", soundPath)
        }

        onErrorFolderNotHasSound: {
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
