#ifndef FILES_H
#define FILES_H

#include <QObject>
#include <QtQml/qqmlregistration.h>

namespace fs = std::filesystem;

class Files {
public:
    Files() = delete;
    Files(const Files&) = delete;

    static QStringList audioExtensionsFilter;

    static QStringList getAllAudiosAtFolder(const QString& path);
};

#endif // FILES_H
