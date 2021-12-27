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
# Docker Installation Ubuntu
```bash
sudo apt update && sudo apt install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io
```
## Test
```bash
sudo docker run hello-world
```
