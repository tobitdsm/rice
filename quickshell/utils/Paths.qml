pragma Singleton

import Quickshell
import Qt.labs.platform

Singleton {
    id: root

    readonly property url home: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
    readonly property url pictures: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]

    readonly property url data: `${StandardPaths.standardLocations(StandardPaths.GenericDataLocation)[0]}/quickshell`
    readonly property url state: `${StandardPaths.standardLocations(StandardPaths.GenericStateLocation)[0]}/quickshell`
    readonly property url cache: `${StandardPaths.standardLocations(StandardPaths.GenericCacheLocation)[0]}/quickshell`
}
