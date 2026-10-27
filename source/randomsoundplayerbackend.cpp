#include "randomsoundplayerbackend.h"

#include <QFileInfo>
#include <iostream>

#include "files.h"
#include "numbers.h"

RandomSoundPlayerBackend::RandomSoundPlayerBackend(QObject *parent)
    : QObject{parent},
    m_maxSoundDelayInMs(0),
    m_minSoundDelayInMs(0),
    m_isToMonitorFolder(false),
    m_maxSoundVolumeNormalized(0.0),
    m_minSoundVolumeNormalized(0.0),
    m_soundPaths({}),
    m_folderPath("")
{}

QString RandomSoundPlayerBackend::getRandomSoundOnFolder() {
    const QStringList& soundPaths = getSoundPaths();

    if (soundPaths.size() < 1) {

        errorFolderNotHasSound();
        return "";
    }

    int randomIndex = Numbers::getRandomInt(0, soundPaths.size()-1);
    QString choosedSound =soundPaths[randomIndex];

    if (!QFileInfo::exists(choosedSound)) {
        forceSoundPathsUpdate();
        return RandomSoundPlayerBackend::getRandomSoundOnFolder();
    }

    return QUrl::fromLocalFile(choosedSound).toString();
}

int RandomSoundPlayerBackend::getDelayToNextSoundInMs() {
    return Numbers::getRandomInt(getMinSoundDelayInMs(), getMaxSoundDelayInMs());
}

double RandomSoundPlayerBackend::getVolumeNormalizedToNextSound() {
    return Numbers::getRandomDouble(getMinSoundVolumeNormalized(), getMaxSoundVolumeNormalized());
}

void RandomSoundPlayerBackend::forceSoundPathsUpdate() {
    m_soundPaths = Files::getAllAudiosAtFolder(getFolderPath());
}

QStringList RandomSoundPlayerBackend::getSoundPaths() {
    if (m_soundPaths.size() < 1 || getIsToMonitorFolder())
        m_soundPaths = Files::getAllAudiosAtFolder(getFolderPath());

    return m_soundPaths;
}

int RandomSoundPlayerBackend::getMinSoundDelayInMs() {
    return m_minSoundDelayInMs;
}

int RandomSoundPlayerBackend::getMaxSoundDelayInMs() {
    return m_maxSoundDelayInMs;
}

double RandomSoundPlayerBackend::getMinSoundVolumeNormalized() {
    return m_minSoundVolumeNormalized;
}

double RandomSoundPlayerBackend::getMaxSoundVolumeNormalized() {
    return m_maxSoundVolumeNormalized;
}

bool RandomSoundPlayerBackend::getIsToMonitorFolder() {
    return m_isToMonitorFolder;
}

QString RandomSoundPlayerBackend::getFolderPath() {
    return m_folderPath;
}

void RandomSoundPlayerBackend::setFolderPath(const QString& folderPath) {
    m_folderPath = folderPath;
}
void RandomSoundPlayerBackend::setMinSoundDelayInMs(int minSoundDelayInMs) {
    m_minSoundDelayInMs = minSoundDelayInMs;
}

void RandomSoundPlayerBackend::setMaxSoundDelayInMs(int maxSoundDelayInMs) {
    m_maxSoundDelayInMs = maxSoundDelayInMs;
}

void RandomSoundPlayerBackend::setMinSoundVolumeNormalized(double minSoundVolumeNormalized) {
    m_minSoundVolumeNormalized = minSoundVolumeNormalized;
}

void RandomSoundPlayerBackend::setMaxSoundVolumeNormalized(double maxSoundVolumeNormalized) {
    m_maxSoundVolumeNormalized = maxSoundVolumeNormalized;
}


void RandomSoundPlayerBackend::setIsToMonitorFolder(bool isToMonitorFolder) {
    m_isToMonitorFolder = isToMonitorFolder;
}