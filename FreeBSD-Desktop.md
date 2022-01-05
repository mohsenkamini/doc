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
echo 'linux_load="YES"' >> /boot/loader.conf
echo 'nvidia_load="YES"' >> /boot/loader.conf
echo 'nvidia-modset_load="YES"' >> /boot/loader.conf
echo 'kld_list="nvidia"' >> /boot/rc.conf
```
### Install Linux Emulator
```tcsh
pkg install -y linux_base-c7 linux-c7
sysrc linux_enable="YES"
```
