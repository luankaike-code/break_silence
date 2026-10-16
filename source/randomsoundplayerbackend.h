#ifndef RANDOMSOUNDPLAYERBACKEND_H
#define RANDOMSOUNDPLAYERBACKEND_H

#include <QObject>
#include <QQmlEngine>
#include <QStringList>

class RandomSoundPlayerBackend : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString folderPath READ getFolderPath WRITE setFolderPath REQUIRED)
    Q_PROPERTY(bool isToMonitorFolder READ getIsToMonitorFolder WRITE setIsToMonitorFolder REQUIRED)

    QString m_folderPath;
    bool m_isToMonitorFolder;

    QStringList m_soundPaths;
public:
    explicit RandomSoundPlayerBackend(QObject *parent = nullptr);

    Q_INVOKABLE QString getRandomSoundOnFolder();
    const bool& getIsToMonitorFolder();
    void forceSoundPathsUpdate();

    const QString& getFolderPath();
    const QStringList& getSoundPaths();

    void setFolderPath(const QString& folderPath);
    void setIsToMonitorFolder(const bool& isToMonitorFolder);
signals:
    void errorSoundNotFound(const QString& soundPath);
    void errorFolderNotHasSound();
};

#endif // RANDOMSOUNDPLAYERBACKEND_H
