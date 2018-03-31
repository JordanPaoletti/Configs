PLUG_DIRS=-D WITH_PLUGINS
IJ_DIRS=

vimrc: 
	./create_vimrc

plugins:
	./create_vimrc $(PLUG_DIRS)

intellij:
	./create_vimrc $(IJ_DIRS)
	mv vimrc ideavimrc

.PHONY: vimrc plugins intellij

