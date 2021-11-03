## Oh-My-Zsh Settings

### Install zsh and oh-my-zsh

On Unbuntu-based distros, install zsh using
``` sh
sudo apt install zsh
```
and set ZSH as the default shell using
``` sh
chsh -s $(which zsh)
```

### Import zsh theme

1. Download the theme file *vbcpascal.zsh-theme* and move it into *~/.oh-my-zsh/themes*
2. Add or modify `ZSH_THEME="vbcpascal"` in your *~/.zshrc* (The default theme created by oh-my-zsh is `robbyrussell`)

If you would like to use `WorkspaceDir` as my theme for pwsh, add the following code into *~/.zshrc*. (Attention: only `~~` is supported in zsh. A command like `\`\`` is not allowed.)

``` sh
export WORKSPACEDIR= # The path

cdwsdir() {
  cd "$WORKSPACEDIR/$1"
}

alias ~~=cdwsdir
```

