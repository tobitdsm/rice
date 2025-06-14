pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property var osIcons: ({
            almalinux: "",
            alpine: "",
            arch: "",
            archcraft: "",
            arcolinux: "",
            artix: "",
            centos: "",
            debian: "",
            devuan: "",
            elementary: "",
            endeavouros: "",
            fedora: "",
            freebsd: "",
            garuda: "",
            gentoo: "",
            hyperbola: "",
            kali: "",
            linuxmint: "󰣭",
            mageia: "",
            openmandriva: "",
            manjaro: "",
            neon: "",
            nixos: "",
            opensuse: "",
            suse: "",
            sles: "",
            sles_sap: "",
            "opensuse-tumbleweed": "",
            parrot: "",
            pop: "",
            raspbian: "",
            rhel: "",
            rocky: "",
            slackware: "",
            solus: "",
            steamos: "",
            tails: "",
            trisquel: "",
            ubuntu: "",
            vanilla: "",
            void: "",
            zorin: ""
        })

    readonly property var desktopEntrySubs: ({})

    readonly property var categoryIcons: ({
            WebBrowser: "web",
            Printing: "print",
            Security: "security",
            Network: "chat",
            Archiving: "archive",
            Compression: "archive",
            Development: "code",
            IDE: "code",
            TextEditor: "edit_note",
            Audio: "music_note",
            Music: "music_note",
            Player: "music_note",
            Recorder: "mic",
            Game: "sports_esports",
            FileTools: "files",
            FileManager: "files",
            Filesystem: "files",
            FileTransfer: "files",
            Settings: "settings",
            DesktopSettings: "settings",
            HardwareSettings: "settings",
            TerminalEmulator: "terminal",
            ConsoleOnly: "terminal",
            Utility: "build",
            Monitor: "monitor_heart",
            Midi: "graphic_eq",
            Mixer: "graphic_eq",
            AudioVideoEditing: "video_settings",
            AudioVideo: "music_video",
            Video: "videocam",
            Building: "construction",
            Graphics: "photo_library",
            "2DGraphics": "photo_library",
            RasterGraphics: "photo_library",
            TV: "tv",
            System: "host",
            Office: "content_paste"
        })

    property string osIcon: ""
    property string osName

    function getDesktopEntry(name: string): DesktopEntry {
        name = name.toLowerCase().replace(/ /g, "-");

        if (desktopEntrySubs.hasOwnProperty(name))
            name = desktopEntrySubs[name];

        return DesktopEntries.applications.values.find(a => a.id.toLowerCase() === name) ?? null;
    }

    function getAppIcon(name: string, fallback: string): string {
        return Quickshell.iconPath(getDesktopEntry(name)?.icon, fallback);
    }

    function getAppCategoryIcon(name: string, fallback: string): string {
        const categories = getDesktopEntry(name)?.categories;

        if (categories)
            for (const [key, value] of Object.entries(categoryIcons))
                if (categories.includes(key))
                    return value;
        return fallback;
    }

    function getNetworkIcon(strength: int): string {
        if (strength >= 80)
            return "signal_wifi_4_bar";
        if (strength >= 60)
            return "network_wifi_3_bar";
        if (strength >= 40)
            return "network_wifi_2_bar";
        if (strength >= 20)
            return "network_wifi_1_bar";
        return "signal_wifi_0_bar";
    }

    function getBluetoothIcon(icon: string): string {
        if (icon.includes("headset") || icon.includes("headphones"))
            return "headphones";
        if (icon.includes("audio"))
            return "speaker";
        if (icon.includes("phone"))
            return "smartphone";
        return "bluetooth";
    }

    function getWeatherIcon(code: string): string {
        code = parseInt(code);
        if (code === 0) {
            return "clear_day";
        } else if (code === 1) {
            return "partly_cloudy_day";
        } else if (code === 2) {
            return "cloud";
        } else if (code < 50) {
            return "foggy";
        } else if (code < 68) {
            return "rainy";
        } else if (code < 78) {
            return "snowing";
        } else if (code < 83) {
            return "cloudy_snowing";
        } else if (code < 87) {
            return "rainy";
        } else if (code < 100) {
            return "thunderstorm";
        } else {
            return "air";
        }
    }

    function getWeatherDescription(code: string): string {
        code = parseInt(code);
        if (code === 0) {
            return "Sunny";
        } else if (code === 1) {
            return "Partly cloudy";
        } else if (code === 2) {
            return "Cloudy";
        } else if (code < 50) {
            return "Foggy";
        } else if (code < 58) {
            return "Drizzle";
        } else if (code < 68) {
            return "Rain";
        } else if (code < 78) {
            return "Snow or ice pellets";
        } else if (code < 83) {
            return "Rain showers";
        } else if (code < 87) {
            return "Snow showers";
        } else if (code < 100) {
            return "Thunderstorms";
        } else {
            return "No weather info";
        }
    }

    FileView {
        path: "/etc/os-release"
        onLoaded: {
            const lines = text().split("\n");
            let osId = lines.find(l => l.startsWith("ID="))?.split("=")[1];
            if (root.osIcons.hasOwnProperty(osId))
                root.osIcon = root.osIcons[osId];
            else {
                const osIdLike = lines.find(l => l.startsWith("ID_LIKE="))?.split("=")[1];
                if (osIdLike)
                    for (const id of osIdLike.split(" "))
                        if (root.osIcons.hasOwnProperty(id))
                            return root.osIcon = root.osIcons[id];
            }

            let nameLine = lines.find(l => l.startsWith("PRETTY_NAME="));
            if (!nameLine)
                nameLine = lines.find(l => l.startsWith("NAME="));
            root.osName = nameLine.split("=")[1].slice(1, -1);
        }
    }
}
