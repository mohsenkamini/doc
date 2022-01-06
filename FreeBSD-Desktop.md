# FreeBSD Desktop
## Setup VTY
Add this line to the top of the `/boot/loader.conf`:
```tcsh
kern.vty=vt
```
## Install xfce4
```tcsh
echo 'exec /usr/local/bin/startxfce4 --with-ck-launch' > ~/.xinitrc
pkg install -y xfce slim
```
## Theme
Nord Icon + Orchis Theme Recommended
```tcsh
sudo pkg install xorg xfce4-wm xfce4-taskmanager xfce4-wm-themes xfce4-volumed-pulse xfce4-timer-plugin xfce4-taskmanager xfce4-systemload-plugin xfce4-pulseaudio-plugin xfce4-netload-plugin xfce4-desktop xfce4-docklike-plugin xfce4-dashboard xfce4-calculator-plugin xfce4-bsdcpufreq-plugin xfce-icons-elementary gtk-xfce-engine 
```
### Slim Theme
```tcsh
sudo pkg install -y slim-themes
```
### Install Tools
```tcsh
pkg install -y firefox vim
```
### Install Video Drivers
For Intel:
```tcsh
pkg install -y drm-kmod
```
For NVIDIA:
```tcsh
pkg install -y nvidia-driver
echo 'nvidia-modset_load="YES"' >> /boot/loader.conf
echo 'kld_list="nvidia"' >> /boot/rc.conf
```
Add to `/usr/local/etc/X11/xorg.conf.d/driver-nvidia.conf`:
```tcsh
Section "Device"
        Identifier "NVIDIA Card"
        VendorName "NVIDIA Corporation"
        Driver "nvidia"
EndSection
```
### Install Linux Emulator
```tcsh
kldload linux linux64
pkg install -y linux_base-c7 linux-c7
sysrc linux_enable="YES"
```
### Install ZSH
```tcsh
sudo pkg install -y zsh
chsh -s /usr/local/bin/zsh user
```
Add to `.zshrc`:
```tcsh
# End of lines added by compinstall
PROMPT='%F{129}[%f%F{7}%n@%m%f%F{129}] [%f%F{7}%~%f%F{129}] %%%f %F{7}'

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^U' backward-kill-line                   # ctrl + U
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# force zsh to show the complete history
alias history="history 0"
```
