#ifndef CONFIGURATIONWINDOWBACKEND_H
#define CONFIGURATIONWINDOWBACKEND_H

#include <QObject>
#include <QQmlEngine>

class ConfigurationWindowBackend : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QString repositoryPath READ getRepositoryPath WRITE setRepositoryPath REQUIRED)
    Q_PROPERTY(int minDelaySoundInMs READ getMinDelaySoundInMs WRITE setMinDelaySoundInMs REQUIRED)
    Q_PROPERTY(int maxDelaySoundInMs READ getMaxDelaySoundInMs WRITE setMaxDelaySoundInMs REQUIRED)
    Q_PROPERTY(bool isToMonitorFolder READ getIsToMonitorFolder WRITE setIsToMonitorFolder REQUIRED)

    QString m_repositoryPath;
    int m_minDelaySoundInMs;
    int m_maxDelaySoundInMs;
    bool m_isToMonitorFolder;
public:
    explicit ConfigurationWindowBackend(QObject *parent = nullptr);

    Q_INVOKABLE void startSession();

    const QString& getRepositoryPath();
    const int& getMinDelaySoundInMs();
    const int& getMaxDelaySoundInMs();
    const bool& getIsToMonitorFolder();

    void setRepositoryPath(const QString& repositoryPath);
    void setMinDelaySoundInMs(const int& minDelaySoundInMs);
    void setMaxDelaySoundInMs(const int& maxDelaySoundInMs);
    void setIsToMonitorFolder(const bool& isToMonitorFolder);
signals:
    void errorInvalidMinMaxDelayInterval();
    void errorInvalidFolder();
    void errorEmptyFolder();
};

#endif // CONFIGURATIONWINDOWBACKEND_H
