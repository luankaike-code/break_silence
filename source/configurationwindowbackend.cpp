#include "configurationwindowbackend.h"
#include <QFileInfo>
#include <iostream>
#include "files.h"

ConfigurationWindowBackend::ConfigurationWindowBackend(QObject *parent)
    : QObject{parent},
    m_minDelaySoundInMs(-1),
    m_maxDelaySoundInMs(-1),
    m_isToMonitorFolder(false),
    m_folderPath("")
{}

void ConfigurationWindowBackend::startSession() {
    QFileInfo folderFileInfo(m_folderPath);

    if (m_minDelaySoundInMs > m_maxDelaySoundInMs) {
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

    for (QString f : folderSounds) {
        std::cout << "sound found: " <<  f.toStdString() << std::endl;
    }
}

const QString& ConfigurationWindowBackend::getFolderPath() {
    return m_folderPath;
}

const int& ConfigurationWindowBackend::getMinDelaySoundInMs() {
    return m_minDelaySoundInMs;
}

const int& ConfigurationWindowBackend::getMaxDelaySoundInMs() {
    return m_maxDelaySoundInMs;
}

const bool& ConfigurationWindowBackend::getIsToMonitorFolder() {
    return m_isToMonitorFolder;
}

void ConfigurationWindowBackend::setFolderPath(const QString& folderPath) {
    m_folderPath = folderPath;
}

void ConfigurationWindowBackend::setMinDelaySoundInMs(const int& minDelaySoundInMs) {
    m_minDelaySoundInMs = minDelaySoundInMs;
}

void ConfigurationWindowBackend::setMaxDelaySoundInMs(const int& maxDelaySoundInMs) {
    m_maxDelaySoundInMs = maxDelaySoundInMs;
}

void ConfigurationWindowBackend::setIsToMonitorFolder(const bool& isToMonitorFolder) {
    m_isToMonitorFolder = isToMonitorFolder;
}
