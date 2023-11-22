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

## Managed Apps:
* [deno](https://github.com/asdf-community/asdf-deno)
* [tomcat](https://github.com/mbutov/asdf-tomcat)
* [java](https://github.com/halcyon/asdf-java)
* [maven](https://github.com/halcyon/asdf-maven)
* [node](https://github.com/asdf-vm/asdf-nodejs)
* [poetry](https://github.com/asdf-community/asdf-poetry)
* [python](https://github.com/asdf-community/asdf-python)
