# vimrc
My vim deployment for Python and Stan development

1. run vim with -u .vimrc from this repo (often renamed if it's a shared user on a VM)
2. :PluginInstall
3. exit vim
4. Get make tools. On AWS, `sudo yum install cmake`
5. compile YouCompleteMe: 
```
cd ~/.vim/bundle/YouCompleteMe
python3 install.py
```
6. Bob is uncle.
