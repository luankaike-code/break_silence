import QtQuick
import QtQuick.Controls
import QtMultimedia

import BreakSilence.APP.MetaObjects

Item {
    id: root

    signal soundFinished

    required property string folderPath
    required property bool isToMonitorFolder

    function play() {
        mediaPlayer.source = backend.getRandomSoundOnFolder()
        console.log(mediaPlayer.source)
        root.soundFinished()
        mediaPlayer.play()
    }

    RandomSoundPlayerBackend {
        id: backend

        folderPath: root.folderPath
        isToMonitorFolder: root.isToMonitorFolder

        onErrorSoundNotFound: function (soundPath) {
            console.log("sound nor found:", soundPath)
        }

        onErrorFolderNotHasSound: {
            console.log("folder not has sound")
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
                source = backend.getRandomSoundOnFolder()
                root.soundFinished()
                mediaPlayer.play()
            }
        }

        onErrorChanged: {
            if (error !== MediaPlayer.NoError) {
                console.log("Erro ao tocar áudio:", errorString)
            }
        }
    }
}
