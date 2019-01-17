# Important : Type :PlugInstall for the first time use

# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# install monokai color
mkdir ~/.vim/colors 
curl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim

# install plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

# setup vimrc
curl https://gist.githubusercontent.com/qnkhuat/8b299d6c3dd0ea64d8bf0fbaefc5c79b/raw/5134a2fbb404163ff3ae59bfd87e2725c2292397/.vimrc -o ~/.vimrc


# Setup Ag for search
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   # ubuntu 
   apt-get install silversearcher-ag
elif [[ "$unamestr" == 'Darwin' ]]; then
   # macosx
   
   brew install the_silver_searcher
fi
