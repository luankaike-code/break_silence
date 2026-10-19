import QtQuick

import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    id: root
    title: "INFORMATIVE DIALOG"
    width: 500

    anchors.centerIn: parent
    modal: true

    standardButtons: Dialog.Ok

    property string text: "TEXT TEXT TEXT"

    Label {
        width: root.width-40
        anchors.centerIn: parent
        wrapMode: Text.WordWrap
        text: root.text
    }
}