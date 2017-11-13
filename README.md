# OC-Unigroup
![Alt text](background.jpg?raw=true "Unigroup-OC")

This is a demo of openconfig on Arista EOS devices.  In this repo there is a Vagrant file along with other documents to get a openconfig demo setup. 

Please first add a vagrant box file to match what is within the Vagranfile.

After vagrant up leaf1a leaf1b leaf2a leaf2b spine1 spine2 gobgp mgt1

vagrant ssh mgt1

source /vagrant/scripts/env.sh 

To subscribe to BGP events on leaf1a please run the following 

gnmi  -addr leaf1a:6030 -username vagrant -password vagrant subscribe /network-instances/network-instance[name=default]/protocols/protocol[identifier=BGP][name=BGP]/bgp/

While this is going on please run the ansible playbooks in /vagrant/scripts/ansible/leafspine/ to watch the changes on the streaming gnmi client. 
