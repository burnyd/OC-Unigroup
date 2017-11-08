#!/usr/bin/env bash


sleep 5

sudo su

sudo useradd -m kafka

sudo adduser kafka sudo

#Check for ping connectivity to google before proceeding.

ping -q -c5 google.com > /dev/null
 
if [ $? -eq 0 ]
then
	echo "connectivity is there"
else    echo "connectivity is not there"
        exit 1 
fi 

echo "Add dns names to etc hosts"

echo 10.0.0.99 leaf1a  >> /etc/hosts
echo 10.0.0.100 leaf1b  >> /etc/hosts
echo 10.0.0.101 spine1  >> /etc/hosts
echo 10.0.0.102 spine2  >> /etc/hosts
echo 10.0.0.103 leaf2a  >> /etc/hosts
echo 10.0.0.103 leaf2b  >> /etc/hosts

echo "adding respositories"
echo "ansible for apt-get"
apt-add-repository ppa:ansible/ansible -y

echo "updating apt-get"
apt-get update -y 
echo "installing everything necessary for DNS and Bind"
apt-get install -y git ansible python-pip python-dev default-jre -y 

echo "Get the necessary libraries"
pip install jsonrpclib

echo "Getting the necessary Arista Networks Openconfig tools"
git clone github.com/aristanetworks/goarista.git /opt/
echo "Installing go and setting env variables for Go"
wget https://storage.googleapis.com/golang/go1.9.1.linux-amd64.tar.gz -P /opt/

sleep 3

su vagrant

sudo tar -C /usr/local -xzf /opt/go1.9.1.linux-amd64.tar.gz 

echo "Adding linux env varbiables through another process"
cd /vagrant/scripts
. ./env.sh


echo "Installing OC tools"
go get github.com/aristanetworks/goarista/cmd/gnmi

pip install pyangbind

git clone https://github.com/robshakir/pyangbind /tmp/pyangbind/

git clone https://github.com/openconfig/public/ /tmp/public/



mkdir -p /home/vagrant/kafka
cd /home/vagrant/

sudo apt-get install zookeeperd -y

wget http://www-us.apache.org/dist/kafka/0.10.2.0/kafka_2.10-0.10.2.0.tgz

sudo tar -xf kafka_2.10-0.10.2.0.tgz -C /home/vagrant/kafka/ --strip-components 1
sleep 5

echo "Running kafka and zookeeper in the background"
/home/vagrant/kafka/bin/kafka-server-start.sh /home/vagrant/kafka/config/server.properties > /dev/null 2>&1 &
