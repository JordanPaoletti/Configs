PLUG_DIRS=-D WITH_PLUGINS
IJ_DIRS=

all: vimrc plugins idea

vimrc: 
	cat base.vim noplugins.vim >vimrc

plugins:
	cd plugins; make
	cat plugins/before.vim base.vim plugins/after.vim > vimrc_plugins

idea:
	cat base.vim noplugins.vim idea.vim >ideavimrc

clean:
	rm -f vimrc ideavimrc vimrc_plugins

.PHONY: vimrc plugins idea clean

