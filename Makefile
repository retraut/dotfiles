DOTFILES := ${HOME}/.dotfiles/files
FILES    := .aliasesrc .vimrc .zshrc .ssh .vim .oh-my-zsh .screenrc .gitconfig

server:: basic
chromebook:: basic
basic:: core configure update-submodules


update-submodules::
	@git submodule init
	@git submodule update

core::
	@sudo apt-get update
	@sudo apt-get install -y zsh vim git curl wget
	@echo Core libraries are installed.

configure::
	@$(foreach i,$(FILES),ln -s $(DOTFILES)/$i ${HOME}/$i;)
	@echo All dotfiles symlinked

clean::
	@$(foreach i,$(FILES),rm -f ${HOME}/$i;)

