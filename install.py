#!/usr/bin/python
from dataclasses import dataclass
import argparse
import os
import shutil

# Parse arguments
parser = argparse.ArgumentParser(description='Install and pull config files')
parser.add_argument('--pull', action='store_true', help='Pull config files from users home directory')
parser.add_argument('files', nargs='*', help='config files to install/pull')
parser.add_argument('--list', action='store_true', help='List config files')

args = parser.parse_args()


@dataclass
class ConfigFile:
    name: str
    path: str


config_options = [
    ConfigFile('.keynavrc', './keynav/.keynavrc'),
    ConfigFile('.vimrc', './vim/.vimrc'),
    ConfigFile('.tmux.conf', './tmux/.tmux.conf'),
]

config_names = set([config.name for config in config_options])
config_by_name = {config.name: config for config in config_options}


# Lists is a terminal operation
if args.list:
    print('Possible config files:')
    for config in config_options:
        print(config.name)

    exit()

# filter input files
files = [file for file in args.files if file in config_names] if len(args.files) > 0 else list(config_names)
for file in files:
    config = config_by_name[file]
    src = ''
    dest = ''
    if args.pull:
        print(f'Pulling {config.name}')
        src = os.path.expanduser(f'~/{config.name}')
        dest = os.path.expanduser(config.path)
    else:
        print(f'Installing {config.name}')
        src = os.path.expanduser(config.path)
        dest = os.path.expanduser(f'~/{config.name}')

    print(f'Copying {src} to {dest}')
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    shutil.copy(src, dest)

