# Setup Bhyve
## Install Bhyve tools
```tcsh
sudo pkg install -y vm-bhyve grub2-bhyve bhyve-firmware
```
## Initialize Kernel
```tcsh
sysrc -f /boot/loader.conf vmm_load="YES"
echo 'net.link.tap.up_on_open=1' >> /etc/sysctl.conf
echo 'net.inet.ip.forwarding=1' >> /etc/sysctl.conf
```
## Create ZFS Dataset (optional
```tcsh
zfs create zroot/vm
```
## update /etc/rc.conf
```tcsh
sysrc vm_enable="YES"
sysrc vm_dir="zfs:zroot/vm"
```
