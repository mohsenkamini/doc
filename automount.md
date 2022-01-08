# FreeBSD Automount
## Setup Mount
```tcsh
sudo pkg install -y fusefs-exfat fusefs-ext2 fusefs-ntfs exfat-utils
echo 'vfs.usermount=1' | sudo tee -a /etc/sysctl.conf
sudo sysctl vfs.usermount=1
sudo sysrc devfs_system_ruleset="localrules"
```
Add these content to `/etc/devfs.conf`:
```tcsh
[localrules=5]
add path 'da[1-3]p*' mode 0660 group operator
```
Done:
```tcsh
mount -t msdosfs -o -m=644,-M=755 /dev/da1p1 /media
```
## Automount
USB devices can be automatically mounted by uncommenting this line in `/etc/auto_master`:
```tcsh
/media		-media		-nosuid
```
Edit `/etc/devd.conf
```tcsh
notify 100 {
	match "system" "GEOM";
	match "subsystem" "DEV";
	action "/usr/sbin/automount -c";
};
```
And:
```tcsh
sudo sysrc autofs_enable="YES"
service automount restart
service automountd restart
service autounmountd restart
service devd restart
```

### More to read
[ntfs](https://kflu.github.io/2018/02/03/2018-02-03-freebsd-ntfs/)

## Or use DSB
```tcsh
sudo pkg install -y dsbmc dsbmc-cli
sudo sysrc dsbmd_enable=YES
sudo service dsbmd start
```
Mount:
```tcsh
dsbmc-cli -m /dev/da0s1
```
