# FreeBSD Jail
## setup zfs
```tcsh
zfs create zroot/jailname
```
## Install Base
```tcsh
bsdinstall jail /zroot/jails/jailname
```
## Snapshot Base
Replace `date` with a date:
```tcsh
zfs snapshot zroot/files@date
```
## Enable Jail
```tcsh
sysrc jail_enable="YES"
```
## Setup Jail.conf
Create `/etc/jail.conf` with following contents:
```tcsh
$jail_path="/zroot/jails";
path="$jail_path/$name";

# 2. begin - default configuration for all jails

# Some applications might need access to devfs
mount.devfs;

# Clear environment variables
exec.clean;

# Use the host's network stack for all jails
ip4=inherit; # or new/disable
ip6=inherit; # or new/disable
#allow.raw_sockets;
#allow.mount.tmpfs;

# Initialisation scripts
exec.start="/bin/sh /etc/rc";
exec.stop="/bin/sh /etc/rc.shutdown";

# specific jail configuration
jailname {
        host.hostname="$name";
        exec.consolelog = "/var/log/jail-${name}.log";
        persist;
}
```
## Start Service
```tcsh
service jail start
```
