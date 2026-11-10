# my-lab

## desktop

### install\_desktop.sh

Script installing my desktop configuration for debian stable (13/trixie) and sid

- Default desktop xfce4 (can choose Gnome or KDE but conf are not ready yet for these)
    - Default video-player: Clapper (replacing parole)
    - Default gtk-theme: Colloid-Gruvbox-Dark - https://github.com/vinceliuice/Colloid-gtk-theme
    - Default icon-theme: Gruvbox-Plus-Dark - source: https://github.com/SylEleuth/gruvbox-plus-icon-pack
    - Default curors-theme: Breeze
    - Accessories: Galculator, Redshift
- Default terminal-emulator: Terminator
- Default web-browser: Brave - https://brave.com/
- Image-editor: Gimp
- Audio-tools: Sound-juicer, soundconverter
- Games: Steam, Supertuxkart

### deploy\_systools.sh

Script deploying my cli-tools (included in install\_desktop.sh)

- bdf: graphical df
- binfo: showing minimal infos about system (sort of restricted neofetch)
- colloid\_gtk: install/update Colloid-gtk-theme with gruvbox and nord variants
- gruvbox\_icons: install/update Gruvbox-Plus-Dark icon pack
- linein: switch on/off audio line in
- pastep: manage pulseaudio volume step in %
- statgitrepos: graphical compact return of git state for repos in ~/Projects/git
- sysinfo: combine binfo, bdf and statgitrepos (+themes and system update with "-u" argument)

## servers

### install\_server.sh

Install servers based on debian stable (13/trixie)

- base: just basic tools (curl, git, openssh-server, vim) and a minimal vim config
- jellyfin: web-mediacenter for my lan - https://jellyfin.org/
- xwiki: wiki for documentation and notes shared on my lan - https://www.xwiki.org/
