# rice dotfiles
## Introduction
This rice was made by me, with much inspiration from others. All of them are linked in their respective [categories](#app-by-app-categories) where I took their inspiration from.

At the same time this README acts as a guide to install this rice yourself, or parts of it. I made the rice in Hyprland on Arch Linux, all tools are also linked in their respective [categories](#app-by-app-categories).

If something doesn't work out of the box, it is probably because our setups differ slightly or you don't have certain tools installed. I am after all making this rice all by myself, and in the first place also only for myself.

If you do however think a problem may be fixed by changing my code, please do create an issue or a pull request.

## Color scheme
Just for reference, these are the main colors used in the rice.

<span style="color:#f59a9a">#f59a9a</span> (main accent color)  
<span style="background:#141216">#141216</span> (main background color)

extra accent colors:
<span style="color:#f66">#ff6666</span>  
<span style="color:#C76C6C">#c76c6c</span>  
<span style="color:#993d3d">#993d3d</span>  

extra background colors:  
<span style="background:#282432">#282432</span>  
<span style="background:#3c3642">#3c3642</span>  
<span style="background:#504858">#504858</span>  
<span style="background:#a090b0">#a090b0</span>

other colors:
<span style="background:#2b2135">#2b2135</span>  
<span style="color:#64ffff">#64ffff</span>  
<span style="color:#79fc64">#79fc64</span>  
<span style="color:#ffff66">#ffff66</span>  
<span style="color:#5bb0ff">#5bb0ff</span>  
<span style="color:#AC82E9">#ac82e9</span>  
<span style="color:#8F56E1">#8f56e1</span>  
<span style="color:#fc7fff">#fc7fff</span>  
<span style="color:#ffb266">#ffb266</span>

A lot of these colors come from the [retro-futuristic rice](https://github.com/diinki/diinki-retrofuture/tree/main) by diinky.

## Installation guide
### Full installation
If you want to install this rice, and keep updated with my edits, you can clone this repository as follows. This setup is from a guide from [atlassian](https://www.atlassian.com/git/tutorials/dotfiles)

1. Add the following alias to your `.bashrc` or `.zshrc` file:
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
Now you can update your files with
```bash
config pull
```
If anything fails, please refer to the [atlassian guide](https://www.atlassian.com/git/tutorials/dotfiles). Do note that you need to set your `--work-tree` to `$HOME/.config/` for this rice to work, as opposed to `$HOME` as shown in the guide.

You are now basically done, but please do read the [guides for each app](#app-by-app-categories) as there are some that require additional setup.
### Partial installation
If you wish to only install the rice for some of the apps, you can download the git repo as a zip or clone it, and move the corresponding folder(s) into `$HOME/.config/`.

Please do read the [guides for all relevant apps](#app-by-app-categories), as there are some that require additional setup.

## App-by-app categories
In this section I will go over each app, and list where I drew my inspirations from, the tools I used to create this specific part, and maybe some additional setup requirements.
### BetterDiscord
[Installation](https://betterdiscord.app/)  
The theme I created is based on a theme that apparently doesn't exist anymore, with some additional edits made with [bdeditor](https://bdeditor.dev/). I used the [discord recolor](https://bdeditor.dev/theme/discordrecolor) theme by DevilBro as my base.

On a side note, I changed the discord logo in the top left to be a gif that is very personal. If you want to customise it, just insert your url in this line:
https://github.com/tobitdsm/rice/blob/main/BetterDiscord/themes/tobitdsm-rice.theme.css#L32

### Firefox
[Installation](https://addons.mozilla.org/en-US/firefox/addon/firefox-color/)  
This part has no files in this repository, but i did create a theme for firefox. You can find it [here](https://color.firefox.com/?theme=XQAAAAKCBAAAAAAAAABBqYhm849SCicxcUhA3DJozHnOMuotJJHsei94VjnaKzYAmRnTKRdrN8Xt1Z94zxuyBJi2-pXmGsL3Puqw7t2TbhVJGEHomTgwfjkihoH6ur7c3GSIpxBl47_UbiH27J0Sl5EbbIPOLxqhsldz6VMRkLzFAQFM97o4HX0s2_wkpq2D3HMVagsiT8dFS6cltWk89iITePANf60AJUAdfGT-e4ACbXR4_RXRszwcmoHtf43Jk_9Saigkin3wdlMoclJMRkh9Pi8X9ZDIghKDYaaR0HLpAWVpjHhceS1S9lz5LS_Tmv4KE9Zu12rRY8pl2A63rFpdkvX4INB1dB6-Q8obiyM28CA0jS3-kjpZEB5YzPGgqh4nkjYGQqO_x-oWM0QqxNMOEHrxJUP_t26sd-dBySHP_hS8kmOZgldE3FDyiokJHhcqImbaYcQP2hZh6xSHqyjj5nCX6k4G9L7d4-fKKfi7XZvYyRqDc6wSBjNG6dfoF3Q1zzuwas8Z6ZeTj5otV1K1Ut0xMDWMYdoIQpIaDYhGs7KeiuaL2RU5Jg2c__cz-1k).

### GTK
This part is split into two, because creating a gtk4 theme is a pain in the ass.
#### GTK3
To create my gtk3 theme, i used [themix](https://github.com/themix-project/themix-gui).  
After you downloaded this theme, you need to create a symbolic link as follows:
```bash
ln -s ~/.config/gtk3-theme ~/.themes/tobitdsm-rice
```
If you are not interested in keeping the files updated, you can just put the contents of the `gtk3-theme` folder directly into `~/.themes/tobitdsm-rice`.  
After that, you can apply the theme.  
Just add the following lines to your `.bashrc` or `.zshrc`:
```bash
GTK_THEME="tobitdsm-rice"
```
#### GTK4
As I said, creating a gtk4 theme is a pain in the ass. That's why I use Catppuccin Mocha (Maroon) as my gtk4 theme. You can download it from their [github](https://github.com/catppuccin/gtk) and install it similarly as gtk3. Just add this line to your `.bashrc` or `.zshrc`:
```bash
IDK BRO FIX
```

### Hypr
As mentioned before, I use [Hyprland](https://hypr.land/) as my wm/de. Alongside it, I use many [hypr-ecosystem](https://wiki.hypr.land/Hypr-Ecosystem/) apps. I will shortly go over them.
#### Hyprland
[Installation](https://wiki.hypr.land/Getting-Started/Installation/)  
Within `hyprland.conf`, a lot of the other apps are started. Make sure to comment out the ones you don't want to use to prevent errors.
#### Hyprpaper
[Installation](https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/)  
To prevent copyright issues, my wallpaper is not in this repository. It is the album cover of [Sleep Token's](https://en.wikipedia.org/wiki/Sleep_Token) latest album, [Even In Arcadia](https://sleeptoken.lnk.to/EvenInArcadia). If you don't know them, please check them out.  
Apart from their music being a great inspiration for me, this album cover was the main inspiration for this rice, as it was already my wallpaper when I started making it.
#### Hypridle
[Installation](https://wiki.hypr.land/Hypr-Ecosystem/hypridle/)  
There is not much to say here. You can tweak the timeouts if you don't like them.

If you don't have a keyboard backlight, you can comment out this section to improve performance and prevent errors.
https://github.com/tobitdsm/rice/blob/main/hypr/hypridle.conf#L7-L12

Hypridle requires Hyprlock (or at least in my setup), so I do recommend installing them both.
#### Hyprlock
[Installation](https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/)  
Again not much to say here, aside from the fact that it expects a profile picture at `~/Pictures/me.jpg`.

### ironbar
[Installation](https://github.com/JakeStanger/ironbar)  
Extra dependencies:
- [pipewire](https://www.pipewire.org/) or [pulseaudio](https://wiki.archlinux.org/title/PulseAudio)
- [cava](https://github.com/karlstav/cava)
- [playerctl](https://github.com/altdesktop/playerctl)
- [NetworkManager](https://www.networkmanager.dev/)
- [upower](https://gitlab.freedesktop.org/upower/upower)

My configuration was heavily inspired by the [wayfire rice](https://github.com/bluebyt/Wayfire-dots) by bluebyt.

I start ironbar at startup through Hyprland (see `hypr/hyprland.conf`). Note the reload 5 seconds after launching, this is to fix a weird startup issue where the cava element would be frozen.

On a side note: one of the elements on the bar displays the number of days I have been using arch. You can edit the `ironbar/scripts/arch.sh` to show your own day count, or remove the `$arch` element from the `ironbar/config.corn` altogether.

### kitty
