DOTFILES = ${HOME}/.dotfiles
FILES = .aliasesrc .vimrc .zshrc .ssh .vim .oh-my-zsh .screenrc

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
	@echo All dotfiles symlinked
    @$(foreach i,$(FILES),ln -s DOTFILES/$i ${HOME}/$i;)

clean::
	@$(foreach i,$(FILES),rm -f ${HOME}/$i;)

