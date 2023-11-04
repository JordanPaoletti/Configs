# Set home-manager managed zsh as default shell
if grep -Fxp "/home/$USER/.nix-profile/bin/zsh" /etc/shells
then
    echo "zsh is already in /etc/shells"
else
    echo "Adding zsh to /etc/shells"
    echo "/home/$USER/.nix-profile/bin/zsh" | sudo tee -a /etc/shells
fi

chsh -s "/home/$USER/.nix-profile/bin/zsh"

echo "Default shell set to zsh"