sudo nix-channel --add https://nixos.org/channels/nixos-unstable
sudo nix-channel --update
sudo nixos-rebuild boot --upgrade

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub com.google.Chrome
flatpak install -y flathub org.libreoffice.LibreOffice
flatpak install -y flathub us.zoom.Zoom
flatpak install -y mint-y-dark-blue

reboot