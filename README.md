
# Setup Mininet

### clone repo

```shell
git clone https://github.com/NelsonSharma/mininet.git
```

```shell
cd mininet
```

### install python 3.8

```shell 
chmod +x py3.sh
./py3.sh 8 20
```

### make virtual env

```shell
python3.8 -m venv .venv
source .venv/bin/activate
```

### install mininet
```shell
python -m pip install -e .
```

### check `mn`
```shell
which mn
mn --version
```

### start `miniedit.py`
* might require `sudo apt install xbitmap`
```shell
examples/miniedit.py
```


### create topology

* create topologies
* save `topo.mn` files
* export as `topo.py` file
* run the exported script:
```shell
sudo su
apt install mininet
python3.8 -m pip install -e .
python3.8 topo.py

python3.8 .private/topo.py
```


# Setup OVS

```shell

sudo apt install openvswitch-common openvswitch-switch python3-openvswitch

sudo ovs-vsctl = vsctl

vsctl --version
vsctl show

# add a bridge <br0>
vsctl add-br <br-name>

# add a veth pair <ethx, ethy>
sudo ip link add <if-name> type veth peer name <if-name>

# connect veth end to bridge
sudo ovs-vsctl add-port <br-name> <if-name>

# assign ip to bridge (gateway)
sudo ip a add 192.168.0.1/24 dev <br-name>

# bring up bridge or if
ip l set <if-name> up
ip l set <br-name> up


# connect vm to bridge
> Virtual Network > Network-Source = Bridge device ...
> device name: <br-name>
>> XML
>> <model type="virtio"/>
>> <virtualport type="openvswitch"/>

 
# connect docker
docker run -it --name mybox --rm --network none busybox
sudo ovs-docker add-port <br-name> <if-name> mybox --ipaddress="..../24" --gateway="...1"

# patch switch
vsctl add-port <br-name1> P1
vsctl add-port <br-name2> P2
vsctl set Interface P1 type=patch option:peer=P2
vsctl set Interface P2 type=patch option:peer=P1


# see flows
sudo ovs-ofctl dump-flows <br-name>

```

