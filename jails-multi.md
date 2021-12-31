# FreeBSD Jails
## Host Preparation
### download kernel source
#### Git
```tcsh
pkg install -y git
git clone -o freebsd https://git.FreeBSD.org/src.git /usr/src
```
or update
```tcsh
cd /usr/src
git pull --rebase
```
#### SVN
```tcsh
pkg install -y subversion
svn checkout https://svn.FreeBSD.org/base/head /usr/src
```
or update
```tcsh
svn update /usr/src
```
### Create Jails Directory
```tcsh
mkdir -p /home/jails/mroot
```
### Build and Install World
```tcsh
cd /usr/src
make -j4 buildworld
make installworld DESTDIR=/home/jails/mroot
```
### Download Ports
fetch `/usr/ports`:
```tcsh
portsnap fetch extract
```
or update
```tcsh
portsnap update
```
## Jail Base Setup 
### Setup Jails Directory
```tcsh
pkg install -y cpdup
cpdup /usr/src /home/jails/mroot/usr/src
portsnap -p /home/jails/mroot/usr/ports fetch extract
```
### Create Jail Skeleton
```tcsh
mkdir /home/jails/skel /home/jails/skel/home /home/jails/skel/usr-X11R6 /home/jails/skel/distfiles
mv /home/jails/mroot/etc /home/jails/skel
mv /home/jails/mroot/usr/local /home/jails/skel/usr-local
mv /home/jails/mroot/tmp /home/jails/skel
mv /home/jails/mroot/var /home/jails/skel
mv /home/jails/mroot/root /home/jails/skel
```
### Create Jail Configs
```tcsh
mergemaster -t /home/jails/skel/var/tmp/temproot -D /home/jails/skel -i
cd /home/jails/skel
rm -R bin boot lib libexec mnt proc rescue sbin sys usr dev
```
