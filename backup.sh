cd ~/fun/scripts
git pull origin master
mkdir -p ./_config
cp -r ~/.config/nvim ./_config/nvim
cp -r ~/.config/coc ./_config/coc
cp -r ~/.doom.d ./_doom.d/
cp ~/.zshrc ~/.tmux.conf ~/.vimrc ~/.config/nvim/init.vim ~/.config/nvim/coc-settings.json ~/.spacemacs ~/.clojure/deps.edn ~/.emacs .
git add .
git commit -m "auto backup: $1"
git push origin master
