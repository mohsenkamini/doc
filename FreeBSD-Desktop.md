# FreeBSD Desktop
## Install xfce4
```tcsh
echo 'exec /usr/local/bin/startxfce4 --with-ck-launch' > ~/.xinitrc
pkg install -y xfce slim
```
## Theme
Nord Icon + Orchis Theme Recommended
```tcsh
sudo pkg install -y gtk-xfce-engine 
```
