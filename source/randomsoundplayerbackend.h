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
    Q_PROPERTY(int minSoundDelay READ getMinSoundDelay WRITE setMinSoundDelay REQUIRED)
    Q_PROPERTY(int maxSoundDelay READ getMaxSoundDelay WRITE setMaxSoundDelay REQUIRED)
    Q_PROPERTY(bool isToMonitorFolder READ getIsToMonitorFolder WRITE setIsToMonitorFolder REQUIRED)


    QString m_folderPath;
    int m_minSoundDelay;
    int m_maxSoundDelay;
    bool m_isToMonitorFolder;

    QStringList m_soundPaths;
public:
    explicit RandomSoundPlayerBackend(QObject *parent = nullptr);

    Q_INVOKABLE QString getRandomSoundOnFolder();
    Q_INVOKABLE int getDelayToNextSoundInMs();

    QStringList getSoundPaths();
    void forceSoundPathsUpdate();

    QString getFolderPath();
    int getMinSoundDelay();
    int getMaxSoundDelay();
    bool getIsToMonitorFolder();

    void setFolderPath(const QString& folderPath);
    void setMinSoundDelay(int minSoundDelay);
    void setMaxSoundDelay(int maxSoundDelay);
    void setIsToMonitorFolder(bool isToMonitorFolder);

signals:
    void errorSoundNotFound(const QString& soundPath);
    void errorFolderNotHasSound();
};

#endif // RANDOMSOUNDPLAYERBACKEND_H
