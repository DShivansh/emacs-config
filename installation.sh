cd $(dirname "$0")
current_directory="$(pwd)"
if [ ! -d "$HOME/.emacs.d" ]; then
    mkdir "$HOME/.emacs.d"
fi

ln -s "${current_directory}/init.el" "$HOME/.emacs.d/init.el"
ln -s "${current_directory}/themes" "$HOME/.emacs.d/themes"
