current_directory=$(dirname "$0")
if [ ! -d "$HOME/.emacs.d" ]; then
    mkdir "$HOME/.emacs.d"
fi
ln -s "${current_directory%??}/init.el" "$HOME/.emacs.d/init.el"
ln -s "${current_directory%??}/themes" "$HOME/.emacs.d/themes"
