import QtQuick

Input {
    id: root
    property int maxValue: 0

    validator: RegularExpressionValidator {
        regularExpression: /[0-9]+/
    }

    onTextChanged: {
        if(maxValue <= 0)
            return

        let textNumber = root.text === ""? 0 : parseInt(root.text)
        textNumber = Math.min(textNumber, maxValue)
        text = String(textNumber)
    }
}
