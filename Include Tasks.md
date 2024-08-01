To create a playbook that uses the `include` feature to include the other task playbooks and allows you to reuse code for installing resources, follow these step-by-step lab instructions:

**Step 1: Organize Your Playbooks**

Organize your playbooks and task files into a directory structure like this:

```
my_playbook/
|-- webservers.yml (Your main playbook)
|-- roles/
|   |-- common/
|       |-- tasks/
|           |-- Install_Java_i.yml
|           |-- Install_Jenkins_i.yml
|           |-- Install_Webservers_i.yml
```

**Step 2: Create the Main Playbook (webservers.yml)**

Create the main playbook (webservers.yml) with the following content:

```yaml
---
- hosts: webservers
  become: yes
  tasks:
    - name: Include InstallJava tasks
      import_tasks: roles/common/tasks/Install_Java_i.yml

    - name: Include webservers tasks
      import_tasks: roles/common/tasks/Install_Webservers_i.yml

  handlers:
    - name: Restart and enable apache2
      service:
        name: apache2
        state: restarted
        enabled: yes
      listen: apache2 service

- hosts: localhost  # This is the control node
  gather_facts: no  # You may skip gathering facts for the control node
  tasks:
    - name: Install Jenkins
      include_tasks: Install_Jenkins_i.yml
```

**Step 3: Create Task Playbooks (Install_Java_i.yml, Install_Jenkins_i.yml, Install_Webservers_i.yml)**

Create separate task playbooks for each resource you want to install.

**Install_Java_i.yml:**

```yaml
---
- name: Task - 1 Update APT package manager repositories cache
  become: true
  apt:
    update_cache: yes

- name: Task -2 Install Java using Ansible
  become: yes
  apt:
    name: "{{ packages }}"
    state: present
  vars:
    packages:
        - openjdk-11-jdk
```

**Install_Jenkins_i.yml:**

```yaml
---
- name: Add Jenkins apt repository key
  apt_key:
    url: https://pkg.jenkins.io/debian-stable/jenkins.io.key  # Use the correct URL
    state: present

- name: Add Jenkins apt repository
  apt_repository:
    repo: "deb https://pkg.jenkins.io/debian-stable binary/"
    state: present

- name: Update apt cache
  apt:
    update_cache: yes

- name: Install Java Runtime Environment
  apt:
    name: openjdk-11-jre
    state: present

- name: Install Jenkins package
  apt:
    name: jenkins
    state: present

- name: Install additional packages
  apt:
    name: fontconfig
    state: present

- name: Start Jenkins service
  service:
    name: jenkins
    state: started
    enabled: yes

```

**Install_Webservers_i.yml:**

```yaml
---
- name: install apache2
  apt:
    name: apache2
    state: latest
  notify: apache2 service
  tags:
    - base-install

- name: Remove file
  file:
    path: /va/var/www/html/index.html
    state: absent

- name: Creating a file with content
  copy:
    dest: "/var/www/html/index.html"
    content: |
      <html>
      <body>
        <h1>Hello, World!</h1>
        <p>I'm a programmer now!<br/>
        Oh Snap! I'm doing the damn thing!</p>
      </body>
      </html>
```

**Step 4: Run the Main Playbook**

To run your main playbook, navigate to the directory containing "webservers.yml" and execute the following command:

```bash
ansible-playbook webservers.yml
```

This will execute the main playbook, which will include the task playbooks for installing Java, Jenkins, and Webservers. This approach allows you to reuse the code for resource installation in other playbooks easily.
