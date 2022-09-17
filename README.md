# Setting up NVIM
1) Download and install iTerm2 (brew install --cask iterm2) and NeoVim (brew install neovim)
2) Run the following to install nvim-plug for managing pludings:
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
3) Install the JetBrains throuh `Font Book` and set it as the font in iTerm2
4) Create a folder under ```~/.config/nvim``` and place the ```init.vim``` file there.
5) Open with NVIM (will get some errors) and run ```:PlugInstall```

### Code Completion Setup
Your need node installed:
```brew install node```

You need to install the extentions you need for the language you are using, my setup:
```:CocInstall coc-tsserver``` for typescript/javacript
```:CocInstall coc-python``` for python

### Debugger Setup
#### Python
1) Install debugpy in a dedicated virtual environment, this is used only for debugpy, see https://github.com/mfussenegger/nvim-dap-python for details.
```
python3 -m venv ~/environments/debugpy
source ~/environments/debugpy/bin/activate
pip3 install debugpy
```

The ```require('dap-python').setup('~/environments/debugpy/bin/python')``` will point to the python file.
