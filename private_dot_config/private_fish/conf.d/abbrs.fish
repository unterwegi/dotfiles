# git
if command -q git
  abbr g 'git'
  abbr ga 'git add'
  abbr gaa 'git add --all'
  abbr gc 'git commit'
  abbr gcm 'git commit -m'
  abbr gs 'git status'
  abbr gp 'git push'
  abbr gpl 'git pull'
  abbr gl 'git log'
  abbr gd 'git diff'
  abbr gds 'git diff --staged'
  abbr gdc 'git diff --cached'
  abbr grm 'git rebase origin/main'
  abbr grc 'git rebase --continue'
end

# nvim
if command -q nvim
  abbr vi 'nvim'
  abbr vim 'nvim'
  abbr svi 'sudo nvim'
  abbr svim 'sudo nvim'
  abbr snvim 'sudo nvim'
  abbr vimdiff 'nvim -d'
  abbr vd 'nvim -d'
  abbr nvd 'nvim -d'
end

# lsd (ls clone)
if command -q lsd
  abbr ll 'lsd -l'
  abbr la 'lsd -la'
end
