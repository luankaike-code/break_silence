#include "iconmanager.h"
#include <QGuiApplication>
#include <QStyleHints>

IconManager::IconManager(QObject* parent): QObject(parent) {}


QString IconManager::getIconPath(int enumIcon, bool useRelativeQMLPath) {
    bool isDarkMode = QGuiApplication::styleHints()->colorScheme() == Qt::ColorScheme::Dark;

    QString iconSuffix = isDarkMode? "_dark.svg" : "_light.svg";
    QString iconBashPath = useRelativeQMLPath? ":/assets/breaksilence" : "qrc:/assets/breaksilence";

    switch (enumIcon) {
        case Normal: return iconBashPath + iconSuffix;
        case Paused: return iconBashPath + "_paused" + iconSuffix;
        case Played: return iconBashPath + "_played" + iconSuffix;
        default: return "";
    }
}
