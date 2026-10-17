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
    Q_PROPERTY(bool isToMonitorFolder READ getIsToMonitorFolder WRITE setIsToMonitorFolder REQUIRED)

    QString m_folderPath;
    int m_minSoundDelayInMs;
    int m_maxSoundDelayInMs;
    bool m_isToMonitorFolder;
public:
    explicit ConfigurationWindowBackend(QObject *parent = nullptr);

    Q_INVOKABLE void startSession();

    const QString& getFolderPath();
    const int& getMinSoundDelayInMs();
    const int& getMaxSoundDelayInMs();
    const bool& getIsToMonitorFolder();

    void setFolderPath(const QString& folderPath);
    void setMinSoundDelayInMs(const int& minSoundDelayInMs);
    void setMaxSoundDelayInMs(const int& maxSoundDelayInMs);
    void setIsToMonitorFolder(const bool& isToMonitorFolder);
signals:
    void sessionStarted();

    void errorInvalidMinMaxDelayInterval();
    void errorInvalidFolder();
    void errorEmptyFolder();
};

#endif // CONFIGURATIONWINDOWBACKEND_H
