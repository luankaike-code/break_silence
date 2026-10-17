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

    const QStringList& getSoundPaths();
    void forceSoundPathsUpdate();

    const QString& getFolderPath();
    const int& getMinSoundDelay();
    const int& getMaxSoundDelay();
    const bool& getIsToMonitorFolder();

    void setFolderPath(const QString& folderPath);
    void setMinSoundDelay(const int& minSoundDelay);
    void setMaxSoundDelay(const int& maxSoundDelay);
    void setIsToMonitorFolder(const bool& isToMonitorFolder);

signals:
    void errorSoundNotFound(const QString& soundPath);
    void errorFolderNotHasSound();
};

#endif // RANDOMSOUNDPLAYERBACKEND_H
