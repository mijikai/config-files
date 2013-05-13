#!/usr/bin/env python
from __future__ import print_function
from subprocess import call as proc_call, list2cmdline, check_output
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

exceptions = ('setup.py', 'tmux_session')


def main():
    base = os.path.abspath(os.path.dirname(__file__))

    exceptions_expanded = tuple(os.path.join(base, i) for i in exceptions)
    files = []
    for dirpath, _, filenames in os.walk(base):
        for f in filenames:
            files.append(os.path.join(dirpath, f))

    config_files = tuple(set(files) - set(exceptions_expanded))
    home_path = os.path.expanduser('~/')

    for config_path in config_files:
        # configuration should live with the same folder as this file
        config_path = os.path.abspath(config_path)
        rest_target_path = os.path.relpath(config_path)
        target_path = os.path.join(home_path, rest_target_path)
        folder = os.path.dirname(target_path)

        mkdir_p(folder)
        ln_s(config_path, target_path)

if __name__ == '__main__':
    main()
