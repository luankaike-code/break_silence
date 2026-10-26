import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

RowLayout {
    id: root

    required property variant model

    property int maxValue: 0
    property int inputDefaultValue: -1
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
        text: inputDefaultValue  < 0? "" : inputDefaultValue
        placeholderText: root.placeholderText
        Layout.preferredWidth: conteinerWidth - magnitude.width - root.spacing
        isEmphasisError: root.isEmphasisError
        maxValue: root.maxValue
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
