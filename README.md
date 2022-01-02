# My Documentations (Cheatsheet)
## AutoSSH
[AutoSSH Documentation](https://github.com/spmzt/doc/blob/main/autossh.md)
## FreeBSD Hardening
[FreeBSD Hardening Documentation](https://github.com/spmzt/doc/blob/main/FreeBSD-Hardening.md)
## Docker
[Docker Documentation](https://github.com/spmzt/doc/blob/main/docker.md)
## NFTables
[NFTables Documentation](https://github.com/spmzt/doc/blob/main/nftables.md)
## Offensive FreeBSD
[FreeBSD For Pentesters Documentations](https://github.com/spmzt/doc/blob/main/demon.md)
## OpenSSL EC Cryptography
[OpenSSL EC Cryptography](https://github.com/spmzt/doc/blob/main/ec.md)
## Socat
[Socat Documentations](https://github.com/spmzt/doc/blob/main/socat.md)
### FreeBSD
you can't remove as root?
```tcsh
chflags chflags -R noschg ./
```
Enable sysvipc?
```tcsh
jail -m jid=1 allow.sysvipc=1
echo 'sysvshm=new;' >> /etc/jail.conf
```
