#include "randomsoundplayerbackend.h"

#include <QFileInfo>
#include <iostream>

#include "files.h"
#include "numbers.h"

RandomSoundPlayerBackend::RandomSoundPlayerBackend(QObject *parent)
    : QObject{parent},
    m_maxSoundDelay(0),
    m_minSoundDelay(0)
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
    return Numbers::getRandomInt(getMinSoundDelay(), getMaxSoundDelay());
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

int RandomSoundPlayerBackend::getMinSoundDelay() {
    return m_minSoundDelay;
}

int RandomSoundPlayerBackend::getMaxSoundDelay() {
    return m_maxSoundDelay;
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
void RandomSoundPlayerBackend::setMinSoundDelay(int minSoundDelay) {
    m_minSoundDelay = minSoundDelay;
}

void RandomSoundPlayerBackend::setMaxSoundDelay(int maxSoundDelay) {
    m_maxSoundDelay = maxSoundDelay;
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