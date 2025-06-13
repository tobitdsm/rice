pragma Singleton

import "root:/utils"
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string icon
    property string description
    property real temperature

    function reload(): void {
        wttrProc.running = true;
    }

    Process {
        id: wttrProc

        running: true
        command: [`bash`, `-c`, `loc=$(curl ipinfo.io | jq -r '.loc'); curl https://api.open-meteo.com/v1/forecast?latitude="$(cut -d',' -f1 <<< "$loc")"\&longitude="$(cut -d',' -f2 <<< "$loc")"\&current=temperature_2m,weather_code | jq -r .current | jq -c '{code: .weather_code, temp: .temperature_2m}'`]
        stdout: SplitParser {
            onRead: data => {
                const json = JSON.parse(data);
                console.log(json);
                root.icon = Icons.getWeatherIcon(json.code);
                root.description = Icons.getWeatherDescription(json.code);
                root.temperature = parseFloat(json.temp);
            }
        }
    }
}
