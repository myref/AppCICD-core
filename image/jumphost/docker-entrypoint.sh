#!/bin/sh

if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
	# generate fresh rsa key
	ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi
if [ ! -f "/etc/ssh/ssh_host_dsa_key" ]; then
	# generate fresh dsa key
	ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

#prepare run dir
if [ ! -d "/var/run/sshd" ]; then
  mkdir -p /var/run/sshd
fi

if [ ! -d "/home/developer/.ssh" ]; then
  mkdir -p /home/developer/.ssh
fi

cd /home/developer
if $(curl --output /dev/null --silent --head --insecure --fail https://developer.tooling.provider.test:8084/whoAmI); then
  wget --no-check-certificate https://developer.tooling.provider.test:8084/jnlpJars/agent.jar
  echo "NetCICD Toolbox installed. Retrieved agent.jar from NetCICD-Developer-Toolbox."  >>/home/developer/install-log.txt
  agent=1
  chown developer:developer agent.jar
  echo $J_SECRET > secret-file
  chown developer:developer secret-file
  sudo -H -u developer java -jar agent.jar -jnlpUrl https://developer.tooling.provider.test:8084/computer/developer_agent/developer-agent.jnlp -secret @secret-file -workDir "/home/developer" -noCertificateCheck &
else
  echo "NetCICD Toolbox not installed. Skipping developer agent start." >>/home/developer/install-log.txt
fi

if wget -q --no-check-certificate --method=HEAD https://gitea.tooling.provider.test:3000/infraautomator/ ; then
  echo "Setting git to Gitea." >>/home/developer/install-log.txt
  export GIT_URL=https://gitea.tooling.provider.test:3000/infraautomator/
else
  echo "Setting git to Github." >>/home/developer/install-log.txt
  export GIT_URL=https://github.com/Devoteam/
fi

ansible-galaxy collection install cisco.ios -p /home/developer/.ansible/collections/ >>/home/developer/install-log.txt
ansible-galaxy collection install cisco.iosxr -p /home/developer/.ansible/collections/ >>/home/developer/install-log.txt
ansible-galaxy collection install cisco.nxos -p /home/developer/.ansible/collections/ >>/home/developer/install-log.txt
ansible-galaxy collection install ansible-posix -p /home/developer/.ansible/collections/ >>/home/developer/install-log.txt
ansible-galaxy collection install netapp-ontap -p /home/developer/.ansible/collections/ >>/home/developer/install-log.txt
ansible-galaxy collection install infoblox.nios_modules -p /home/developer/.ansible/collections/ >>/home/developer/install-log.txt

ssh-keygen -t rsa -N "" -f /home/developer/.ssh/id_rsa -C netcicd-pipeline@infraautomator.provider.test

if wget -q --no-check-certificate --method=HEAD https://gitea.tooling.provider.test:3000/infraautomator/; then
  echo "Setting git to Gitea." >>/home/developer/install-log.txt
  export GIT_URL=https://gitea.tooling.provider.test:3000/infraautomator/
else
  echo "Setting git to Github." >>/home/developer/install-log.txt
  export GIT_URL=https://github.com/Devoteam/
fi

chown -R developer:developer /home/developer

if grep -q prepared NetCICD_state; then
    echo "Lab already prepared"
else
    git config --global user.name "netcicd-pipeline"
    git config --global user.email "netcicd-pipeline@infraautomator.example.net"
    git -c http.sslVerify=false clone ${GIT_URL}NetCICD.git
    cd NetCICD
    git status
    echo '====================== Preparing CML lab ======================'
    cd roles/box/vars
    ln -s stage-box.yml main.yml
    cd ~/NetCICD
    ansible-playbook -i vars/stage-box prepare.yml -e stage="box"
    echo "prepared" > ../NetCICD_state
fi
exec "$@"
