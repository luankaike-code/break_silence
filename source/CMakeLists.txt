qt_add_executable(BreakSilence.APP
    main.cpp
    files.h files.cpp
    configurationwindowbackend.h configurationwindowbackend.cpp
)

qt_add_qml_module(BreakSilence.APP.MetaObjects
    URI "BreakSilence.APP.MetaObjects"
    SOURCES
        configurationwindowbackend.h configurationwindowbackend.cpp
)