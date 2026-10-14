qt_add_qml_module(BreakSilence.MetaObjects
    URI "BreakSilence.MetaObjects"
    RESOURCE_PREFIX "/qt/qml"
    OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/BreakSilence/MetaObjects"
    QML_FILES
        Main.qml
        components/BaseWindow.qml
        components/ConfigurationWindow.qml
        components/SystemTray.qml
        components/Input.qml
        components/ButtonImage.qml
        components/ButtonFolderDialog.qml
)
