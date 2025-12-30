# -----------------------------------------------
# Download and Install python from source code
# -----------------------------------------------

# This script will download python source code and install using make altinstall
# Download this script as py3.sh and give execute permission
# chmod 777 ./py3.sh

# usage ./py3.sh <major_version> <minor_version> <tarxz_location>

# e.g if you want to install Python-3.11.8 from internet
# major_version = 11
# minor_version = 8
# keep tarxz_location blank
# usage: ./py3.sh 11 8

# e.g if you want to install Python-3.11.8 from local Python-3.11.8.tar.xz file
# major_version = 11
# minor_version = 8
# tarxz_location = /path/containing/Python-3.11.8.tar.xz
# supposing Python-3.11.8.tar.xz is in the Downloads folder then
# usage: ./py3.sh 11 8 /home/$USER/Downloads
# NOTE: don't provide the full path of tar file, only provide the folder that it is inside
#		will automatically look for file named "Python-3.11.8.tar.xz" 
#		file name should not be changed from what it is by default

# Will try to clean up extracterd files, do not not run under any directory where python is going to be installed
# prefer home directory or downloads directory
# best way is to cd into Downloads folder and use 
# usage: ./py3.sh 11 8 ./    # if you have the source code tar.xz
# usage: ./py3.sh 11 8    # if you want to download and install from source code tar.xz

if [[ "$1" == '' ]] ; then 
	echo "major version required!"
	exit 1
fi

if [[ "$2" == '' ]] ; then
	echo "minor version required!"
	exit 2
fi

pyver=3.$1.$2
echo "Installing Python-$pyver"


echo "Installing dependencies..."
sudo apt install wget build-essential libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev libffi-dev libnss3-dev

echo "Installing python..."
if [[ "$3" == '' ]] ; then
	pyurl=https://www.python.org/ftp/python/$pyver/Python-$pyver.tar.xz
	echo "Downloading Python from $pyurl"
	wget $pyurl -O ./Python-$pyver.tar.xz
	tar -xf ./Python-$pyver.tar.xz --directory=./
else
	echo "Using Local Source from $3"
	ls -lash $3/Python-$pyver.tar.xz
	tar -xf $3/Python-$pyver.tar.xz --directory=./
fi

cd Python-$pyver
pwd
echo "Configuring..."

./configure --enable-optimizations --enable-loadable-sqlite-extensions --with-ensurepip=install

echo "Installing..."

sudo make -j $(nproc)

sudo make altinstall

cd ..
pwd

pyv=3.$1

echo "Testing..."

#"/usr/local/bin/python$pyv" --version

python$pyv --version

python$pyv -m pip --version

python$pyv -m pip list

python$pyv -c "import _sqlite3"

echo "Finished!"

echo "Cleaning up... ./Python-$pyver"

sudo rm -r ./Python-$pyver

echo "Finished installing Python-$pyver"
whereis python$pyv
echo "Done! python command is python$pyv"
