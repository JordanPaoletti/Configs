This is where you configure SilverBullet to your liking. See [[^Library/Std/Config]] for a full list of configuration options.

```space-lua
config.set {
  vim = {
    unmap = {
      "<Space>"
    },
    map = {
      {
        map = "jk",
        to = "<Esc>",
        mode = "insert",
      }
    },
    noremap = {
      {
        map = "<Space>k",
        to = ":findfile<CR>",
        mode = "normal",
      },
      {
        map = "<Space>;",
        to = ":runcommand<CR>",
        mode = "normal",
      },
      {
        map = "<Space>h",
        to = ":gohome<CR>",
        mode = "normal",
      },
    },
    commands = {
      {
        command = "Navigate: Page Picker",
        ex = "findfile",
      },
      {
        command = "Open Command Palette",
        ex = "runcommand",
      },
      {
        command = "Navigate: Home",
        ex = "gohome",
      },
    },
  },
}
```

```space-style
#sb-root {
  --editor-width: 1400px !important;
}
```