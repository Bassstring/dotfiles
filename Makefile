SHELL := /bin/zsh
DOTFILES_DIR := ~/.dotfiles

.PHONY: all help homebrew xcode misc npm nvim zsh git fonts macos uninstall

all: sudo homebrew xcode misc npm nvim bash git fonts macos

.DEFAULT_GOAL := help

help:
	@echo "######################################################################"
	@echo "# Processes might get killed by some routines!                       #"
	@echo "######################################################################"
	@echo "all      	-- install all configs"
	@echo "nvim     	-- nvim setup with plugins, snippets and runtimes"
	@echo "homebrew 	-- brew packages and casks of Brewfile"
	@echo "npm      	-- npm packages"
	@echo "nvim     	-- neovim stuff"
	@echo "zsh      	-- symlinks for zsh"
	@echo "git      	-- gitconfigs, ignore and completion"
	@echo "macos    	-- default writes"
	@echo "fonts    	-- fonts for terminal"
	@echo "uninstall	-- remove symlinks"

sudo:
	@echo -e "\033[1m\033[34m==> Installation with sudo required\033[0m"
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

homebrew:
	@echo -e "\033[1m\033[34m==> Installing brew if not already present\033[0m"
	which brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby
	@echo -e "\033[1m\033[34m==> Installing brew formulas\033[0m"
	brew bundle --file=$(DOTFILES_DIR)/Brewfile

npm:
	@echo -e "\033[1m\033[34m==> Installing npm packages\033[0m"
	npm i -g npm@latest
	npm i -g typescript
	npm i -g nodemon
	npm i -g eslint
	npm i -g neovim
	ln -sfv $(DOTFILES_DIR)/eslintrc ~/.eslintrc

nvim:
	@echo -e "\033[1m\033[34m==> Installing nvim dependencies\033[0m"
	nvim +"call mkdir(stdpath('config'), 'p')" +qall
	ln -sfv $(DOTFILES_DIR)/vim/init.vim ~/.config/nvim/
	ln -sfv $(DOTFILES_DIR)/vim/snips ~/.config/nvim/
	ln -sfv $(DOTFILES_DIR)/vim/pythonx  ~/.config/nvim/
	ln -sfv $(DOTFILES_DIR)/vim/spell  ~/.config/nvim/
	ln -sfv $(DOTFILES_DIR)/vim/colors  ~/.config/nvim/
	pip install setuptools
	pip install --upgrade pynvim
	pip2 install --upgrade pynvim
	gem install neovim
	pip install unidecode

zsh:
	@echo -e "\033[1m\033[34m==> Installing zsh and tools\033[0m"
	which antibody || curl -sL git.io/antibody | sh -s
	antibody bundle < $(DOTFILES_DIR)/antibody/bundles.txt > ~/.zsh_plugins.sh
	ln -sfv $(DOTFILES_DIR)/zsh/zshrc ~/.zshrc;
	ln -sfv $(DOTFILES_DIR)/zsh/zshenv ~/.zshenv;
	ln -sfv $(DOTFILES_DIR)/zsh/zprofile ~/.zprofile;
	sudo sh -c "echo $(which zsh) >> /etc/shells"
	bash $(DOTFILES_DIR)/autoloaded/switch_zsh
	source ~/.zshrc

git:
	@echo -e "\033[1m\033[34m==> Installing stuff for git\033[0m"
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
	ln -sfv $(DOTFILES_DIR)/git/gitconfig ~/.gitconfig
	ln -sfv $(DOTFILES_DIR)/git/gitignore ~/.gitignore

misc:
	@echo -e "\033[1m\033[34m==> Installing misc\033[0m"
	ln -sfv $(DOTFILES_DIR)/wgetrc ~/.wgetrc
	ln -sfv $(DOTFILES_DIR)/curlrc ~/.curlrc
	ln -sfv $(DOTFILES_DIR)/tmux/tmux.conf ~/.tmux.conf

fonts:
	@echo -e "\033[1m\033[34m==> Installing fonts\033[0m"
	git clone https://github.com/powerline/fonts.git --depth=1
	./fonts/install.sh
	rm -rf fonts

macos:
	@echo -e "\033[1m\033[34m==> Configure macos and applications\033[0m"
	mkdir -p $(HOME)/screens
	bash $(DOTFILES_DIR)/macos/main.sh
	sudo ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
	wget https://safari-extensions.apple.com/extensions/com.el1t.uBlock-3NU33NW2M3/uBlock0.safariextz
	open uBlock0.safariextz && rm -irf uBlock0.safariextz

xcode:
	@echo -e "\033[1m\033[34m==> Installing xcode cli tools\033[0m"
	xcode-select --install

uninstall:
	rm ~/.zshrc
	rm ~/.zshenv
	rm ~/.zprofile
	rm ~/.zsh_plugins.sh
	rm ~/.tmux.conf
	rm ~/.wgetrc
	rm ~/.curlrc
	rm ~/.gitignore
	rm ~/.gitconfig

test:
	@echo -e "\033[1m\033[34m==> Check if commands are available\033[0m"
	which brew && which git && which npm && which nvim && which zsh \
		&& which pip && which airport && which antibody || exit 1
