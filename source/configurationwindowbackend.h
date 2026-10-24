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
    Q_PROPERTY(double minSoundVolumeNormalized READ getMinSoundVolumeNormalized WRITE setMinSoundVolumeNormalized REQUIRED)
    Q_PROPERTY(double maxSoundVolumeNormalized READ getMaxSoundVolumeNormalized WRITE setMaxSoundVolumeNormalized REQUIRED)
    Q_PROPERTY(bool isToMonitorFolder READ getIsToMonitorFolder WRITE setIsToMonitorFolder REQUIRED)

    QString m_folderPath;
    int m_minSoundDelayInMs;
    int m_maxSoundDelayInMs;
    double m_minSoundVolumeNormalized;
    double m_maxSoundVolumeNormalized;
    bool m_isToMonitorFolder;

public:
    explicit ConfigurationWindowBackend(QObject *parent = nullptr);

    Q_INVOKABLE void startSession();

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
    void sessionStarted();

    void errorInvalidMinMaxDelayInterval();
    void errorInvalidMinMaxVolumeInterval();
    void errorInvalidFolder();
    void errorEmptyFolder();
};

#endif // CONFIGURATIONWINDOWBACKEND_H