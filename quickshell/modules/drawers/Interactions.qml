import "root:/services"
import "root:/config"
import "root:/modules/osd" as Osd
import Quickshell
import QtQuick

MouseArea {
    id: root

    required property ShellScreen screen
    required property PersistentProperties visibilities
    required property Panels panels
    required property Item bar

    property bool osdHovered
    property point dragStart

    function withinPanelHeight(panel: Item, x: real, y: real): bool {
        const panelY = BorderConfig.thickness + panel.y;
        return y >= panelY - BorderConfig.rounding && y <= panelY + panel.height + BorderConfig.rounding;
    }

    function inLeftPanel(panel: Item, x: real, y: real): bool {
        return x < panel.width + BorderConfig.thickness && withinPanelHeight(panel, x, y);
    }

    function inBottomPanel(panel: Item, x: real, y: real): bool {
        const panelX = panel.x;
        return y > panel.y - BorderConfig.thickness && x >= panelX - BorderConfig.rounding && x <= panelX + panel.width + BorderConfig.rounding;
    }

    anchors.fill: parent
    hoverEnabled: true

    onPressed: event => dragStart = Qt.point(event.x, event.y)
    onContainsMouseChanged: {
        if (!containsMouse) {
            visibilities.osd = false;
            osdHovered = false;
            visibilities.dashboard = false;
        }
    }

    onPositionChanged: ({x, y}) => {
        // Show osd on hover
        const showOsd = inLeftPanel(panels.osd, x, y);
        visibilities.osd = showOsd;
        osdHovered = showOsd;

        // Show dashboard on hover
        visibilities.dashboard = inBottomPanel(panels.dashboard, x, y);
    }

    Osd.Interactions {
        screen: root.screen
        visibilities: root.visibilities
        hovered: root.osdHovered
    }
}
