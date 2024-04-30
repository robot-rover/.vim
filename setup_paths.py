#!/usr/bin/env python

import os
from pathlib import Path

def create_symlink(target, link_name):
    if link_name.exists():
        if link_name.is_symlink():
            link_name.unlink()
        else:
            raise RuntimeError(f'{link_name} exists and is not a symlink')
    os.symlink(target, link_name)

dotvim_dir = Path(__file__).resolve().parent
vimrc_file = Path.home() / '.vimrc'

if os.name == 'nt':
    yazi_config_dir = Path.home() / 'AppData' / 'Roaming' / 'yazi' / 'config'
    nvim_config_dir = Path.home() / 'AppData' / 'Local' / 'nvim'
elif os.name == 'posix':
    yazi_config_dir = Path.home() / '.config' / 'yazi'
    nvim_config_dir = Path.home() / '.config' / 'nvim'
else:
    raise RuntimeError(f'Unsupported OS: {os.name}')

create_symlink(dotvim_dir, nvim_config_dir)

create_symlink(dotvim_dir / 'vimrc', vimrc_file)