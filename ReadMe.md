AWS Public AMI (N. California) to use for doing Ansible labs on Ubuntu
```
ami-0603cb4546aa25a8b
```
Install Ansible

```
sudo apt update && sudo apt upgrade
sudo apt install ansible
sudo apt upgrade ansible
```
clone the Ansible-Intro GitHub repo
```
git clone https://github.com/ProDataMan/Ansible-Intro.git
```
updte the inventory file to include your servers ip address

```
[control]
controlnode ansible_host=<add your ubuntu IP address>
[webservers]
node1 ansible_host=<add your ubuntu IP address>
node2 ansible_host=<add your ubuntu IP address>
```

Ping Nodes to add ssh key

```
ansible -m ping node1 -i inventory
ansible -m ping node2 -i inventory
ansible -m ping controlnode -i inventory
```
Run playbooks to install Java and Jenkins

```
ansible-playbook webservers.yml -i inventory
ansible-playbook InstallJava.yml -i inventory
ansible-playbook InstallJenkins.yml -i inventory
```

Use the following command to get the initial password of the new jenkins install

```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
