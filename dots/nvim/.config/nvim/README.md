# neovim

### Dependencies
- ripgrep
- fzf

## Treesitter
By default, this config installs 20+/70+ of the support languages. Run
:TSPInstallInfo to see the full list. Run the following to install a supported
language

```
:TSInstall <language>
```

## LSP
Installation of specific LSP servers depends on the language server. Refer to
the nvim-lspconfig guide for more details on each server.

### lspcontainers
Runs heavyweight LSPs (`npm`) through docker containers. Dynamically attached when
required.
- bashls
- dockerls
- terraformls
- sumneko_lua
- tailwindcss
- tsserver
- svelte
- yamlls

### Formatters and Linters
Null-ls uses a headless instance of neovim to inject lsp capabilities, allowing
for use with general purpose lsps
- ansiblels
- shellcheck
- stylua
- yamllint
- luacheck
