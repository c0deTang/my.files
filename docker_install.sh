#!/usr/env sh

INSTALLDIR=${INSTALLDIR:-"./my.files"}
create_symlinks () {
  if [ ! -f ~/.vim ]; then
    echo "Now, we will create ~/.vim and ~/.vimrc files to configure Vim."
    ln -sfn $INSTALLDIR/vim ~/.vim
  fi

  if [ ! -f ~/.vimrc ]; then
    ln -sfn $INSTALLDIR/vim/vimrc ~/.vimrc
  fi
}

if [ ! -d "$INSTALLDIR" ]; then
  echo "As we can't find my.files in the current directory, we will create it."
  git clone git://github.com/byzhang/my.files.git $INSTALLDIR
  create_symlinks
  cd $INSTALLDIR
else
  echo "Seems like you already are one of ours, so let's update Vimified to be as awesome as possible."
  create_symlinks
  cd $INSTALLDIR
  #git pull origin master
fi

mv vim/settings/ycm.vim.docker vim/settings/ycm.vim

if [ ! -d "vim/bundle" ]; then
  echo "Now, we will create a separate directory to store the bundles Vim will use."
  mkdir vim/bundle
  mkdir -p vim/tmp/backup vim/tmp/swap vim/tmp/undo
fi

if [ ! -d "vim/bundle/Vundle.vim" ]; then
  echo "Then, we install Vundle (https://github.com/gmarik/vundle)."
  git clone https://github.com/VundleVim/Vundle.vim.git vim/bundle/Vundle.vim
fi

if [ ! -d "vim/sessions" ]; then
  echo "Now, we will create a separate directory to store the sessions"
  mkdir vim/sessions
fi

echo "Enjoy!"

echo | echo | vim +PluginInstall +qall &>/dev/null

cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

cd
ln -sf my.files/cmake .cmake
ln -sf .cmake/.ycm_extra_conf.py
