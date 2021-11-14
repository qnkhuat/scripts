cd ~/fun/scripts
mkdir -p ./_config
cp -r ~/.config/nvim ./_config/nvim
cp -r ~/.config/coc ./_config/coc
cp ~/.zshrc ~/.tmux.conf ~/.vimrc ~/.config/nvim/init.vim ~/.config/nvim/coc-settings.json ~/.spacemacs ~/.clojure/deps.edn ~/.emacs .
git add .
git commit -m "auto backup: $1"
git push origin master -f
