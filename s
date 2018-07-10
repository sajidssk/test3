---
- hosts: test-servers
  remote_user: root
  become: yes
  becom_method: sudo
  vars:
   download_url: http:\\
   download_folder: /etc/ansible
   java_name: "{{download_folder}}/jdk.9"
   java_archive: "{{download_folder}}/jdk.9.tar.gz"
   
  tasks:
  - name: download java
    command: "wget -q -O {{java_archive}} --no-check-certificate --no-cookies --header 'Cookie: oraclelicense=accept-securebackup-cookies' {{download_url}} creates={{java_archive}}"
  - name: unpack archive
    command: "tar -zxf {{java_archive}} -C {{download_folder}} creates={{java_name}}"
  - name: fix ownership
    file: state=directory path={{java_name}} owner=root group=root recurse=yes
  - name: make java available for system
    command: ' alternatives --install "/usr/bin/java" "java" "{{java_name}}/bin/java" 2000'
  - name: clean up
    file: state: absent path={{java_archive}}

