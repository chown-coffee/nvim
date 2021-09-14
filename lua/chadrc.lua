-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater

-- The setup config table shows all available config options with their default values:
require("presence"):setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
    -- client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer
    git_commit_text     = "Committing changes",       -- Format string rendered when commiting changes in git
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer
    workspace_text      = "Working on %s",            -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
    line_number_text    = "Line %s out of %s",        -- Line number format string (for when enable_line_number is set to true)
})

local M = {}
M.ui, M.options, M.plugin_status, M.mappings, M.custom = {}, {}, {}, {}, {}

-- non plugin ui configs, available without any plugins
M.ui = {
  italic_comments = false,

  -- theme to be used, to see all available themes, open the theme switcher by <leader> + th
  theme = "chadracula",

  -- theme toggler, toggle between two themes, see theme_toggleer mappings
  theme_toggler = {
    enabled = false,
    fav_themes = {
      "chadracula",
      "onedark",
      "tokyonight",
    },
  },

  -- Enable this only if your terminal has the colorscheme set which nvchad uses
  -- For Ex : if you have onedark set in nvchad , set onedark's bg color on your terminal
  transparency = false,
}

-- plugin related ui options
M.ui.plugin = {
  -- statusline related options
  statusline = {
    -- these are filetypes, not pattern matched
    -- if a filetype is present in shown, it will always show the statusline, irrespective of filetypes in hidden
    hidden = {},
    shown = {},
    -- default, round , slant , block , arrow
    style = "default",
  },
}

-- non plugin normal, available without any plugins
M.options = {
  clipboard = "unnamedplus",
  cmdheight = 1,
  copy_cut = true, -- copy cut text ( x key ), visual and normal mode
  copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
  expandtab = true,
  hidden = true,
  ignorecase = false,
  insert_nav = true, -- navigation in insertmode
  mapleader = " ",
  mouse = "a",
  number = true,
  -- relative numbers in normal mode tool at the bottom of options.lua
  numberwidth = 2,
  permanent_undo = true,
  shiftwidth = 2,
  smartindent = true,
  tabstop = 2, -- Number of spaces that a <Tab> in the file counts for
  timeoutlen = 400,
  relativenumber = true,
  ruler = false,
  updatetime = 250,
  -- used for updater
  update_url = "https://github.com/NvChad/NvChad",
  update_branch = "main",
}

-- these are plugin related options
M.options.plugin = {
  autosave = false, -- autosave on changed text or insert mode leave
  -- timeout to be used for using escape with a key combination, see mappings.plugin.better_escape
  esc_insertmode_timeout = 300,
}

-- enable and disable plugins (false for disable)
M.plugin_status = {
  autosave = false, -- to autosave files
  blankline = true, -- beautified blank lines
  bufferline = true, -- buffer shown as tabs
  cheatsheet = true, -- fuzzy search your commands/keymappings
  colorizer = true,
  comment = true, -- universal commentor
  dashboard = true, -- a nice looking dashboard
  esc_insertmode = true, -- escape from insert mode using custom keys
  feline = true, -- statusline
  gitsigns = true, -- gitsigns in statusline
  lspkind = true, -- lsp enhancements
  lspsignature = true, -- lsp enhancements
  neoformat = true, -- universal formatter
  neoscroll = false, -- smooth scroll
  telescope_media = true, -- see media files in telescope picker
  truezen = false, -- no distraction mode for nvim
  vim_fugitive = true, -- git in nvim
  vim_matchup = true, -- % magic, match it but improved
}

