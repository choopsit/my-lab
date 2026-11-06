# my-lab

## desktop

### install\_desktop.sh

Script installing my destop conf for any PC/VM I use based on debian stable (13/trixie) and sid

- Default desktop xfce4 (can choose Gnome or KDE but conf are not ready yet for these)
    - Default video-player: Clapper
    - Default gtk-theme: Colloid-Gruvbox-Dark (source: https://github.com/vinceliuice/Colloid-gtk-theme)
    - Default icon-theme: Gruvbox-Plus-Dark (source: https://github.com/SylEleuth/gruvbox-plus-icon-pack)
    - Default curors-theme: Breeze
- Default terminal-emulator: Terminator
- Default web-browser: Brave

### deploy\_systools.sh

Script deploying my cli-tools (included in install\_desktop.sh)

- bdf: graphical df
- binfo: showing minimal infos about system (sort of restricted neofetch)
- colloid\_gtk: install/update Colloid-gtk-theme with gruvbox and nord variants
- gruvbox\_icons: install/update Gruvbox-Plus-Dark icon pack
- linein: switch on/off audio line in
- pastep: manage pulseaudio volume step in %
- statmygit: graphical compact return of git state for repos in ~/Projects/git
- sysinfo: combine binfo, bdf and statmygit (+themes and system update with "-u" argument)

## servers

### install\_server.sh

Install servers based on stable (13/trixie)

- base: just basic tools installation (curl, git, ssh, vim) and a minimal vim config
- jellyfin: web-mediacenter for my lan

