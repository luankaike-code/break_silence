#include "files.h"
#include <QMediaFormat>
#include <QDebug>
#include <QMediaPlayer>
#include <QDir>
#include <QFileInfo>
#include <QStringList>
#include <iostream>

namespace fs = std::filesystem;

QStringList Files::audioExtensionsFilter = {
    "*.mp3", "*.m4a", "*.m4b", "*.aac", "*.ogg", "*.oga", "*.opus", "*.wma", "*.webm",
    "*.wav", "*.wave", "*.flac", "*.alac", "*.aiff", "*.aif", "*.ape", "*.shn", "*.wv",
    "*.mp4", "*.mkv", "*.avi", "*.mov", "*.amr", "*.ac3", "*.eac3"
};

QStringList Files::getAllAudiosAtFolder(const QString& path) {
    QDir folder(path);

    folder.setNameFilters(Files::audioExtensionsFilter);
    folder.setFilter(QDir::Files | QDir::NoDotAndDotDot);

    QStringList audioFiles;
    for (const QFileInfo &fileInfo : folder.entryInfoList()) {
        audioFiles.append(fileInfo.absoluteFilePath());
    }

    std::cout << audioFiles.size() << std::endl;

    return audioFiles;
}
