DOTFILES := ${HOME}/.dotfiles/files
#FILES    := .aliasesrc .vimrc .zshrc .ssh .vim .oh-my-zsh .screenrc .gitconfig

CANDIDATES := $(wildcard .??*) bin
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
FILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))



server:: basic
chromebook:: basic
basic:: core configure update-submodules

help::
	@echo "make server           #=> Creates and configures dotfiles for general server"
	@echo "make help             #=> Displays this help"


update-submodules::
	@git submodule init
	@git submodule update

core::
	@sudo apt-get update
	@sudo apt-get install -y zsh vim git curl wget
	@echo Core libraries are installed.

configure::
	@$(foreach i,$(FILES),ln -s $(DOTFILES)/$i ${HOME}/$i;)
	@echo 'All dotfiles symlinked'

clean::
	@$(foreach i,$(FILES),rm -f ${HOME}/$i;)
	@echo 'Remove dot files in your home directory...'
