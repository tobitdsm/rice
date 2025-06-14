import "root:/widgets"
import "root:/services"
import "root:/config"
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls

Item {
    id: root

    required property real nonAnimWidth
    property alias currentIndex: bar.currentIndex
    readonly property TabBar bar: bar

    implicitHeight: bar.implicitHeight + indicator.implicitHeight + indicator.anchors.bottomMargin + separator.implicitHeight

    TabBar {
        id: bar

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        background: null

        Tab {
            iconName: "dashboard"
            text: qsTr("Dashboard")
        }

        Tab {
            iconName: "queue_music"
            text: qsTr("Media")
        }

        Tab {
            iconName: "speed"
            text: qsTr("Performance")
        }
    }

    Item {
        id: indicator

        anchors.bottom: bar.top
        anchors.bottomMargin: DashboardConfig.sizes.tabIndicatorSpacing

        implicitWidth: bar.currentItem.implicitWidth
        implicitHeight: DashboardConfig.sizes.tabIndicatorHeight

        x: {
            const tab = bar.currentItem;
            const width = (root.nonAnimWidth - DashboardConfig.sizes.tabIndicatorSpacing * (bar.count - 1) * 2) / bar.count
            return width * tab.TabBar.index + (width - tab.implicitWidth) / 2;
        }

        clip: true

        StyledRect {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: parent.implicitHeight * 2

            color: Colours.palette.m3primary
            radius: Appearance.rounding.full

        }

        Behavior on x {
            Anim {}
        }

        Behavior on implicitWidth {
            Anim {}
        }
    }

    StyledRect {
        id: separator

        anchors.bottom: indicator.top
        anchors.left: parent.left
        anchors.right: parent.right

        implicitHeight: 1
        color: Colours.palette.m3tertiary
    }

    component Tab: TabButton {
        id: tab

        required property string iconName
        readonly property bool current: TabBar.tabBar.currentItem === this

        background: null

        contentItem: MouseArea {
            id: mouse

            implicitWidth: Math.max(icon.width, label.width)
            implicitHeight: icon.height + label.height

            cursorShape: Qt.PointingHandCursor

            onPressed: ({x,y}) => {
                tab.TabBar.tabBar.setCurrentIndex(tab.TabBar.index);

                const stateY = stateWrapper.y;
                rippleAnim.x = x;
                rippleAnim.y = y - stateY;

                const dist = (ox,oy) => ox * ox + oy * oy;
                const stateEndY = stateY + stateWrapper.height;
                rippleAnim.radius = Math.sqrt(Math.max(dist(0, stateY), dist(0, stateEndY), dist(width, stateY), dist(width, stateEndY)));

                rippleAnim.restart();
            }
            onWheel: event => {
                if (event.angleDelta.y < 0)
                    tab.TabBar.tabBar.incrementCurrentIndex();
                else if (event.angleDelta.y > 0)
                    tab.TabBar.tabBar.decrementCurrentIndex();
            }

            SequentialAnimation {
                id: rippleAnim

                property real x
                property real y
                property real radius

                PropertyAction {
                    target: ripple
                    property: "x"
                    value: rippleAnim.x
                }
                PropertyAction {
                    target: ripple
                    property: "y"
                    value: rippleAnim.y
                }
                PropertyAction {
                    target: ripple
                    property: "opacity"
                    value: 0.1
                }
                ParallelAnimation {
                    Anim {
                        target: ripple
                        properties: "implicitWidth,implicitHeight"
                        from: 0
                        to: rippleAnim.radius * 2
                        duration: Appearance.anim.durations.large
                        easing.bezierCurve: Appearance.anim.curves.standardDecel
                    }
                    Anim {
                        target: ripple
                        property: "opacity"
                        to: 0
                        duration: Appearance.anim.durations.large
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Appearance.anim.curves.standardDecel
                    }
                }
            }

            ClippingRectangle {
                id: stateWrapper

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                implicitHeight: parent.height + DashboardConfig.sizes.tabIndicatorSpacing * 2

                color: "transparent"
                radius: Appearance.rounding.small

                StyledRect {
                    id: stateLayer

                    anchors.fill: parent

                    color: tab.current ? Colours.palette.m3primary : Colours.palette.m3secondary
                    opacity: mouse.pressed ? 0.1 : tab.hovered ? 0.08 : 0

                    Behavior on opacity {
                        Anim {}
                    }
                }

                StyledRect {
                    id: ripple

                    radius: Appearance.rounding.full
                    color: tab.current ? Colours.palette.m3primary : Colours.palette.m3secondary
                    opacity: 0

                    transform: Translate {
                        x: -ripple.width / 2
                        y: -ripple.height / 2
                    }
                }
            }

            MaterialIcon {
                id: icon

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: label.top

                text: tab.iconName
                color: tab.current ? Colours.palette.m3primary : Colours.palette.m3secondary
                fill: tab.current ? 1 : 0
                font.pointSize: Appearance.font.size.large

                Behavior on fill {
                    NumberAnimation {
                        duration: Appearance.anim.durations.normal
                        easing.type: Easing.BezierSpline
                        easing.bezierCurve: Appearance.anim.curves.standard
                    }
                }
            }

            StyledText {
                id: label

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom

                text: tab.text
                color: tab.current ? Colours.palette.m3primary : Colours.palette.m3secondary
            }

        }
    }

    component Anim: NumberAnimation {
        duration: Appearance.anim.durations.normal
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.anim.curves.standard
    }
}
