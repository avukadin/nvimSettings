# Setting up NVIM
1) Download and install iTerm2 (brew install --cask iterm2) and NeoVim (MAC:brew install neovim, On Ubuntu, to get the latest vesrsion: `sudo add-apt-repository ppa:neovim-ppa/stable` `sudo apt update && sudo apt install neovim -y`)
2) Run the following to install nvim-plug for managing plugins:
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
3) Install the JetBrains throuh `Font Book` and set it as the font in iTerm2
4) install git and do `git config --global credential.helper store`
5) Create a folder under ```~/.config/nvim``` and place the ```init.vim``` file there.
6) Install nodejs (MAC: brew install node, UBUNTU: `curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -`, `sudo apt install -y nodejs`)
7) Install npm and yarn (sudo npm install --global yarn)

9) Open with NVIM (will get some errors) and run ```:PlugInstall```
10) cd into  ```~/.local/share/nvim/plugged/coc.nvim``` and run ```yarn install```
You need to install the extentions you need for the language you are using, my setup:
```:CocInstall coc-tsserver``` for typescript/javacript
```:CocInstall coc-python``` for python
11) Set key bindings in iTerm2 :
<img width="413" alt="image" src="https://user-images.githubusercontent.com/16506713/201479613-dec9c091-431e-4d41-a95a-b32d621dbb2e.png">
12) Install silver searcher (MAC:`brew install the_silver_searcher`, Ubuntu:`sudo apt-get install silversearcher-ag`) this is needed for CtrSF and add the below to .zshrc

```
#determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
#refer rg over ag
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi
```


13) run `pip3 install jedi`, this is need for coc code completion


### Debugger Setup
#### Python
1) Install debugpy in a dedicated virtual environment, this is used only for debugpy, see https://github.com/mfussenegger/nvim-dap-python for details.
```
python3 -m venv ~/environments/debugpy
source ~/environments/debugpy/bin/activate
pip3 install debugpy
```

The ```require('dap-python').setup('~/environments/debugpy/bin/python')``` will point to the python file.

#### Typescript/Javascript React
https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Javascript-chrome
- git clone https://github.com/Microsoft/vscode-chrome-debug
- cd ./vscode-chrome-debug
- npm install
- npm run build

<br />Change path in init.vim file to above if needed
<br />Launch Chrome in debug mode on mac with:
```
sudo /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=9222
```
