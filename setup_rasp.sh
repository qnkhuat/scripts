# conda
wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-armv7l.sh
md5sum Miniconda3-latest-Linux-armv7l.sh
bash Miniconda3-latest-Linux-armv7l.sh

conda config --add channels rpi
conda install python=3.6conda 


#zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
