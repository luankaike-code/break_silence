#include "randomsoundplayerbackend.h"

#include <QFileInfo>
#include <iostream>

#include "files.h"
#include "numbers.h"

RandomSoundPlayerBackend::RandomSoundPlayerBackend(QObject *parent)
    : QObject{parent}
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

void RandomSoundPlayerBackend::forceSoundPathsUpdate() {
    m_soundPaths = Files::getAllAudiosAtFolder(getFolderPath());
}

const QStringList& RandomSoundPlayerBackend::getSoundPaths() {
    if (m_soundPaths.size() < 1 || getIsToMonitorFolder())
        m_soundPaths = Files::getAllAudiosAtFolder(getFolderPath());

    return m_soundPaths;
}

const int& RandomSoundPlayerBackend::getMinSoundDelay() {
    return m_minSoundDelay;
}

const int& RandomSoundPlayerBackend::getMaxSoundDelay() {
    return m_maxSoundDelay;
}

const bool& RandomSoundPlayerBackend::getIsToMonitorFolder() {
    return m_isToMonitorFolder;
}

const QString& RandomSoundPlayerBackend::getFolderPath() {
    return m_folderPath;
}

void RandomSoundPlayerBackend::setFolderPath(const QString& folderPath) {
    m_folderPath = folderPath;
}
void RandomSoundPlayerBackend::setMinSoundDelay(const int& minSoundDelay) {
    m_minSoundDelay = minSoundDelay;
}

void RandomSoundPlayerBackend::setMaxSoundDelay(const int& maxSoundDelay) {
    m_maxSoundDelay = maxSoundDelay;
}

void RandomSoundPlayerBackend::setIsToMonitorFolder(const bool& isToMonitorFolder) {
    m_isToMonitorFolder = isToMonitorFolder;
}