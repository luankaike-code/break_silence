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
    Q_PROPERTY(int minSoundDelayInMs READ getMinSoundDelayInMs WRITE setMinSoundDelayInMs REQUIRED)
    Q_PROPERTY(int maxSoundDelayInMs READ getMaxSoundDelayInMs WRITE setMaxSoundDelayInMs REQUIRED)
    Q_PROPERTY(double minSoundVolumeNormalized READ getMinSoundVolumeNormalized WRITE setMinSoundVolumeNormalized REQUIRED)
    Q_PROPERTY(double maxSoundVolumeNormalized READ getMaxSoundVolumeNormalized WRITE setMaxSoundVolumeNormalized REQUIRED)
    Q_PROPERTY(bool isToMonitorFolder READ getIsToMonitorFolder WRITE setIsToMonitorFolder REQUIRED)


    QString m_folderPath;
    int m_minSoundDelayInMs;
    int m_maxSoundDelayInMs;
    double m_minSoundVolumeNormalized;
    double m_maxSoundVolumeNormalized;
    bool m_isToMonitorFolder;

    QStringList m_soundPaths;
public:
    explicit RandomSoundPlayerBackend(QObject *parent = nullptr);

    Q_INVOKABLE QString getRandomSoundOnFolder();
    Q_INVOKABLE int getDelayToNextSoundInMs();
    Q_INVOKABLE double getVolumeNormalizedToNextSound();

    QStringList getSoundPaths();
    void forceSoundPathsUpdate();

    QString getFolderPath();
    int getMinSoundDelayInMs();
    int getMaxSoundDelayInMs();
    double getMinSoundVolumeNormalized();
    double getMaxSoundVolumeNormalized();
    bool getIsToMonitorFolder();

    void setFolderPath(const QString& folderPath);
    void setMinSoundDelayInMs(int minSoundDelayInMs);
    void setMaxSoundDelayInMs(int maxSoundDelayInMs);
    void setMinSoundVolumeNormalized(double minSoundVolumeNormalized);
    void setMaxSoundVolumeNormalized(double maxSoundVolumeNormalized);
    void setIsToMonitorFolder(bool isToMonitorFolder);

signals:
    void errorSoundNotFound(const QString& soundPath);
    void errorFolderNotHasSound();
};

#endif // RANDOMSOUNDPLAYERBACKEND_H
