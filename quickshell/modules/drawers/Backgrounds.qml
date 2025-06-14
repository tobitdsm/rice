import "root:/services"
import "root:/config"
import "root:/modules/osd" as Osd
import "root:/modules/dashboard" as Dashboard
import QtQuick
import QtQuick.Shapes

Shape {
    id: root

    required property Panels panels
    required property Item bar

    anchors.fill: parent
    preferredRendererType: Shape.CurveRenderer
    opacity: Colours.transparency.enabled ? Colours.transparency.base : 1

    Osd.Background {
        wrapper: panels.osd

        startX: 0
        startY: (root.height - wrapper.height) / 2 - rounding
    }

    Dashboard.Background {
        wrapper: panels.dashboard

        startX: (root.width - wrapper.width) / 2 - rounding
        startY: root.height
    }
}
