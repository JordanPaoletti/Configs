PLUG_DIRS=-D WITH_PLUGINS
IJ_DIRS=

vimrc: 
	cat base.vim noplugins.vim >vimrc

plugins:
	echo 'not supported' > pvimrc

intellij:
	cat base.vim noplugins.vim idea.vim >ideavimrc

clean:
	rm -f vimrc ideavimrc pvimrc

.PHONY: vimrc plugins intellij clean

