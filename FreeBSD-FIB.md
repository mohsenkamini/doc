# FreeBSD FIB
## Add FIB
```tcsh
sysctl net.fibs=2
setfib 1 route add default 172.16.1.1
```
## Persist FIB
```tcsh
echo 'net.fibs=2' >> /boot/loader.conf
```
## Jails
add in `jail.conf`:
```tcsh
exec.fib=1;
```
## interface
```tcsh
ifconfig lo1 fib 1
```
