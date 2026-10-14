import QtQuick

Input {
    validator: RegularExpressionValidator {
        regularExpression: /[0-9]+/
    }
}
