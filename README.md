# rice dotfiles

## Table of Contents
- [Introduction](#introduction)
- [Color scheme](#color-scheme)
- [Installation guide](#installation-guide)
	- [Full installation](#full-installation)
	- [Partial installation](#partial-installation)
- [App-by-app categories](#app-by-app-categories)
	- [BetterDiscord](#betterdiscord)
	- [Firefox](#firefox)
	- [GTK](#gtk)
		- [GTK3](#gtk3)
		- [GTK4](#gtk4)
	- [GRUB](#grub)
	- [Hypr](#hypr)
		- [Hyprland](#hyprland)
		- [Hyprpaper](#hyprpaper)
		- [Hypridle](#hypridle)
		- [Hyprlock](#hyprlock)
	- [Ironbar](#ironbar)
	- [kitty](#kitty)
	- [Neofetch](#neofetch)
	- [Quickshell](#quickshell)
	- [Spicetify](#spicetify)
	- [VS Code](#vs-code)
	- [Wofi](#wofi)
- [Outro](#outro)
	- [Inspirations](#inspirations)

## Introduction
This rice was made by me, with much [inspiration](#inspirations) from others. All of them are linked in their respective [categories](#app-by-app-categories) where I took their inspiration from.

At the same time this README acts as a [guide to install](#installation-guide) this rice yourself, or parts of it. I made the rice in Hyprland on Arch Linux, all tools are also linked in their respective [categories](#app-by-app-categories).

If something doesn't work out of the box, it is probably because our setups differ slightly or you don't have certain tools installed. I am after all making this rice all by myself, and in the first place also only for myself.

If you do however think a problem may be fixed by changing my code, please do create an issue or a pull request.

## Color scheme
Just for reference, these are the main colors used in the rice.

![](https://placehold.co/15x15/f59a9a/f59a9a.png) <span style="color:#f59a9a">#f59a9a</span> (main accent color)  
![](https://placehold.co/15x15/141216/141216.png) <span style="background:#141216">#141216</span> (main background color)

extra accent colors:  
![](https://placehold.co/15x15/f66/f66.png) <span style="color:#f66">#ff6666</span>  
![](https://placehold.co/15x15/C76C6C/C76C6C.png) <span style="color:#C76C6C">#c76c6c</span>  
![](https://placehold.co/15x15/993d3d/993d3d.png) <span style="color:#993d3d">#993d3d</span>  

extra background colors:  
![](https://placehold.co/15x15/282432/282432.png) <span style="background:#282432">#282432</span>  
![](https://placehold.co/15x15/3c3642/3c3642.png) <span style="background:#3c3642">#3c3642</span>  
![](https://placehold.co/15x15/504858/504858.png) <span style="background:#504858">#504858</span>  
![](https://placehold.co/15x15/a090b0/a090b0.png) <span style="background:#a090b0">#a090b0</span>

other colors:  
![](https://placehold.co/15x15/2b2135/2b2135.png) <span style="background:#2b2135">#2b2135</span>  
![](https://placehold.co/15x15/64ffff/64ffff.png) <span style="color:#64ffff">#64ffff</span>  
![](https://placehold.co/15x15/79fc64/79fc64.png) <span style="color:#79fc64">#79fc64</span>  
![](https://placehold.co/15x15/ffff66/ffff66.png) <span style="color:#ffff66">#ffff66</span>  
![](https://placehold.co/15x15/5bb0ff/5bb0ff.png) <span style="color:#5bb0ff">#5bb0ff</span>  
![](https://placehold.co/15x15/AC82E9/AC82E9.png) <span style="color:#AC82E9">#ac82e9</span>  
![](https://placehold.co/15x15/8F56E1/8F56E1.png) <span style="color:#8F56E1">#8f56e1</span>  
![](https://placehold.co/15x15/fc7fff/fc7fff.png) <span style="color:#fc7fff">#fc7fff</span>  
![](https://placehold.co/15x15/ffb266/ffb266.png) <span style="color:#ffb266">#ffb266</span>

A lot of these colors come from the [retro-futuristic rice](https://github.com/diinki/diinki-retrofuture/) by diinky.

## Installation guide
### Full installation
If you want to install this rice, and keep updated with my edits, you can clone this repository as follows. This setup is from a guide from [atlassian](https://www.atlassian.com/git/tutorials/dotfiles).

1. Add the following line to your `.bashrc` or `.zshrc` file:
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME/.config/'
```
This way you can manage these dotfiles from anywhere.

2. Now you can clone the repository as follows:
```bash
git clone --bare https://github.com/tobitdsm/rice $HOME/.cfg
```
3. Execute the following commands to finish the git setup (you may have to restart your terminal to get access to the new config alias):
```bash
config checkout
config config --local status.showUntrackedFiles no
```
Now you can update your files anytime with
```bash
config pull
```
If anything fails, please refer to the [atlassian guide](https://www.atlassian.com/git/tutorials/dotfiles). Do note that you need to set your `--work-tree` to `$HOME/.config/` for this rice to work, as opposed to `$HOME` as shown in the guide.

You are now almost done, please read the [guides for each app](#app-by-app-categories) as there are some that require additional setup, and even categories that don't have files in this repo.
### Partial installation
If you wish to only install the rice for some of the apps, you can download the git repo as a zip or clone it, and move the corresponding folder(s) into `$HOME/.config/`.

Please do read the [guides for all relevant apps](#app-by-app-categories), as there are some that require additional setup, and even categories that don't have files in this repo.

## App-by-app categories
In this section I will go over each app, and list where I drew my inspirations from, the tools I used to create any parts, and maybe some additional setup requirements.
### BetterDiscord
[Installation](https://betterdiscord.app/)  
The theme I created was made with [bdeditor](https://bdeditor.dev/). I used the [discord recolor](https://bdeditor.dev/theme/discordrecolor) theme by DevilBro as my base.

I wrote a simple startup script for bash, to use it just make a symbolic link like this:
```bash
ln -s ~/.config/BetterDiscord/betterdiscord ~/.local/bin/betterdiscord
```
Now you can launch discord by executing `betterdiscord` in the terminal.

The script will:
- try to update betterdiscord
- launch discord
- wait for discord to update (this can be skipped by executing `betterdiscord no-update` or by pressing enter when the script is waiting)
- reinstall betterdiscord
- relaunch discord
- close the terminal in which the script was running

### Firefox
This part has no files in this repository, but i did create a theme for [firefox color](https://addons.mozilla.org/en-US/firefox/addon/firefox-color/). You can find it [here](https://color.firefox.com/?theme=XQAAAAKCBAAAAAAAAABBqYhm849SCicxcUhA3DJozHnOMuotJJHsei94VjnaKzYAmRnTKRdrN8Xt1Z94zxuyBJi2-pXmGsL3Puqw7t2TbhVJGEHomTgwfjkihoH6ur7c3GSIpxBl47_UbiH27J0Sl5EbbIPOLxqhsldz6VMRkLzFAQFM97o4HX0s2_wkpq2D3HMVagsiT8dFS6cltWk89iITePANf60AJUAdfGT-e4ACbXR4_RXRszwcmoHtf43Jk_9Saigkin3wdlMoclJMRkh9Pi8X9ZDIghKDYaaR0HLpAWVpjHhceS1S9lz5LS_Tmv4KE9Zu12rRY8pl2A63rFpdkvX4INB1dB6-Q8obiyM28CA0jS3-kjpZEB5YzPGgqh4nkjYGQqO_x-oWM0QqxNMOEHrxJUP_t26sd-dBySHP_hS8kmOZgldE3FDyiokJHhcqImbaYcQP2hZh6xSHqyjj5nCX6k4G9L7d4-fKKfi7XZvYyRqDc6wSBjNG6dfoF3Q1zzuwas8Z6ZeTj5otV1K1Ut0xMDWMYdoIQpIaDYhGs7KeiuaL2RU5Jg2c__cz-1k).

### GTK
This part is split into two, because creating a gtk4 theme is a pain in the ass.
#### GTK3
To create my gtk3 theme, i used [themix](https://github.com/themix-project/themix-gui).  
After you downloaded this theme, you need to create a symbolic link as follows:
```bash
ln -s ~/.config/gtk3-theme ~/.themes/tobitdsm-rice
```
If you are not interested in keeping the files updated, you can just put the contents of the `gtk3-theme` folder directly into `~/.themes/tobitdsm-rice`. After that, you can apply the theme.  
Make sure you also have the gtk-3.0 folder installed for this to work!
#### GTK4
As I said, creating a gtk4 theme is a pain in the ass. That's why I use [Catppuccin](https://github.com/catppuccin/gtk) Mocha (Maroon) as my gtk4 theme, along with the the [papirus-folders](https://github.com/catppuccin/papirus-folders) icon pack.  
Make sure you also have the gtk-4.0 folder installed for this to work!

### GRUB
Because I didn't want to look into how you create a GRUB theme, I just installed the [catppuccin](https://github.com/catppuccin/grub) theme for grub.

### Hypr
As mentioned before, I use [Hyprland](https://hypr.land/) as my wm/de. Alongside it, I use many [hypr-ecosystem](https://wiki.hypr.land/Hypr-Ecosystem/) apps. I will shortly go over them.
#### Hyprland
[Installation](https://wiki.hypr.land/Getting-Started/Installation/)  
Within `hyprland.conf`, a lot of the other apps are started. Make sure to comment out the ones you don't want to use to prevent errors.
#### Hyprpaper
[Installation](https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/)  
To prevent copyright issues, my wallpaper is not in this repository. It is the album cover of [Sleep Token's](https://en.wikipedia.org/wiki/Sleep_Token) latest album, [Even In Arcadia](https://sleeptoken.lnk.to/EvenInArcadia). If you don't know them, please check them out.  
Apart from their music being a big inspiration for me, this album cover was the main inspiration for this rice, as it was already my wallpaper when I started making it.

Worship.
#### Hypridle
[Installation](https://wiki.hypr.land/Hypr-Ecosystem/hypridle/)  
There is not much to say here. You can tweak the timeouts if you don't like them.

If you don't have a keyboard backlight, you can remove this section to improve performance and prevent errors.
```hyprlang
# turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
listener { 
    timeout = 30                                                # 30sec
    on-timeout = brightnessctl -sd asus::kbd_backlight set 0    # turn off keyboard backlight.
    on-resume = brightnessctl -rd asus::kbd_backlight           # turn on keyboard backlight.
}
```
See the [wiki](https://wiki.archlinux.org/title/Keyboard_backlight) on how to get the identifier for your keyboard backlight.

Hypridle requires Hyprlock (or at least in my setup), so I do recommend installing them both.
#### Hyprlock
[Installation](https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/)  
Again not much to say here, aside from the fact that it expects a profile picture at `~/Pictures/me.jpg`.

### Ironbar
[Installation](https://github.com/JakeStanger/ironbar)  
Extra dependencies:
- [pipewire](https://www.pipewire.org/) or [pulseaudio](https://wiki.archlinux.org/title/PulseAudio)
- [cava](https://github.com/karlstav/cava)
- [playerctl](https://github.com/altdesktop/playerctl)
- [NetworkManager](https://www.networkmanager.dev/)
- [upower](https://gitlab.freedesktop.org/upower/upower)

My configuration was heavily inspired by the [wayfire rice](https://github.com/bluebyt/Wayfire-dots) by bluebyt.

I start ironbar at startup through Hyprland (see `hypr/hyprland.conf`). Note the reload 5 seconds after launching, this is to fix a weird startup issue where the cava element would be frozen.

On a side note: one of the elements on the bar displays the number of days I have been using arch. You can edit `ironbar/scripts/arch` to show your own day count, or remove the `$arch` element from `ironbar/config.corn` altogether.

### kitty
[Installation](https://github.com/kovidgoyal/kitty)  
Because this is the default terminal emulator shipped with Hyprland, and because it is very customizable, I just stuck with it.  
Because this configuration is mainly colors, the biggest inspiration was again the [retro-futuristic rice](https://github.com/diinki/diinki-retrofuture) by diinki.

### Neofetch
[Installation](https://github.com/dylanaraps/neofetch)  
Again, not much to say here. Just note that the config uses a custom ascii logo stored in logo.asc, which I made a scaled-up version of the default arch linux logo. You can edit this if you want.

### Quickshell
[Installation](https://quickshell.outfoxxed.me/)  
Extra dependencies:
- [cava](https://github.com/karlstav/cava)
- [playerctl](https://github.com/altdesktop/playerctl)

This configuration is based on [caelestia](https://github.com/caelestia-dots/shell) by soramane.

I start quickshell at startup through Hyprland (see `hypr/hyprland.conf`). Note the delay of 5 seconds after launching, this is to fix a weird startup issue where cava would not work.

The launch script is written for [fish](https://fishshell.com/) instead of bash, so you will probably need to install it.

Side note: I configured it in a way so quickshell only displays on my main monitor. If you want it on all monitors you have to edit this section of `quickshell/modules/drawers/Drawers.qml`:
```qml
model: [Quickshell.screens[0]] // show only on main monitor
    // if you want to display on all monitors use this instead:
    // model: Quickshell.screens
```

### Spicetify
[Installation](https://spicetify.app/)  
Again, not much to say here, this should work out of the box.

Side note: I disabled the "now playing" sidepane-view because I don't like it. If you want to re-enable it, just remove this part:
```css
.XOawmCGZcQx4cesyNfVO {
	display: none !important;
}
```

### VS Code
To get access to this theme inside of vscode, you should create a symbolic link like this:
```bash
ln -s ~/.config/vscode-theme ~/.vscode/extensions/tobitdsm-rice
```
You can then enable the theme by going into your vscode settings and searching for `tobitdsm rice theme` among the dark themes.

This theme was created using [Theme Studio for VS Code](https://themes.vscode.one/), with some edits made inside vscode itself afterwards, because some identifiers seemed to be a little bit outdated.

### Wofi
[Installation](https://github.com/SimplyCEO/wofi)  
This configuration was again inspired by the [retro-futuristic rice](https://github.com/diinki/diinki-retrofuture) by diinki.

## Outro
Thank you for taking the time to read the guide. As I mentioned before, if you have any issues that you believe I can fix, don't hesitate to create an issue or pull request.

### Inspirations
- [retro-futuristic rice](https://github.com/diinki/diinki-retrofuture) by diinki
- [catppuccin](https://github.com/catppuccin)
- [caelestia](https://github.com/caelestia-dots/) by soramane
- [wayfire rice](https://github.com/bluebyt/Wayfire-dots) by bluebyt
