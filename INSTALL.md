# Install & Usage

My personal [NvChad](https://nvchad.com) (starter-based) Neovim configuration.

## Prerequisites

| Requirement | Why | Arch / CachyOS package |
|---|---|---|
| **Neovim ≥ 0.11** (built with 0.12) | the editor | `neovim` |
| **git** | clone + plugin manager | `git` |
| **A Nerd Font** | icons in UI / bufferline / devicons | `ttf-nerd-fonts-symbols` (+ set it in your terminal) |
| **ripgrep** | Telescope live-grep / find | `ripgrep` |
| **C compiler** (`gcc`/`cc`) | build tree-sitter parsers | `base-devel` |
| **tree-sitter CLI** | **required** to compile parsers — nvim-treesitter is on the `main` branch, which shells out to `tree-sitter` (see gotcha below) | `tree-sitter-cli` |
| **node + npm** | Mason-installed LSP servers (`html`, `cssls`) are node-based | `nodejs npm` |
| **stylua** | Lua formatter used by conform | `stylua` |

Install everything on CachyOS/Arch in one go:

```bash
sudo pacman -S --needed neovim git ripgrep base-devel tree-sitter-cli nodejs npm stylua ttf-nerd-fonts-symbols
```

## Install

```bash
git clone git@github.com:muhammad-towfique-imam/nvim-config.git ~/.config/nvim
nvim
```

On first launch, [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself and installs all plugins automatically. Let it finish, then quit and reopen.

### LSP servers & formatters (Mason)

The config enables the `html` and `cssls` language servers and the `stylua` formatter. Install their binaries via Mason:

```vim
:Mason
```

Then install `html-lsp`, `css-lsp`, and `stylua` (or install `stylua` from your package manager as above). Add more servers in `lua/configs/lspconfig.lua` and formatters in `lua/configs/conform.lua`.

### Tree-sitter parsers (important gotcha)

nvim-treesitter here is on the **`main`** branch, which compiles parsers using the **`tree-sitter` CLI** — not just a C compiler. If the CLI is missing, parser installs fail with `ENOENT ... 'tree-sitter'`. After installing `tree-sitter-cli`, add the markdown parsers (needed by render-markdown.nvim):

```vim
:TSInstall markdown markdown_inline
```

Parsers install to `~/.local/share/nvim/site/parser/`.

## Plugins added on top of NvChad

| Plugin | Purpose |
|---|---|
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | in-buffer Markdown rendering (headings, code blocks, tables, checkboxes) |
| [neogit](https://github.com/NeogitOrg/neogit) | Magit-style git UI |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | formatting (stylua for Lua) |

## Custom keymaps

Leader is `<Space>`.

| Keys | Action |
|---|---|
| `<leader>tn` | new tab |
| `<leader>tt` | terminal in a new tab (starts in insert mode) |
| `<leader>tx` | close tab |
| `<leader>gg` | open Neogit |
| `<leader>fb` | Telescope: find/switch buffer |
| `;` | enter command mode (`:`) |
| `jk` | escape (insert mode) |

Built-in tab navigation: `gt` / `gT` next/prev tab. Buffer cycling: `<Tab>` / `<S-Tab>`.

### Terminal behavior

An autocmd (`lua/autocmds.lua`) sets `buflisted = true` on `TermOpen`, so **all** terminals — both the `<leader>tt` tab-terminals and NvChad's toggle-terminals (`<leader>h`, `<leader>v`, `Alt-i`) — appear in the bufferline and `:Telescope buffers`. (NvChad hides its toggle-terminals by default; this config overrides that.)

### Markdown rendering

Open any `.md` file and it renders inline automatically. Toggle with `:RenderMarkdown toggle`. Moving the cursor onto a line reveals its raw markdown for editing.

## Updating

```bash
cd ~/.config/nvim
git pull                    # your changes from origin
:Lazy sync                  # (in nvim) update plugins

# pull upstream NvChad starter template changes, if desired:
git pull upstream main
```
