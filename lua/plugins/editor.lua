icons = {
    kinds = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Copilot = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = "ﳠ ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
      },
}
return {{
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {{
        "<leader>fE",
        function()
            require("neo-tree.command").execute({
                toggle = true,
                dir = vim.loop.cwd()
            })
        end,
        desc = "Explorer NeoTree (cwd)"
    }, {
        "<leader>e",
        "<leader>fE",
        desc = "Explorer NeoTree (cwd)",
        remap = true
    }},
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    init = function()
        vim.g.neo_tree_remove_legacy_commands = 1
        if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("neo-tree")
            end
        end
    end,
    opts = {
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        default_component_configs = {
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "ﰊ"
            },
            modified = {
                symbol = "[+]",
                highlight = "NeoTreeModified"
            },
            name = {
                trailing_slash = false,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName"
            },
            git_status = {
                symbols = {
                    -- Change type
                    added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                    deleted = "✖", -- this can only be used in the git_status source
                    renamed = "", -- this can only be used in the git_status source
                    -- Status type
                    untracked = "U",
                    ignored = "◌",
                    unstaged = "",
                    staged = "",
                    conflict = ""
                }
            }
        },
        window = {
            mappings = {
                ["<space>"] = "none",
                ["<2-LeftMouse>"] = "open",
                ["<cr>"] = "open",
                ["<esc>"] = "revert_preview",
                ["P"] = {
                    "toggle_preview",
                    config = {
                        use_float = true
                    }
                },
                ["l"] = "focus_preview",
                ["S"] = "open_split",
                ["s"] = "open_vsplit",
                ["t"] = "open_tabnew",
                ["C"] = "close_node",
                ["z"] = "close_all_nodes",
                -- ["Z"] = "expand_all_nodes",
                ["a"] = {
                    "add",
                    -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
                    -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                    config = {
                        show_path = "none" -- "none", "relative", "absolute"
                    }
                },
                ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
                -- ["c"] = {
                --  "copy",
                --  config = {
                --    show_path = "none" -- "none", "relative", "absolute"
                --  }
                -- }
                ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
                ["q"] = "close_window",
                ["R"] = "refresh",
                ["?"] = "show_help",
                ["<"] = "prev_source",
                [">"] = "next_source"
            }
        },
        filesystem = {
            filtered_items = {
                visible = false, -- when true, they will just be displayed differently than normal items
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_hidden = false, -- only works on Windows for hidden files/directories
                hide_by_name = {
                    -- "node_modules"
                },
                hide_by_pattern = { -- uses glob style patterns
                    -- "*.meta",
                    -- "*/src/*/tsconfig.json",
                },
                always_show = { -- remains visible even if other settings would normally hide it
                    -- ".gitignored",
                },
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                ".DS_Store", "thumbs.db"},
                never_show_by_pattern = { -- uses glob style patterns
                    -- ".null-ls_*",
                }
            },
            follow_current_file = false, -- This will find and focus the file in the active buffer every
            -- time the current file is changed while the tree is open.
            group_empty_dirs = false, -- when true, empty folders will be grouped together
            hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
            -- in whatever position is specified in window.position
            -- "open_current",  -- netrw disabled, opening a directory opens within the
            -- window like netrw would, regardless of window.position
            -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
            use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
            -- instead of relying on nvim autocmd events.
            window = {
                mapping = {
                    ["."] = "set_root",
                    ["H"] = "toggle_hidden",
                    ["/"] = "fuzzy_finder",
                    ["D"] = "fuzzy_finder_directory",
                    ["f"] = "filter_on_submit",
                    ["<c-x>"] = "clear_filter",
                    ["[g"] = "prev_git_modified",
                    ["]g"] = "next_git_modified"

                }
            },
            buffers = {
                follow_current_file = true, -- This will find and focus the file in the active buffer every
                -- time the current file is changed while the tree is open.
                group_empty_dirs = true, -- when true, empty folders will be grouped together
                show_unloaded = true,
                window = {
                    mappings = {
                        ["bd"] = "buffer_delete",
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root"
                    }
                }
            },
            git_status = {
                window = {
                    position = "float",
                    mappings = {
                        ["A"] = "git_add_all",
                        ["gu"] = "git_unstage_file",
                        ["ga"] = "git_add_file",
                        ["gr"] = "git_revert_file",
                        ["gc"] = "git_commit",
                        ["gp"] = "git_push",
                        ["gg"] = "git_commit_and_push"
                    }
                }
            }
        }
    }
}, {
    "windwp/nvim-spectre",

    keys = {{
        "<leader>sr",
        function()
            require("spectre").open()
        end,
        desc = "Replace in files (Spectre)"
    }}
}, {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {{
        "<leader>,",
        "<cmd>Telescope buffers show_all_buffers=true<cr>",
        desc = "Switch Buffer"
    }, {
        "<leader>/",
        "<cmd>Telescope live_grep<cr>",
        desc = "Find in Files (Grep)"
    }, {
        "<leader>:",
        "<cmd>Telescope command_history<cr>",
        desc = "Command History"
    }, {
        "<leader>f",
        "<cmd>Telescope find_files<cr>",
        desc = "Find Files (root dir)"
    }, {
        "<leader>F",
        "<cmd>Telescope oldfiles<cr>",
        desc = "Recent"
    }, -- git
    {
        "<leader>gc",
        "<cmd>Telescope git_commits<CR>",
        desc = "commits"
    }, {
        "<leader>gs",
        "<cmd>Telescope git_status<CR>",
        desc = "status"
    }, -- search
    {
        "<leader>sa",
        "<cmd>Telescope autocommands<cr>",
        desc = "Auto Commands"
    }, {
        "<leader>sb",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Buffer"
    }, {
        "<leader>sC",
        "<cmd>Telescope commands<cr>",
        desc = "Commands"
    }, {
        "<leader>sd",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Diagnostics"
    }, {
        "<leader>sh",
        "<cmd>Telescope help_tags<cr>",
        desc = "Help Pages"
    }, {
        "<leader>sH",
        "<cmd>Telescope highlights<cr>",
        desc = "Search Highlight Groups"
    }, {
        "<leader>sk",
        "<cmd>Telescope keymaps<cr>",
        desc = "Key Maps"
    }, {
        "<leader>sM",
        "<cmd>Telescope man_pages<cr>",
        desc = "Man Pages"
    }, {
        "<leader>sm",
        "<cmd>Telescope marks<cr>",
        desc = "Jump to Mark"
    }, {
        "<leader>so",
        "<cmd>Telescope vim_options<cr>",
        desc = "Options"
    }, {
        "<leader>sw",
        "<cmd>Telescope grep_string<cr>",
        desc = "Word (root dir)"
    } -- {
    --     "<leader>ss",
    --     Util.telescope("lsp_document_symbols", {
    --         symbols = {"Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait", "Field",
    --                    "Property"}
    --     }),
    --     desc = "Goto Symbol"
    -- }
    },
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            mappings = {
                i = {
                    ["<c-t>"] = function(...)
                        return require("trouble.providers.telescope").open_with_trouble(...)
                    end,
                    -- ["<a-h>"] = function()
                    --     Util.telescope("find_files", {
                    --         hidden = true
                    --     })()
                    -- end,
                    ["<C-Down>"] = function(...)
                        return require("telescope.actions").cycle_history_next(...)
                    end,
                    ["<C-Up>"] = function(...)
                        return require("telescope.actions").cycle_history_prev(...)
                    end,
                    ["<C-f>"] = function(...)
                        return require("telescope.actions").preview_scrolling_down(...)
                    end,
                    ["<C-b>"] = function(...)
                        return require("telescope.actions").preview_scrolling_up(...)
                    end
                },
                n = {
                    ["q"] = function(...)
                        return require("telescope.actions").close(...)
                    end
                }
            }
        }
    }
}, {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        plugins = {
            spelling = true
        }
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)
        wk.register({
            mode = {"n", "v"},
            ["g"] = {
                name = "+goto"
            },
            ["gz"] = {
                name = "+surround"
            },
            ["]"] = {
                name = "+next"
            },
            ["["] = {
                name = "+prev"
            },
            ["<leader><tab>"] = {
                name = "+tabs"
            },
            ["<leader>b"] = {
                name = "+buffer"
            },
            ["<leader>c"] = {
                name = "+code"
            },
            ["<leader>f"] = {
                name = "+file/find"
            },
            ["<leader>g"] = {
                name = "+git"
            },
            ["<leader>gh"] = {
                name = "+hunks"
            },
            ["<leader>q"] = {
                name = "+quit/session"
            },
            ["<leader>s"] = {
                name = "+search"
            },
            ["<leader>sn"] = {
                name = "+noice"
            },
            ["<leader>u"] = {
                name = "+ui"
            },
            ["<leader>w"] = {
                name = "+windows"
            },
            ["<leader>x"] = {
                name = "+diagnostics/quickfix"
            }
        })
    end
}, {
    "lewis6991/gitsigns.nvim",
    event = {"BufReadPre", "BufNewFile"},
    opts = {
        signs = {
            add = {
                text = "▎"
            },
            change = {
                text = "▎"
            },
            delete = {
                text = "契"
            },
            topdelete = {
                text = "契"
            },
            changedelete = {
                text = "▎"
            },
            untracked = {
                text = "▎"
            }
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, {
                    buffer = buffer,
                    desc = desc
                })
            end

            -- stylua: ignore start
            map("n", "]h", gs.next_hunk, "Next Hunk")
            map("n", "[h", gs.prev_hunk, "Prev Hunk")
            map({"n", "v"}, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
            map({"n", "v"}, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
            map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
            map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
            map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
            map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
            map("n", "<leader>ghb", function()
                gs.blame_line({
                    full = true
                })
            end, "Blame Line")
            map("n", "<leader>ghd", gs.diffthis, "Diff This")
            map("n", "<leader>ghD", function()
                gs.diffthis("~")
            end, "Diff This ~")
            map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end
    }
}, {
    "RRethy/vim-illuminate",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
        delay = 200
    },
    config = function(_, opts)
        require("illuminate").configure(opts)
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local buffer = vim.api.nvim_get_current_buf()
                pcall(vim.keymap.del, "n", "]]", {
                    buffer = buffer
                })
                pcall(vim.keymap.del, "n", "[[", {
                    buffer = buffer
                })
            end
        })
    end,
    -- stylua: ignore
    keys = {{
        "]]",
        function()
            require("illuminate").goto_next_reference(false)
        end,
        desc = "Next Reference"
    }, {
        "[[",
        function()
            require("illuminate").goto_prev_reference(false)
        end,
        desc = "Prev Reference"
    }}
}, {
    "echasnovski/mini.bufremove",
    -- stylua: ignore
    keys = {{
        "<leader>bd",
        function()
            require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer"
    }, {
        "<leader>bD",
        function()
            require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)"
    }}
}, {
    "folke/trouble.nvim",
    cmd = {"TroubleToggle", "Trouble"},
    opts = {
        use_diagnostic_signs = true
    },
    keys = {{
        "<leader>xx",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Document Diagnostics (Trouble)"
    }, {
        "<leader>xX",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics (Trouble)"
    }, {
        "<leader>xL",
        "<cmd>TroubleToggle loclist<cr>",
        desc = "Location List (Trouble)"
    }, {
        "<leader>xQ",
        "<cmd>TroubleToggle quickfix<cr>",
        desc = "Quickfix List (Trouble)"
    }}
},
{
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("config.util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = icons.kinds,
      }
    end,
  }

}
