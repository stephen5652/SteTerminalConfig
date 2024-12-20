# Nvim configuration
gd: 98419117906e3961b718af5ca3286bc7
## 吐槽

这个是 neovim 的个性化配置,可同时在 window, ubuntu, macos 使用这套配置。

其中 debug 模式可能在 mac 之外的系统需要单独配置。

由于是刚接触 nvim , 很多地方都没有完全理解，可能会有性能方面的问题，自己也不知道怎么排查，该配置暂时能用。

## debug 支撑

目前配置好了 c c++ 项目的联调， rust 语言自己也不会，不知道是否支持。

## 踩坑

主要参考了多个大神关于 dap 的配置。

自己主要在 mac 上使用，不知道在 windows ubantu Linux 上的表现。

mac 端配置 codelldb 的时候，需要去官网下载 codelldb 包。

网上的教程没有说应该用哪个架构的,导致自己使用 v1.9.0 - codelldb-aarch64-darwin.vsix
调试了好久，最终去尝试了多个大神的配置，找到能够成功运行的配置，研究后才发现自己配置没问题，是 lldb 架构选择有问题。

注意：本人电脑是 i9 cpu, 最终使用的是 v1.9.0 codelldb-x86_64-darwin.vsix 版本。如果碰见反复调试不通的情况，可以尝试不同的 codelldb 架构。[下载地址](https://github.com/vadimcn/codelldb/releases)

## 配置策略

- 使用 packer 做插件管理
- 使用 mason 做 lsp 和 dap 的 UI 管理，个人理解 mason 没有做 lsp 和 dap 的自动加载，也有可能是我配置的不对。
- 使用 neovim/nvim-lspconfig 做 lsp 的自动加载以及配置
- 使用 mfussenegger/nvim-dap 做 dap 的自动加载以及配置

## 安装步骤

- 安装 homebrew

  链接： [`https://docs.brew.sh/Installation`](https://docs.brew.sh/Installation)

  ```shell
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  ```

- 安装 wget npm yarn

  ```shell
  brew install wget nodejs yarn
  npm config set registry http://registry.npmmirror.com
  yarn config set registry http://registry.npmmirror.com
  ```

- 下载配置

  在终端任意目录下都可以。

  ```shell
  git clone https://github.com/stephen5652/SteTerminalConfig.git ~/SteTerminalConfig
  ```

- 安装 neovim

  ```shell
  brew install neovim
  ```

- 安装 coldlldb

  - 检查 codelldb 路径

    首先确认路径是否存在：~/.local/share/nvim/data/debug/tools

    如果不存在则创建路径

    ```shell
    mkdir -pv ~/.local/share/nvim/data/debug/tools
    ```

  - 下载 codelldb

    ```shell
    wget https://github.com/vadimcn/codelldb/releases/download/v1.9.0/codelldb-x86_64-darwin.vsix -P ~/Downloads
    ```

  - 移动到目标路径

    由于配置中配置了 codelldb 的路径： os.getenv("HOME") .. "/.local/share/nvim/data/debug/tools/extension/adapter/codelldb

    所以此处需要把下载好的 codelldb 移动到目标路径，使二者匹配。

    ```shell
    unzip -d ~/.local/share/nvim/data/debug/tools/ ~/Downloads/codelldb-x86_64-darwin.vsix
    ```

- 启动 neovim

  可以在终端任意目录下启动 neovim, 它会自动使用配置文件来初始化。

  第一次启动的时候，会去加载配置，由于科学上网的原因，可能会耗时很久或者失败。不用担心失败，排查原因重新启动 neovim 就可以了，不会影响已经加载过的配置。

  ```shell
  nvim
  ```

## 帮助

本配置使用了 which-key 插件来辅助使用，初次使用的时候，可以使用 leader 键盘【即：空格键】来唤起 which-key 弹窗，用以查看各个功能怎么用。

## 快捷

为了便捷部署开发环境，专门写了一个 macos 系统的 install 脚本。所以可以忽略上面的步骤，使用 install 脚本安装环境，步骤如下：

- mac 电脑安装 homebrew

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

- 下载仓库：

  在终端任意路径下执行指令。

  ```shell
  git clone https://github.com/stephen5652/steNeovimConfig.git  ~/.config/nvim
  ```

- 执行安装脚本：

  在终端任意路径下执行指令：

  ```shell
  cd ~/.config/nvim
  chmod +x install.sh
  ./install.sh
  ```

等待脚本执行完毕，环境就准备好了。
当然，这还只是基础准备，还不能立刻用，还需要 vim 自己安装插件。 步骤如下：

    - 在终端任意目录下执行nvim, 打开nvim;
    - 一路按回车，知道packer开始下载插件；
    - packer执行完毕后，退出 nvim [关闭方法： 在normal模式下，按下 冒号键“shift+;”, 输入 q].
    - 再次打开nvim,  会出发 treesitter 下载 lsp, 一路按回车，知道treesitter下载完毕；
    - 退出 nvim, 再次打开， 如果treesitter下载完毕，就不会有提示，否则会再次出发 treesitter;
    - 至此， nvim 配置完成。

如果以上步骤执行过程中，出现问题，不要慌张，用以下方法修复问题：

- packer 没有执行完成，或者执行失败： 在 normal 模式下，按下冒号进入命令模式，输入 PakcerSync ，回车后会重新出发 packer 插件下载；
- treesitter 下载插件失败： 退出 nvim,重新进入，会继续下载上次未下载完的 lsp.
