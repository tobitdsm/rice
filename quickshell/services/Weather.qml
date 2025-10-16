pragma Singleton

import "root:/utils"
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string icon
    property string description
    property real temperature

    property int code

    property string descriptions

    function reload(): void {
        wttrProc.running = true;
    }

    Process {
        id: wttrProc

        running: true
        command: [`bash`, `-c`, `~/.config/quickshell/utils/scripts/weather.sh`]
        stdout: SplitParser {
            onRead: data => {
                const json = JSON.parse(data);
                root.code = json.code;
                root.temperature = Math.round(json.temp);

                // var process = new QProcess;
                // process.start("cat", ["~/.config/quickshell/services/weather-descriptions.json"]);

                // var xhr = new XMLHttpRequest;
                // xhr.open("GET", "~/.config/quickshell/services/weather-descriptions.json");
                // xhr.onreadystatechange = function () {
                //     if (xhr.readyState === XMLHttpRequest.DONE) {
                //         var response = xhr.responseText;
                //         console.log(response);
                //     }
                // };
                // xhr.send();
            }
        }

        onExited: {
            wttrProc2.running = true;
        }
    }

    Process {
        id: wttrProc2

        onStarted: {
            root.descriptions = "";
        }

        running: false
        command: [`bash`, `-c`, `cat ~/.config/quickshell/services/weather-descriptions.json`]
        stdout: SplitParser {
            onRead: line => {
                root.descriptions += line + "\n";
            }
        }

        onExited: {
            const json = JSON.parse(root.descriptions);
            const info = json[root.code.toString()];
            const hour = (new Date()).getHours();
            if (hour >= 6 && hour < 18) {
                root.icon = info.day.image;
                root.description = info.day.description;
            } else {
                root.icon = info.night.image;
                root.description = info.night.description;
            }
        }
    }
}
