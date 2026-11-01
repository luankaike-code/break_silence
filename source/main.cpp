#include <QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <iostream>
#include "iconmanager.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setWindowIcon(QIcon(
        IconManager::getIconPath(IconManager::Enum::Normal,  true)
    ));

    app.setOrganizationName("luankaike-code");
    app.setOrganizationDomain("github.com/luankaike-code");
    app.setApplicationName("BreakSilence");
    app.setApplicationDisplayName("BreakSilence");
    app.setApplicationVersion("v1.0.0");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("BreakSilence.MetaObjects", "Main");

    return QCoreApplication::exec();
}
