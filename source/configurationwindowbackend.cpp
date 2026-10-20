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
    } else if (!folderFileInfo.exists() || folderFileInfo.isFile()) {
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

void ConfigurationWindowBackend::setIsToMonitorFolder(bool isToMonitorFolder) {
    m_isToMonitorFolder = isToMonitorFolder;
}
