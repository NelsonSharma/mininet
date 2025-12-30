
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