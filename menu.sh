#!/bin/bash

clear
echo "Menu:
1.create files and tgz them.
2.Export all your machines resources.
3.Get ip address and change SSh-keys,and change Host-name to him.
4.install"
echo "-----Enter 1 - 4 -----:"
read CHOOSE

if [ $CHOOSE == "1" ]
then
echo "Enter the directory name :"
read NAME
mkdir $NAME
cd $NAME
touch {1..10}.txt
cd ..
tar -czvf $NAME.tgz /home/guy/Desktop/$NAME

echo "----Enter the ip that you want to send to him the file ----:"
read IP
scp $NAME.tgz guy@$IP:/home/guy/Desktop/$NAME.tgz





elif [ $CHOOSE == "2" ]
then
touch details.txt

echo "-----Ip address :-----" > details.txt
ip -f inet a | awk '/inet / { print $2 }' >> details.txt

echo "-----Free memory :-----" >> details.txt
free | grep Mem | awk '{print $4/$2 * 100.0}' >> details.txt

echo "-----TCP listening ports :-----" >> details.txt
netstat -ltn | awk '/tcp /{ split($4, x, ":"); print(x[2]); }' | sort -n >> details.txt

echo "-----OS version :-----" >> details.txt
lsb_release -a >> details.txt

echo "-----Kernel version :-----" >> details.txt
uname -mrsn >> details.txt

echo "-----CPU version :-----" >> details.txt
cat /proc/cpuinfo | grep 'model name' | uniq >> details.txt

echo "-----Cores :-----" >> details.txt
grep -m 1 'cpu cores' /proc/cpuinfo >> details.txt

echo "-----Storage :-----" >> details.txt
lsblk | grep -v '^loop' >> details.txt

cat details.txt



elif [ $CHOOSE == "3" ]
then
echo"Create ssh-keygen.."
ssh-keygen
echo"-----Enter the server ip -----:"
read IP
ssh-copy-id guy@$IP
echo"now connect with ssh and change the host-name"
echo "Change host-name to slave,----Enter the name ----:"
read HOST
echo $HOST > host.txt
scp host.txt guy@$IP:/home/guy/Desktop/host.txt

sshpass -p 'rootroot' ssh root@$IP '\\
cat /home/guy/Desktop/host.txt > /etc/hostname'



elif [ $CHOOSE == "4" ]
then
echo"update the machine.."
sudo apt update
echo"upgrade the machine.."
sudo apt upgrade
echo"install apache2"
sudo apt install apache2
sudo ufw allow 'Apache'
echo"install curl"
sudo apt install curl
echo"install net-tools"
sudo apt-get install -y net-tools
echo"install Doker"
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce
echo"install Ansible"
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible
echo"install java"
sudo apt install default-jdk
sudo apt install openjdk-8-jdk
echo"install jenkins"
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt install jenkins
sudo systemctl start jenkins
echo"install python3.7 and making python3 default.."
sudo apt install python3.7
alias python==python3.7
echo"install iperf"
sudo apt-get update -y
sudo apt-get install -y iperf
wget www.ynet.co.il


fi

