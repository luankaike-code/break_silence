#ifndef CONFIGURATIONWINDOWBACKEND_H
#define CONFIGURATIONWINDOWBACKEND_H

#include <QObject>
#include <QQmlEngine>

class ConfigurationWindowBackend : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString folderPath READ getFolderPath WRITE setFolderPath REQUIRED)
    Q_PROPERTY(int minSoundDelayInMs READ getMinSoundDelayInMs WRITE setMinSoundDelayInMs REQUIRED)
    Q_PROPERTY(int maxSoundDelayInMs READ getMaxSoundDelayInMs WRITE setMaxSoundDelayInMs REQUIRED)
    Q_PROPERTY(int minSoundVolume READ getMinSoundVolume WRITE setMinSoundVolume REQUIRED)
    Q_PROPERTY(int maxSoundVolume READ getMaxSoundVolume WRITE setMaxSoundVolume REQUIRED)
    Q_PROPERTY(bool isToMonitorFolder READ getIsToMonitorFolder WRITE setIsToMonitorFolder REQUIRED)

    QString m_folderPath;
    int m_minSoundDelayInMs;
    int m_maxSoundDelayInMs;
    int m_minSoundVolume;
    int m_maxSoundVolume;
    bool m_isToMonitorFolder;

public:
    explicit ConfigurationWindowBackend(QObject *parent = nullptr);

    Q_INVOKABLE void startSession();

    QString getFolderPath();
    int getMinSoundDelayInMs();
    int getMaxSoundDelayInMs();
    int getMinSoundVolume();
    int getMaxSoundVolume();
    bool getIsToMonitorFolder();

    void setFolderPath(const QString& folderPath);
    void setMinSoundDelayInMs(int minSoundDelayInMs);
    void setMaxSoundDelayInMs(int maxSoundDelayInMs);
    void setMinSoundVolume(int minSoundVolume);
    void setMaxSoundVolume(int maxSoundVolume);
    void setIsToMonitorFolder(bool isToMonitorFolder);

signals:
    void sessionStarted();

    void errorInvalidMinMaxDelayInterval();
    void errorInvalidMinMaxVolumeInterval();
    void errorInvalidFolder();
    void errorEmptyFolder();
};

#endif // CONFIGURATIONWINDOWBACKEND_H