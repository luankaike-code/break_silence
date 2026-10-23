#include "configurationwindowbackend.h"
#include <QFileInfo>
#include <iostream>
#include "files.h"

ConfigurationWindowBackend::ConfigurationWindowBackend(QObject *parent)
    : QObject{parent},
    m_minSoundDelayInMs(-1),
    m_maxSoundDelayInMs(-1),
    m_isToMonitorFolder(false),
    m_folderPath("")
{}

void ConfigurationWindowBackend::startSession() {
    QFileInfo folderFileInfo(m_folderPath);

    if (m_minSoundDelayInMs > m_maxSoundDelayInMs) {
        errorInvalidMinMaxDelayInterval();
        return;
    }

    std::cout << "min" << m_minSoundVolume << m_maxSoundVolume <<std::endl;

    if (m_minSoundVolume > m_maxSoundVolume) {
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

double ConfigurationWindowBackend::getMinSoundVolume() {
    return m_minSoundVolume;
}

double ConfigurationWindowBackend::getMaxSoundVolume() {
    return m_maxSoundVolume;
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

void ConfigurationWindowBackend::setMinSoundVolume(double minSoundVolume) {
    m_minSoundVolume = minSoundVolume;
}

void ConfigurationWindowBackend::setMaxSoundVolume(double maxSoundVolume) {
    m_maxSoundVolume = maxSoundVolume;
}

void ConfigurationWindowBackend::setIsToMonitorFolder(bool isToMonitorFolder) {
    m_isToMonitorFolder = isToMonitorFolder;
}
