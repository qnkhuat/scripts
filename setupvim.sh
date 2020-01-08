# Important : Type :PlugInstall for the first time use

# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# install monokai color
mkdir ~/.vim/colors 
curl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -o ~/.vim/colors/molokai.vim

git clone git://github.com/vhdirk/vim-cmake.git ~/.vim/bundle/vim-cmake

# install plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
# install ctags
git clone https://github.com/ludovicchabant/vim-gutentags.git ~/.vim/bundle/vim-gutentags

# setup vimrc
curl https://raw.githubusercontent.com/qnkhuat/scripts/master/.vimrc -o ~/.vimrc


# Setup Ag for search
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   # ubuntu 
   apt-get install silversearcher-ag ctags
elif [[ "$unamestr" == 'Darwin' ]]; then
   # macosx
   
   brew install the_silver_searcher ctags
fi
