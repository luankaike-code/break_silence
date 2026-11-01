#ifndef ICONMANAGER_H
#define ICONMANAGER_H

#include <QQmlEngine>
#include <QObject>
#include <qqmlintegration.h>

class IconManager : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit IconManager(QObject* parent = nullptr);

    enum Enum {
        Normal,
        Paused,
        Played
    };
    Q_ENUM(Enum)

    Q_INVOKABLE static QString getIconPath(int enumIcon, bool useRelativeQMLPath = false);
};

#endif // ICONMANAGER_H
