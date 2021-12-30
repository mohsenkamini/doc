# FreeBSD Desktop
## Install xfce4
```tcsh
echo 'exec /usr/local/bin/startxfce4 --with-ck-launch' > ~/.xinitrc
pkg install -y xfce slim
```
## Theme
Nord Icon + Orchis Theme Recommended
```tcsh
sudo pkg install xfce4-wm xfce4-taskmanager xfce4-wm-themes xfce4-volumed-pulse xfce4-timer-plugin xfce4-taskmanager xfce4-systemload-plugin xfce4-pulseaudio-plugin xfce4-netload-plugin xfce4-desktop xfce4-docklike-plugin xfce4-dashboard xfce4-calculator-plugin xfce4-bsdcpufreq-plugin xfce-icons-elementary gtk-xfce-engine 
```
### Slim Theme
```tcsh
sudo pkg install -y slim-themes
```
