CWD=$(pwd)

rm ~/.profile
rm ~/.vimrc

ln -s $CWD"/.profile" ~/.profile
ln -s $CWD"/.vimrc" ~/.vimrc
