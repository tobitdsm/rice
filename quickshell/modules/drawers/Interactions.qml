import "root:/services"
import "root:/config"
import "root:/modules/bar/popouts" as BarPopouts
import "root:/modules/osd" as Osd
import Quickshell
import QtQuick

MouseArea {
    id: root

    required property ShellScreen screen
    required property BarPopouts.Wrapper popouts
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
            popouts.hasCurrent = false;
        }
    }

    onPositionChanged: ({x, y}) => {
        // Show osd on hover
        const showOsd = inLeftPanel(panels.osd, x, y);
        visibilities.osd = showOsd;
        osdHovered = showOsd;

        // Show/hide session on drag
        if (pressed && withinPanelHeight(panels.session, x, y)) {
            const dragX = x - dragStart.x;
            if (dragX < -SessionConfig.dragThreshold)
                visibilities.session = true;
            else if (dragX > SessionConfig.dragThreshold)
                visibilities.session = false;
        }

        // Show dashboard on hover
        visibilities.dashboard = inBottomPanel(panels.dashboard, x, y);

        // Show popouts on hover
        const popout = panels.popouts;
        if (x < popout.width) {
            if (true)
                // Handle like part of bar
                bar.checkPopout(y);
            else
                // Keep on hover
                popouts.hasCurrent = withinPanelHeight(popout, x, y);
        } else
            popouts.hasCurrent = false;
    }

    Osd.Interactions {
        screen: root.screen
        visibilities: root.visibilities
        hovered: root.osdHovered
    }
}
