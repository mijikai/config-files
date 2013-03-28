#!/usr/bin/env python
from __future__ import print_function
from subprocess import call as proc_call, list2cmdline
import os


def process_func_maker(*head):
    """Create a function that has will call a process using the subprocess.call
    function. Each function would have a `head` as the beginning which would be
    appended by `args` when calling that function"""
    def cmd(*args):
        cmd_line = list(head)
        cmd_line.extend(args)
        print(cmd_line)
        proc_call(cmd_line)
    return cmd


mkdir_p = process_func_maker(*'mkdir -p'.split())
ln_s = process_func_maker(*'ln -s'.split())


config_files = {
        'anacrontab'                   : '~/.anacron/anacrontab',
        'bashrc'                       : '~/.bashrc',
        'elinks.conf'                  : '~/.elinks/elinks.conf',
        'luakitrc.lua'                 : '~/.config/luakit/rc.lua',
        'mpd.conf'                     : '~/.mpdconf',
        'ncmpcpp.conf'                 : '~/.ncmpcpp/config',
        'screenrc'                     : '~/.screenrc',
        'tmux.conf'                    : '~/.tmux.conf',
        'vim-bundles.vim'              : '~/.vim/vim-bundles.vim',
        'vimrc'                        : '~/.vimrc',
        'zshrc'                        : '~/.zshrc',
}


def main():
    base = os.path.abspath(os.path.dirname(__file__))
    for config, target_path in config_files.items():
        # configuration should live with the same folder as this file
        config_path = os.path.join(base, config) 
        target_path = os.path.expanduser(target_path)
        folder = os.path.dirname(target_path)
        mkdir_p(folder)
        ln_s(config_path, target_path)

if __name__ == '__main__':
    main()
