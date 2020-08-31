# cpp_dev

## 1. 安装常用软件和基础开发编译环境
```bash
apt-get install gcc
apt-get install gcc-c++
apt-get install cmake
apt-get install build-essential
apt-get install autoconf automake libtool
apt-get instal pkg-config
apt-get  install wget
apt-get install curl
apt install net-tools
apt-get install python3
apt-get install python3 python3-pip
apt-get install aptitude
apt install vim
```

## 2. 下载vim插件和ctag工具，并配置
```bash

cd ~ && curl -fLo ~/.vim/autoload/plug.vim --create-dirs     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#安装ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags/
./autogen.sh
./configure
make && make install
echo 'alias ctags="ctags --output-format=e-ctags"' > ~/.bashrc
source ~/.bashrc
```

###  3. vimrc 配置
```vimrc
set nu
call plug#begin('~/.vim/plugged')
" 定义插件，默认用法，和 Vundle 的语法差不多
Plug 'junegunn/vim-easy-align'
Plug 'skywind3000/quickmenu.vim'
"
" " 延迟按需加载，使用到命令的时候再加载或者打开对应文件类型才加载
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
" " 确定插件仓库中的分支或者 tag
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'Valloric/YouCompleteMe'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }


set tabstop=4"表示Tab代表4个空格的宽度
set expandtab"表示Tab自动转换成空格
set autoindent"表示换行后自动缩进
set autoread " 当文件在外部被修改时，自动重新读取
set history=400"vim记住的历史操作的数量，默认的是20
set nocompatible"使用vim自己的键盘模式,而不是兼容vi的模式
set confirm"处理未保存或者只读文件时,给出提示
set smartindent"智能对齐
set shiftwidth=4
set hlsearch 
set encoding=utf-8
set tags+=~/.vim/systags
```

#4. 安装vim的插件
```bash
vim里键入:PlugInstall

# YouCompleteMe重编译
cd ~/.vim/plugged/YouCompleteMe
python3 install.py

构建系统自带库索引
ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q -R -f ~/.vim/systags /usr/include /usr/local/include
```

## 5.配好conan和clang8的docker镜像，可以开箱即用的cpp开发环境:docker pull  zqmath1994/cpp_dev:latest
