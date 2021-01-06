cd ~/fun/scripts
cp -u ~/.zshrc ~/.tmux.conf ~/.vimrc .
git add .
git commit -m "auto backup"
git push origin master -f
