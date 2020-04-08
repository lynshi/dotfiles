CWD=$(pwd)

rm ~/.profile
rm ~/.vimrc

cp $CWD"/.profile" ~/.profile
ln -s $CWD"/.vimrc" ~/.vimrc

sudo apt-get update
sudo apt-get upgrade -y
