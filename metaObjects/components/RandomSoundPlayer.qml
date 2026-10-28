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

        console.log("resume RandomSoundPlayer´s timer")
        running = true
        timer.start()
    }

    function pauseTimer() {
        if(!running)
            return

        console.log("pause RandomSoundPlayer´s timer")
        running = false
        timer.stop()
    }

    function updateTimerInterval() {
        timer.interval = backend.getDelayToNextSoundInMs()

        console.log("delay to next sound:", timer.interval, "Ms")
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
            switch(playbackState) {
                case MediaPlayer.PlayingState:
                    soundPlayed(mediaPlayer.source)
                    break
                case MediaPlayer.StoppedState:
                    root.soundFinished()
                    updateTimerInterval()
                    if(root.running)
                        timer.start()
                    break
            }
        }

        onErrorChanged: {
            if (error !== MediaPlayer.NoError) {
                console.log(qsTr("error to play audio (%1): %2").arg(source).arg(errorString))
                errorToPlaySound(source, errorString)
            }
        }
    }
}
