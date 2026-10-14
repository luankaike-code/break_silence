#include "configurationwindowbackend.h"
#include <iostream>

ConfigurationWindowBackend::ConfigurationWindowBackend(QObject *parent)
    : QObject{parent},
    m_minDelaySoundInMs(-1),
    m_maxDelaySoundInMs(-1),
    m_isToMonitorFolder(false),
    m_repositoryPath("")
{}

void ConfigurationWindowBackend::startSession() {
    std::cout << "Iniciar sessão" << std::endl;
}

const QString& ConfigurationWindowBackend::getRepositoryPath() {
    return m_repositoryPath;
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

void ConfigurationWindowBackend::setRepositoryPath(const QString& repositoryPath) {
    m_repositoryPath = repositoryPath;
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
