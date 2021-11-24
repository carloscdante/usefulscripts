#!bin/bash

sudo apt-get update
sudo apt-get install -yqq daemonize dbus-user-session fontconfig

cd /usr/sbin

wget https://gist.githubusercontent.com/carloscdante/6d04bd280b70eaf888b2b9eead6926cb/raw/da0a90883ccb9d7e3d5fab0ac1d6ce2370f5672c/start-systemd-namespace
wget https://gist.githubusercontent.com/carloscdante/a21dded873e730d38acec3122a41abc7/raw/6a6c15770573f6fc5688b6941df015da2a09fe11/enter-systemd-namespace

sudo chmod +x start-systemd-namespace
sudo chmod +x enter-systemd-namespace

echo '
Defaults        env_keep += WSLPATH
Defaults        env_keep += WSLENV
Defaults        env_keep += WSL_INTEROP
Defaults        env_keep += WSL_DISTRO_NAME
Defaults        env_keep += PRE_NAMESPACE_PATH
sudo ALL=(ALL) NOPASSWD: /usr/sbin/enter-systemd-namespace' | sudo EDITOR='tee -a' visudo

sudo sed -i 2a"# Start or enter a PID namespace in WSL2\nsource /usr/sbin/start-systemd-namespace\n" /etc/bash.bashrc
