cd ~/fun/scripts
cp ~/.zshrc ~/.tmux.conf ~/.vimrc ~/.config/nvim/init.vim ~/.config/nvim/coc-settings.json ~/.spacemacs ~/.clojure/deps.edn .
git add .
git commit -m "auto backup: $1"
git push origin master -f
