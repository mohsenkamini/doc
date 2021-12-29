# Socat
## Server Socat
```bash
socat -u FILE:file.txt OPENSSL-LISTEN:4444,cert=/etc/ssl/chain.pem,verify=0
```

## Client Socat
```bash
socat -u OPENSSL:spmzt.net:4444,verify=0 OPEN:file.txt,creat
```
