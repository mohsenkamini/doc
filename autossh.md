# AutoSSH
## Server
### One line setup
```bash
mkdir -p /home/user/.ssh; useradd user -m -d /home/user -s /bin/true; chown -R user:user /home/user; cd /home/user; echo 'client-key' > /home/user/.ssh/authorized_keys; chown user:user /home/user/.ssh/authorized_keys
```
### Create user folder with ssh
```bash
mkdir -p /home/user/.ssh
```
### Add user
```bash
useradd user -m -d /home/user -s /bin/true
```
### Add your key to authorized keys
```bash
echo 'client-key' > /home/user/.ssh/authorized_keys
```
### Change directory ownership
```bash
chown -R user:user /home/user
```
## Client (Linux)
### Create Systemd service
Add to `/etc/systemd/system/autossh-tunnel.service`:
```bash
[Unit]
Description=AutoSSH tunnel service to server on local port 22
After=network.target

[Service]
Environment="AUTOSSH_GATETIME=0"
User=spmzt
Group=spmzt
ExecStart=/usr/bin/autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -NR x:localhost:22 user@spmzt.net -p 22

[Install]
WantedBy=multi-user.target
```
## Client (FreeBSD)
### Create RC Script
```tcsh
#!/bin/sh
#
# PROVIDE: autossh_tunnel
# REQUIRE: sshd
# KEYWORD: shutdown

. /etc/rc.subr

name=autossh_tunnel
desc="AutoSSH tunnel service to server on port 22"
rcvar=autossh_tunnel_enable

command="/usr/local/bin/sudo"
command_args='-u user /usr/local/bin/autossh -f -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -NR x:localhost:22 user@spmzt.net -p 22'

load_rc_config $name

#
# DO NOT CHANGE THESE DEFAULT VALUES HERE
# SET THEM IN THE /etc/rc.conf FILE
#
autossh_tunnel_enable=${autossh_tunnel_enable-"NO"}
pidfile=${autossh_tunnel_pidfile-"/var/run/autossh_tunnel.pid"}

run_rc_command "$1"
```
