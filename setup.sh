#!/bin/bash
install(){
    rm -rf ~/.vimrc
    rm -rf ~/.vim
    ln -sf ~/vim/.vimrc ~/.vimrc
    ln -sf ~/vim/.vim ~/.vim
    mkdir ~/.vim/bundle
    git clone git@github.com:VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
    vim -c BundleInstall
    echo "Done!"
}
if [ "$1" = '--force' ]; then
    install
else
    ARRAY=()
    if [ -f ~/.vimrc ]; then
        ARRAY+=("~/.vimrc Already exists")
    fi
    if [ -d ~/.vim ]; then
        ARRAY+=("~/.vim Directory exists")
    fi
    if [ ! ${#ARRAY[@]} -eq 0 ]; then
        echo "Errors:"
        for error in "${ARRAY[@]}"; do
            echo "  $error"
        done
        echo "Use --force to overwrite"
        exit 1
    fi
    install
fi
