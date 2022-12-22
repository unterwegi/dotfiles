# left prompt
set -g tide_left_prompt_items os pwd git newline character
set -g tide_left_prompt_suffix 
set -g tide_left_prompt_separator_diff_color 

# right prompt
set -g tide_right_prompt_prefix 
set -g tide_right_prompt_separator_diff_color 

# COMPONENTS

# character
set -g tide_character_icon " "

# git
set -g tide_git_icon 

# os
set -g tide_os_bg_color blue

# pwd
set -g tide_pwd_markers
set -g tide_pwd_bg_color 2c313a
set -g tide_pwd_color_anchors c7cad1
set -g tide_pwd_color_dirs c7cad1
set -g tide_pwd_color_truncated_dirs c7cad1

# virtual_env
set -g tide_virtual_env_bg_color yellow
set -g tide_virtual_env_color black

# cmd_duration
set -g tide_cmd_duration_bg_color purple
