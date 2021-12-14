# Documentations
## AutoSSH
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
