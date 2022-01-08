# Ansible On FreeBSD
## Setup Ansible
```tcsh
sudo pkg install -y python38 py38-ansible
sudo mkdir /usr/local/etc/ansible
sudo cp /usr/local/share/examples/py38-ansible-core/hosts /usr/local/etc/ansible/
sudo cp /usr/local/share/examples/py38-ansible-core/ansible.cfg /usr/local/etc/ansible/
```
## Ansible Configuration
Change `ansible.cfg`:
```tcsh
[freebsd]
freebsd-1 ansible_ssh_host=192.168.1.1

[freebsd:vars]
ansible_python_interpreter=/usr/local/bin/python3.8
ansible_user=ansible
ansible_become=yes
ansible_become_method=sudo
ansible_connection=ssh
ansible_ssh_private_key_file=/usr/home/user/.ssh/id_rsa
```
