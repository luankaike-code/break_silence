import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    width: 640
    height: 480
    title: qsTr("BASEWINDOW - SET TITLE")

    Material.theme: Qt.styleHints.colorScheme === Qt.Dark ? Material.Dark : Material.Light
}
