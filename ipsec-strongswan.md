# IPSec

## Basic Requirements

### Install

```bash
apt install -y strongswan strongswan-swanctl charon-systemd strongswan-pki libcharon-extra-plugins libstrongswan-extra-plugins
```

### Systemd

```bash
systemctl enable strongswan
systemctl restart strongswan
```

### Certificates

Setup PKI folder structure

```bash
mkdir -p ~/pki/{x509ca,x509,private}
chmod 700 ~/pki
```

Create CA Server Certificate

```bash
pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/ca-key.pem
pki --self --ca --lifetime 3650 --in ~/pki/private/ca-key.pem --type rsa --dn "CN=Company CA" --outform pem > ~/pki/x509ca/ca-cert.pem
```

Create Server Certificate

```bash
pki --gen --type rsa --size 4096 --outform pem > ~/pki/private/srv-key.pem
pki --pub --in ~/pki/private/server-key.pem --type rsa \
    | pki --issue --lifetime 1825 \
        --cacert ~/pki/cacerts/ca-cert.pem \
        --cakey ~/pki/private/ca-key.pem \
        --dn "CN=server_domain_or_IP" --san server_domain_or_IP  --san @IP_address \
        --flag serverAuth --flag ikeIntermediate --outform pem \
    >  ~/pki/x509/srv-cert.pem
```

Copy the certificates into the ipsec folder

```bash
sudo cp -r ~/pki/* /etc/swanctl
```

## IKEv2 Site to Site

### Right

#### Swanctl.conf

/etc/swanctl/conf.d/name.conf

```bash
connections {
        gilbert { # connection name
        version = 2 # IKE version
        proposals = aes192gcm16-aes128gcm16-prfsha256-ecp256-ecp521,aes192-sha256-modp3072,default
        local_addrs = 168.119.205.240 # Right IP
        remote_addrs = 82.102.9.12 # Left IP
        keyingtries = 0

        local-1 {
            certs = srv-cert.pem # server certificate
        }

        remote-1 {
            certs = gilbert.pem
        }

        children {
            site2 {
                mode = tunnel # or transparent
                local_ts = 172.31.1.10/32
                remote_ts = 172.31.1.20/32
                esp_proposals = aes192gcm16-aes128gcm16-prfsha256-ecp256-modp3072,aes192-sha256-ecp256-modp3072,default
                dpd_action = restart
                start_action = start # or trap
            }
        }
    }
}

secrets {
    private-gilbert { # sample name
        file = srv-key.pem
    }
}
```

### Left

### Swanctl

/etc/swanctl/conf.d/name.conf

```bash
connections {
        naomi {
        version = 2
        local_addrs = 82.102.9.12 # Left IP
        remote_addrs = 168.119.205.240 # Right IP
        keyingtries = 0
        local-1 {
            certs = srv-cert.pem
        }
        remote-1 {
            certs = naomi.pem
        }
        children {
            site1 {
                mode = tunnel # or transparent
                local_ts = 172.31.1.20/32
                remote_ts = 172.31.1.10/32
                esp_proposals = aes192gcm16-aes128gcm16-prfsha256-ecp256-modp3072,aes192-sha256-ecp256-modp3072,default
                dpd_action = restart
                start_action = start # or trap
            }
        }
    }
}

secrets {
        private-naomi {
                file = srv-key.pem
        }
}
```

## IKEv2 Remote

### Right

#### Swanctl.conf

/etc/swanctl/conf.d/name.conf

```bash
connections {
        remote {
        version = 2
        encap = yes
        rekey_time = 0
        send_cert = always
        send_certreq = no
        pools = range6
        local_addrs = right.spmzt.net
        local-1 {
                auth = pubkey
                certs = right-cert.pem
                id = right.spmzt.net
        }

        remote-1 {
                auth = eap-mschapv2
                eap_id = %any
        }
        children {
                remote {
                        mode = tunnel
                        local_ts = 0.0.0.0/0
                        esp_proposals = aes192gcm16-aes128gcm16-prfsha256-ecp256-modp3072,aes192-sha256-ecp256-modp3072,default
                        dpd_action = clear
                        start_action = start
                        esp_proposals = aes128-aes256-sha1-sha256-modp2048-modp4096-modp1024,aes128-sha1,aes128-sha1-modp1024,aes128-sha1-modp1536,aes128-sha1-modp2048,aes128-sha256,aes128-sha256-ecp256,aes128-sha256-modp1024,aes128-sha256-modp1536,aes128-sha256-modp2048,aes128gcm12-aes128gcm16-aes256gcm12-aes256gcm16-modp2048-modp4096-modp1024,aes128gcm16,aes128gcm16-ecp256,aes256-sha1,aes256-sha256,aes256-sha256-modp1024,aes256-sha256-modp1536,aes256-sha256-modp2048,aes256-sha256-modp4096,aes256-sha384,aes256-sha384-ecp384,aes256-sha384-modp1024,aes256-sha384-modp1536,aes256-sha384-modp2048,aes256-sha384-modp4096,aes256gcm16,aes256gcm16-ecp384,3des-sha1,default
                        }
                }
        proposals = aes128-sha1-modp1024,aes128-sha1-modp1536,aes128-sha1-modp2048,aes128-sha256-ecp256,aes128-sha256-modp1024,aes128-sha256-modp1536,aes128-sha256-modp2048,aes256-aes128-sha256-sha1-modp2048-modp4096-modp1024,aes256-sha1-modp1024,aes256-sha256-modp1024,aes256-sha256-modp1536,aes256-sha256-modp2048,aes256-sha256-modp4096,aes256-sha384-ecp384,aes256-sha384-modp1024,aes256-sha384-modp1536,aes256-sha384-modp2048,aes256-sha384-modp4096,aes256gcm16-aes256gcm12-aes128gcm16-aes128gcm12-sha256-sha1-modp2048-modp4096-modp1024,3des-sha1-modp1024,default
        }
}

pools {
        range6 {
                addrs = 172.16.0.0/24
                dns = 9.9.9.9,1.1.1.1
        }
}

secrets {
        private-remote {
                file = "right-key.pem"
        }
        eap-remote {
                id = leftuser
                secret = leftpassword
        }
}
```

### 
