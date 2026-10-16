qt_add_executable(BreakSilence.APP
    main.cpp
    files.h files.cpp
    configurationwindowbackend.h configurationwindowbackend.cpp
    numbers.h numbers.cpp
)

qt_add_qml_module(BreakSilence.APP.MetaObjects
    URI "BreakSilence.APP.MetaObjects"
    OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/BreakSilence/source"
    SOURCES
        configurationwindowbackend.h configurationwindowbackend.cpp
        randomsoundplayerbackend.h randomsoundplayerbackend.cpp
)