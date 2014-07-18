#!/bin/bash
config_home="${XDG_CONFIG_HOME:-${HOME}/.config}/anacron"
anacron -t "${config_home}/anacrontab" -S "${config_home}/spool/"
