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
add path 'da*' mode 0660 group operator
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
And:
```tcsh
sudo sysrc autofs_enable="YES"
service automount start
service automountd start
service autounmountd start
service devd start
```
