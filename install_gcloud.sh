wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64
sudo dpkg -i cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64
sudo apt-key add /var/cuda-repo-10-0-local/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda

# install cudnn 7.4

echo "go to https://developer.nvidia.com/rdp/cudnn-download Download the cudnn 7.4 for cuda9.0 then scp to the server"
echo "Install both the run time and dev"
echo "sudo dpkg -i all the downloaded files"


# install vim
wget https://raw.githubusercontent.com/qnkhuat/scripts/master/setupvim.sh
sudo chmod +x setupvim.sh
sudo ./setupvim.sh

# install python + pip
sudo apt-get install python3-pip python3-dev


# install anaconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh || bash
conda create --name dev python=3.7
conda activate dev
wget https://gist.githubusercontent.com/qnkhuat/3294b7b68966b2d5979ba138da056d62/raw/dbbb1e6d144f46a783981844d5340b96df055fdd/requirements.txt
pip install -r requirements.txt
