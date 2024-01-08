# left prompt
set -g tide_left_prompt_items vi_mode pwd git newline os character
set -g tide_left_prompt_suffix 
set -g tide_left_prompt_separator_diff_color 

# right prompt
set -g tide_right_prompt_prefix 
set -g tide_right_prompt_separator_diff_color 

# COMPONENTS

# character
set -g tide_character_icon " "
set -g tide_character_vi_icon_default " "
set -g tide_character_vi_icon_replace " "
set -g tide_character_vi_icon_visual " "

# git
set -g tide_git_icon 
set -g tide_git_bg_color green
set -g tide_git_bg_color_unstable yellow
set -g tide_git_bg_color_urgen red

# os
set -g tide_os_bg_color 2c313a
set -g tide_os_color brblue

# pwd
set -g tide_pwd_markers
set -g tide_pwd_bg_color 2c313a
set -g tide_pwd_color_anchors c7cad1
set -g tide_pwd_color_dirs c7cad1
set -g tide_pwd_color_truncated_dirs c7cad1

# virtual_env
set -g tide_python_bg_color yellow
set -g tide_python_color black

# cmd_duration
set -g tide_cmd_duration_bg_color purple

# vi_mode
set -g tide_vi_mode_bg_color_default blue
set -g tide_vi_mode_color_default black
set -g tide_vi_mode_bg_color_insert green
set -g tide_vi_mode_color_insert black
set -g tide_vi_mode_bg_color_replace red
set -g tide_vi_mode_color_replace black
set -g tide_vi_mode_bg_color_visual purple
set -g tide_vi_mode_color_visual black
