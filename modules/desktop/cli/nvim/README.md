# Neovim Configuration Notes

## Plugin Keys

### Org Mode
[ref](https://nvim-orgmode.github.io/configuration#mappings)

in org files:
* `<leader>o,` - change priority of headline item
* `cir` - priority down
* `ciR` - priority up
* `cit` - cycle todo next
* `ciT` - cycle todo prev
* `<C-Space>` - toggle checkbox
* `<TAB>` - toggle folding for headline
* `<S-TAB>` - toggle global folding
* `<leader>ot` - set tags on headline
* `<<` - promote headline
* `>>` - demote headline

### Nvim Tree
[github](https://github.com/nvim-tree/nvim-tree.lua)
`help nvim-tree-mappings-default`
* `<leader>t` - toggle file tree window

### Telescope
* `<leader>ff` - find files
* `<leader>fg` - find w/ grep
* `<leader>fb` - find buffer
* `<leader>fh` - find help tags

### Easy Motion
* `<leader><leader><movement>` - trigger easy motion for movement options

### Conform
* `<leader>qf` - run conform on file

### Aerial
* `<leader><leader>a` - toggle aerial navigation window

### Trouble
* `<leader>xx` - toggle diagnostics window
* `<leader>xX` - toggle diagnostics window for open buffer
* `<leader>cs` - toggle trouble symbols window

### DAP debugger
[github](https://github.com/mfussenegger/nvim-dap)
* `<leader>db` - Toggle Breakpoint
* `<leader>dc` - Launch Session or resume execution
* `<leader>ds` - step over
* `<leader>di` - step into
* `<leader>do` - open inspection window
