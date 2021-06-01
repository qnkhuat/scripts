cd ~/fun/scripts
cp ~/.zshrc ~/.tmux.conf ~/.vimrc ~/.config/nvim/init.vim .
git add .
git commit -m "auto backup: $1"
git push origin master -f
