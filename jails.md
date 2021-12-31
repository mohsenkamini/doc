# FreeBSD Jails
## Prepare
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
### download ports
fetch `/usr/ports`:
```tcsh
portsnap fetch extract
portsnap update
```
### Setup Jails Directory
```tcsh
pkg install -y cpdup
cpdup /usr/src /home/jails/mroot/usr/src
portsnap -p /home/jails/mroot/usr/ports fetch extract
```
