import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

RowLayout {
    id: root
    required property variant model
    property string placeholderText: qsTr("placeholderText")
    property bool isEmphasisError: false
    property int conteinerWidth: 300
    property int currentIndex: 0

    function getValue() {
        const inputValue = input.text === ""? 0 : parseInt(input.text)
        const magnituteValue = magnitude.currentValue === undefined? 0 : parseInt(magnitude.currentValue)

        return inputValue * magnituteValue
    }

    InputNumber {
        id: input
        placeholderText: root.placeholderText
        Layout.preferredWidth: conteinerWidth - magnitude.width
        isEmphasisError: root.isEmphasisError
    }

    ComboBox {
        id: magnitude
        model: root.model

        Layout.preferredWidth: conteinerWidth/4

        currentIndex: root.currentIndex
        textRole: "text"
        valueRole: "value"
    }
}
