import "root:/services"
import "root:/config"
import "root:/modules/osd" as Osd
import "root:/modules/dashboard" as Dashboard
import Quickshell
import QtQuick

Item {
    id: root

    required property ShellScreen screen
    required property PersistentProperties visibilities
    required property Item bar

    readonly property Osd.Wrapper osd: osd
    readonly property Dashboard.Wrapper dashboard: dashboard

    anchors.fill: parent

    Component.onCompleted: Visibilities.panels[screen] = this

    Osd.Wrapper {
        id: osd

        clip: root.visibilities.session
        screen: root.screen
        visibility: root.visibilities.osd

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: session.width
    }

    Dashboard.Wrapper {
        id: dashboard

        visibilities: root.visibilities

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }
}
