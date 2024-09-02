# ASDF cli tool version manager

* [getting started](https://asdf-vm.com/guide/getting-started.html)
* [command quick reference](https://asdf-vm.com/manage/commands.html)
* [curated plugin list](https://github.com/asdf-vm/asdf-plugins)

## Quick reference
* check plugin git repos for the plugin install command and needed dependencies
* apps installed to `/Users/<user>/.asdf/installs/<app>/<version>`
* shims located at `/Users/<user>/.asdf/shims/<app>`
* `asdf install <app> <version>` - to get app version
* `asdf global <app> <version>` - set app version in home `.tool-versions`
* `asdf local <app> <version>` - set app version in current folder `.tool-versions`
* `asdf install <app> latest` - to get latest version
* `asdf current` - list versions of tools used and the `.tool-versions` file location specifying
* `asdf list-all <app>` - list all available versions (pipe to grep)


## Install with Zsh and oh my zsh
note that homemanager will set up asdf so this isn't needed when using nix

```shell
# download asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch <latest>

# add asdf to oh my zsh plugins
```

## Managed Apps:
* [java](https://github.com/halcyon/asdf-java)
  ```shell
    # install plugin
    asdf plugin-add java https://github.com/halcyon/asdf-java.git
  ```
  ```shell
    # install deps
    sudo apt install curl unzip jq
  ```
  ```shell
    # install latest
    asdf list-all java | grep openjdk # latest doesn't work
  ```
    
* [maven](https://github.com/halcyon/asdf-maven)
  ```shell
    # install plugin
    asdf plugin-add maven
    ```
  ```shell
    # install latest
    asdf install maven latest && asdf global maven latest
  ```
    
* [node](https://github.com/asdf-vm/asdf-nodejs)
  ```shell
    # install plugin
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  ```
  ```shell
    # install latest
    asdf install nodejs latest && asdf global nodejs latest
  ```
    
* [graalvm](https://github.com/asdf-community/asdf-graalvm)
  ```shell
    # install plugin
    asdf plugin-add graalvm https://github.com/asdf-community/asdf-graalvm.git
  ```
  ```shell
    # install latest
    asdf install graalvm latest && asdf global graalvm latest
  ``` 
* [poetry](https://github.com/asdf-community/asdf-poetry)
  ```shell
    # install plugin
    asdf plugin-add poetry https://github.com/asdf-community/asdf-poetry.git
  ```
  ```shell
    # install latest
    asdf install poetry latest && asdf global poetry latest
  ```
    
* [python](https://github.com/asdf-community/asdf-python)
  ```shell
    # install plugin
    asdf plugin-add python
  ```
  ```shell
    # install deps
    sudo apt install make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev 
  ```
  ```shell
    # install latest
    asdf install python latest && asdf global python latest
  ```
    
* [golang](https://github.com/asdf-community/asdf-golang)
  ```shell
    # install plugin
    asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
  ```
  ```shell
    # install deps
    sudo apt install coreutils curl
  ```
  ```shell
    # install latest
    asdf install golang latest && asdf global golang latest
  ```
  * Run `asdf reshim golang` after using `go get` or `go install`

* [quarkus-cli](https://github.com/asdf-community/asdf-quarkus)
  ```shell
    # install plugin
    asfd plugin add quarkus
  ```
  ```shell
    # install latest
    asfd install quarkus latest && asdf global quarkus latest
  ```

* [rust]()
  ```shell
    # install plugin
    asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
  ```
  ```shell
    # install latest
    asdf install rust latest && asdf global rust latest
  ```
  