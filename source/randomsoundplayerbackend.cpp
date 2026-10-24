#include "randomsoundplayerbackend.h"

#include <QFileInfo>
#include <iostream>

#include "files.h"
#include "numbers.h"

RandomSoundPlayerBackend::RandomSoundPlayerBackend(QObject *parent)
    : QObject{parent},
    m_maxSoundDelayInMs(0),
    m_minSoundDelayInMs(0)
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

double RandomSoundPlayerBackend::getVolumeToNextSound() {
    return Numbers::getRandomDouble(getMinSoundVolume(), getMaxSoundVolume());
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

double RandomSoundPlayerBackend::getMinSoundVolume() {
    return m_minSoundVolume;
}

double RandomSoundPlayerBackend::getMaxSoundVolume() {
    return m_maxSoundVolume;
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

void RandomSoundPlayerBackend::setMinSoundVolume(double minSoundVolume) {
    m_minSoundVolume = minSoundVolume;
}

void RandomSoundPlayerBackend::setMaxSoundVolume(double maxSoundVolume) {
    m_maxSoundVolume = maxSoundVolume;
}


void RandomSoundPlayerBackend::setIsToMonitorFolder(bool isToMonitorFolder) {
    m_isToMonitorFolder = isToMonitorFolder;
}