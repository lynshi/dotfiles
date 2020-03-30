CWD=$(pwd)

rm ~/.profile
rm ~/.vimrc

cp $CWD"/.profile" ~/.profile
ln -s $CWD"/.vimrc" ~/.vimrc

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install python3-pip
pip3 install virtualenvwrapper

source ~/.profile
