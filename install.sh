#!/usr/bin/bash
which ansible-playbook &> /dev/null
if [ $? != 0 ]; then
	sudo dnf install ansible -y
fi
ansible-playbook -K playbook.yml