-- mappings -- don't use a single keymap twice --
-- non plugin mappings
M.mappings = {
  -- close current focused buffer
  close_buffer = "<leader>x",
  copy_whole_file = "<A-z>", -- copy all contents of the current buffer

  -- navigation in insert mode, only if enabled in options
  insert_nav = {
    backward = "<C-h>",
    end_of_line = "<C-e>",
    forward = "<C-l>",
    next_line = "<C-k>",
    prev_line = "<C-j>",
    top_of_line = "<C-a>",
  },

  -- line_number_toggle = "<leader>n", -- show or hide line number
  new_buffer = "<S-t>", -- open a new buffer
  new_tab = "<C-t>b", -- open a new vim tab
  save_file = "<C-s>", -- save file using :w
  theme_toggler = "<leader>tt", -- for theme toggler, see in ui.theme_toggler

  -- terminal related mappings
  terminal = {
    -- multiple mappings can be given for esc_termmode and esc_hide_termmode
    -- get out of terminal mode
    esc_termmode = { "jk" }, -- multiple mappings allowed
    -- get out of terminal mode and hide it
    -- it does not close it, see pick_term mapping to see hidden terminals
    esc_hide_termmode = { "JK" }, -- multiple mappings allowed
    -- show hidden terminal buffers in a telescope picker
    pick_term = "<leader>W",
    -- below three are for spawning terminals
    new_horizontal = "<leader>h",
    new_vertical = "<leader>v",
    new_window = "<leader>w",
  },

  -- update nvchad from nvchad, chadness 101
  update_nvchad = "<leader>uu",
}

-- all plugins related mappings
-- to get short info about a plugin, see the respective string in plugin_status, if not present, then info here
M.mappings.plugin = {
  bufferline = {
    next_buffer = "<TAB>", -- next buffer
    prev_buffer = "<S-Tab>", -- previous buffer
    --better window movement
    moveLeft = "<C-h>",
    moveRight = "<C-l>",
    moveUp = "<C-k>",
    moveDown = "<C-j>",
  },
  chadsheet = {
    default_keys = "<leader>dk",
    user_keys = "<leader>uk",
  },
  comment = {
    toggle = "<leader>/", -- trigger comment on a single/selected lines/number prefix
  },
  dashboard = {
    bookmarks = "<leader>bm",
    new_file = "<leader>fn", -- basically create a new buffer
    open = "<leader>db", -- open dashboard
    session_load = "<leader>l", -- load a saved session
    session_save = "<leader>s", -- save a session
  },
  -- note: this is an edditional mapping to escape, escape key will still work
  better_escape = {
    esc_insertmode = { "jk" }, -- multiple mappings allowed
  },
  nvimtree = {
    toggle = "<leader>n", -- file manager
  },
  neoformat = {
    format = "<leader>fm",
  },
  telescope = {
    buffers = "<leader>fb",
    find_files = "<leader>ff",
    git_commits = "<leader>cm",
    git_status = "<leader>gt",
    help_tags = "<leader>fh",
    live_grep = "<leader>fw",
    oldfiles = "<leader>fo",
    themes = "<leader>th",
  },
  telescope_media = {
    media_files = "<leader>fp",
  },
  truezen = { -- distraction free modes mapping, hide statusline, tabline, line numbers
    ataraxis_mode = "<leader>zz", -- center
    focus_mode = "<leader>zf",
    minimalistic_mode = "<leader>zm", -- as it is
  },
  vim_fugitive = {
    diff_get_2 = "<leader>gh",
    diff_get_3 = "<leader>gl",
    git = "<leader>gs",
    git_blame = "<leader>gb",
  },
}

-- user custom mappings
-- e.g: name = { "mode" , "keys" , "cmd" , "options"}
-- name: can be empty or something unique with repect to other custom mappings
--    { mode, key, cmd } or name = { mode, key, cmd }
-- mode: usage: mode or { mode1, mode2 }, multiple modes allowed, available modes => :h map-modes,
-- keys: multiple keys allowed, same synxtax as modes
-- cmd:  for vim commands, must use ':' at start and add <CR> at the end if want to execute
-- options: see :h nvim_set_keymap() opts section
M.custom.mappings = {
  -- clear_all = {
    --    "n",
    --    "<leader>cc",
    --    "gg0vG$d",
    -- },
  }

return M
