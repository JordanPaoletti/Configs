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
    * ```shell
      asdf plugin-add java https://github.com/halcyon/asdf-java.git
      ```
* [maven](https://github.com/halcyon/asdf-maven)
    * ```shell
      asdf plugin-add maven
      ```
* [node](https://github.com/asdf-vm/asdf-nodejs)
    * ```shell
      asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
      ```
* [poetry](https://github.com/asdf-community/asdf-poetry)
    * ```shell
      asdf plugin-add poetry https://github.com/asdf-community/asdf-poetry.git
      ```
* [python](https://github.com/asdf-community/asdf-python)
    * ```shell
      asdf plugin-add python
      ```
