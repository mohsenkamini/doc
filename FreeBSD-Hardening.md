# FreeBSD Hardeninig
## Unused Users
Lock unused users and change their shell
```tcsh
pw lock toor
chsh -s /usr/sbin/nologin toor
```
## Permitted Account Escalation
### Sudo
```tcsh
pkg install -y sudo
pw usermod -G sudo,wheel user
```
## Account Management
### login.conf Tuning
`/etc/login.conf`
### Account Expire Time
```tcsh
pw usermod -p 30-apr-2015 -n trhodes
```
### Password Policy
Add your customized configuration to `/etc/pam.d/passwd`:
```tcsh
password	requisite	pam_passwdqc.so	min=disabled,24,12,10,8 max=128 passphrase=0 similar=deny match=4 retry=3 random=48	enforce=users
```
## Rootkit Detector
### rkhunter
```tcsh
pkg install -y rkhunter
rkhunter --propupd
echo '# 1000.rkhunter
daily_rkhunter_update_enable="YES"
daily_rkhunter_update_flags="--update --nocolors"
daily_rkhunter_check_enable="YES"
daily_rkhunter_check_flags="--checkall --nocolors --skip-keypress"' >> /etc/default/periodic.conf
```
## Binary Verification
change and save the seed:
```tcsh
mtree -s 3483151339707503 -c -K cksum,sha512digest -p /bin > /root/.bin_chksum_mtree
```
## Sysctl Tunning
### DoS
```tcsh
echo 'sysctl net.inet.tcp.blackhole=2
sysctl net.inet.udp.blackhole=1
sysctl net.inet.icmp.drop_redirect=1
sysctl net.inet.ip.redirect=0
sysctl net.inet.ip.sourceroute=0
sysctl net.inet.ip.accept_sourceroute=0
sysctl net.inet.icmp.bmcastecho=0' >> /etc/sysctl.conf
```
## TCP Wrapper
```tcsh
echo 'inetd_enable="YES"
inetd_flags="-Ww"' >> /etc/rc.conf
echo 'sshd : ALL : allow' >> /etc/hosts.allow
```
## Security Audit
```tcsh
echo 'daily_status_security_pkgaudit_enable="YES"' >> /etc/default/periodic.conf
pkg audit -F
```
