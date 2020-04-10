CWD=$(pwd)

cat .bashrc >> ~/.bashrc

rm ~/.vimrc
ln -s $CWD"/.vimrc" ~/.vimrc

sudo apt-get update
sudo apt-get upgrade -y
