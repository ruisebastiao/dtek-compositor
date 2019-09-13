import QtQuick 2.8
import QtQml 2.2


Item {

    id:screenmanager

    property alias screens: screens

    Instantiator {
        id: screens
        model: Qt.application.screens

        onObjectAdded: {
            object.index=index
        }

        delegate: ScreenOutput {

            text: name
            compositor: comp
            screen: modelData
            Component.onCompleted: if (!comp.defaultOutput) comp.defaultOutput = this
            position: Qt.point(virtualX, virtualY)
        }
    }

}
