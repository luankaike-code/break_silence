import QtQuick
import QtQuick.Controls
import QtMultimedia

Item {
    id: root

    property variant sounds: [
        "/home/luankaike-code/Sync/hd/sons/sl/gta-san andreas-ah-shit-here-we-go-again_BWv0Gvc.mp3"
    ]

    signal soundFinished

    function play() {
        mediaPlayer.source = getRandomSound()
        mediaPlayer.play()
    }

    function stop() {
        mediaPlayer.pause()
    }

    function getRandomInt(min, max) {
        min = Math.ceil(min);
        max = Math.floor(max);
        return Math.floor(Math.random() * (max - min + 1)) + min;
    }

    function getRandomSound() {
        if (sounds?.length === 0) {
            return
        }
        return "file://" + sounds[getRandomInt(0, sounds.length)]
    }

    MediaPlayer {
        id: mediaPlayer
        audioOutput: AudioOutput {
            id: audioOutput
            volume: 0.8
        }

        onPlaybackStateChanged: {
            if (playbackState === MediaPlayer.StoppedState) {
                source = root.getRandomSound()
                root.soundFinished()
            }
        }
    }
}
