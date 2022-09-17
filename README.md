# Setting up NVIM
1) Download and install iTerm2
2) Install the JetBrains throuh `Font Book`
3) Create a folder under ```~/.config/nvim``` and place the ```init.vim``` file there.
4) Open with NVIM and run ```:PlugInstall```

### Debugger Setup
#### Python
1) Install debugpy in a dedicated virtual environment, this is used only for debugpy, see https://github.com/mfussenegger/nvim-dap-python for details.
```
python3 -m venv ~/environments/debugpy
source ~/environments/debugpy/bin/activate
pip3 install debugpy
```

The ```require('dap-python').setup('~/environments/debugpy/bin/python')``` will point to the python file.
