dotfiles
========
My personal bash, git & vim config

```bash
  git clone https://github.com/petzlux/dotfiles ~/dotfiles
  cd ~/dotfiles
  git submodule init
  git submodule update
  python install.py
```

On Redhat 7, you need to add the following .bashrc_after file to your home
directory:
````bash
  if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
      . /usr/share/git-core/contrib/completion/git-prompt.sh
  fi
```
