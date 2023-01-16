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
  abbr gr 'git restore'
  abbr grs 'git restore --staged'
  abbr grc 'git restore --cached'
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

# exa (ls clone)
if command -q exa
  abbr ll 'exa -l --icons --git --sort=type'
  abbr la 'exa -lag --git --icons --sort=type'
end
