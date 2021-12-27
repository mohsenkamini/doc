# Documentations
## AutoSSH
### Server
```bash
mkdir -p /home/user/.ssh; useradd user -m -d /home/user -s /bin/true; chown -R user:user /home/user; cd /home/user; echo 'client-key' > /home/user/.ssh/authorized_keys; chown user:user /home/user/.ssh/authorized_keys
```
### Client
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
