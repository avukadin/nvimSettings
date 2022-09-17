# Setting up NVIM
Create a folder under ```~/.config/nvim``` and place the ```init.vim``` file there.


### Debugger Setup
#### Python
1) Install debugpy in a dedicated virtual environment, this is used only for debugpy, see https://github.com/mfussenegger/nvim-dap-python for details.
```
python3 -m venv ~/environments/debugpy
```
The ```require('dap-python').setup('~/environments/debugpy/bin/python')``` will point to the python file.
