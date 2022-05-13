# Run master
cd master
vagrant up

# Run node1
cd ../node1
vagrant up

# Wait until all nodes are up&running!

# Generate join command
cd master && vagrant ssh -c "microk8s add-node | grep -i 192.168.68.7 > /vagrant/shared-folder/join-to-cluster.sh"
cp shared-folder/join-to-cluster.sh ../node1/shared-folder/join-to-cluster.sh

# Join node1 to cluster
cd ../node1 && vagrant ssh -c "/vagrant/shared-folder/join-to-cluster.sh"

# Wait node to finish joining

# Hello world
vagrant ssh -c "k run nginx-hello --image=nginx && \
                k expose pod nginx-hello --port=8080 --type=NodePort"