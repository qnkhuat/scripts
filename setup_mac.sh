# download and install iterm2 first
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install tmux wget fzf gem cowsay

# install zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# zsh extensions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlightin

# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

# install googler command
sudo curl -o /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v4.3.1/googler && sudo chmod +x /usr/local/bin/googler

# setup tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
wget https://raw.githubusercontent.com/qnkhuat/scripts/master/.tmux.conf -O ~/.tmux.conf

# setup git config
git config --global user.email "qn.khuat@gmail.com"
git config --global user.name "Ngoc Khuat"
git config --global pull.rebase true
git config --global push.default simple
git config --global init.defaultBranch main
