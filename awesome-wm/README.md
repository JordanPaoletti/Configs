# Awesome Window Manager
[The Awesome Window Manager for Linux](https://awesomewm.org/) 

## Installation with Ubuntu

```shell
# Installation with apt
sudo apt install awesome
```

* Launch ubuntu with awesome as the window manager
* restart to ensure proper functionality

## Configuration

Given GNOME uses wayland and awesome uses x11, already configured settings won't carry over by default.
The following are some tips for configuration.

* [Tap to click on touchpad](https://askubuntu.com/questions/1237804/how-to-enable-tap-to-click-touchpad-on-awesome-window-manager-between-logins)
  * [Xinput arch wiki](https://wiki.archlinux.org/title/Xinput)
  * Configured via `xinput`
  * devices can be found with `xinput list`, use the id to reference the device for ease of configuration
    * note that scripts should use the full device name as id isn't guarenteed at restart
  * props can be found with `xinput list-props <device>`
  * the following would configure a touch pad

```shell
id=11 # replace with touch pad device found in xinput list
xinput set-prop $id "libinput Tapping Enabled" 1
```
  
