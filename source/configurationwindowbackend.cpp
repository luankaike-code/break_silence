#include "configurationwindowbackend.h"
#include <QFileInfo>
#include <iostream>
#include "files.h"

ConfigurationWindowBackend::ConfigurationWindowBackend(QObject *parent)
    : QObject{parent},
    m_minSoundDelayInMs(0),
    m_maxSoundDelayInMs(0),
    m_isToMonitorFolder(false),
    m_folderPath(""),
    m_maxSoundVolumeNormalized(0.0),
    m_minSoundVolumeNormalized(0.0)
{}

void ConfigurationWindowBackend::startSession() {
    QFileInfo folderFileInfo(m_folderPath);

    if (m_minSoundDelayInMs > m_maxSoundDelayInMs) {
        errorInvalidMinMaxDelayInterval();
        return;
    }

    if (m_minSoundVolumeNormalized > m_maxSoundVolumeNormalized) {
        errorInvalidMinMaxVolumeInterval();
        return;
    }

    if (!folderFileInfo.exists() || folderFileInfo.isFile()) {
        errorInvalidFolder();
        return;
    }

    QStringList folderSounds = Files::getAllAudiosAtFolder(m_folderPath);

    if (folderSounds.size() < 1) {
        errorEmptyFolder();
        return;
    }

    sessionStarted();
}

QString ConfigurationWindowBackend::getFolderPath() {
    return m_folderPath;
}

int ConfigurationWindowBackend::getMinSoundDelayInMs() {
    return m_minSoundDelayInMs;
}

int ConfigurationWindowBackend::getMaxSoundDelayInMs() {
    return m_maxSoundDelayInMs;
}

double ConfigurationWindowBackend::getMinSoundVolumeNormalized() {
    return m_minSoundVolumeNormalized;
}

double ConfigurationWindowBackend::getMaxSoundVolumeNormalized() {
    return m_maxSoundVolumeNormalized;
}

bool ConfigurationWindowBackend::getIsToMonitorFolder() {
    return m_isToMonitorFolder;
}

void ConfigurationWindowBackend::setFolderPath(const QString& folderPath) {
    m_folderPath = folderPath;
}

void ConfigurationWindowBackend::setMinSoundDelayInMs(int minSoundDelayInMs) {
    m_minSoundDelayInMs = minSoundDelayInMs;
}

void ConfigurationWindowBackend::setMaxSoundDelayInMs(int maxSoundDelayInMs) {
    m_maxSoundDelayInMs = maxSoundDelayInMs;
}

void ConfigurationWindowBackend::setMinSoundVolumeNormalized(double minSoundVolumeNormalized) {
    m_minSoundVolumeNormalized = minSoundVolumeNormalized;
}

void ConfigurationWindowBackend::setMaxSoundVolumeNormalized(double maxSoundVolumeNormalized) {
    m_maxSoundVolumeNormalized = maxSoundVolumeNormalized;
}

void ConfigurationWindowBackend::setIsToMonitorFolder(bool isToMonitorFolder) {
    m_isToMonitorFolder = isToMonitorFolder;
}
