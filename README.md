# unterwegi's dot files

## Bootstrap

Add SSH key in https://github.com/settings/keys

Install chezmoi: https://www.chezmoi.io/install/

```bash
chezmoi init --ssh --apply unterwegi
```

### One Liner

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --ssh --apply unterwegi
```

## Terminal Setup

"Solarized Dark Custom" color palette example (taken from a xfce4 terminalrc):

```ini
[Configuration]
ColorForeground=#C000CF00D100
ColorBackground=#050024002B00
ColorPalette=#070736364242;#DCDC32322F2F;#9626D47A98A4;#B5B589890000;#26268B8BD2D2;#D3D336368282;#2A2AA1A19898;#EEEEE8E8D5D5;#12424C6D5B4E;#CBCB4B4B1616;#4BB183693DC3;#B19AB40C399D;#838394949696;#6C6C7171C4C4;#9393A1A1A1A1;#FDFDF6F6E3E3
FontName=CaskaydiaCove Nerd Font Mono 12
ColorBoldIsBright=FALSE
```

## Things to do
 * finish nvim setup (telescope, language servers, ...)
