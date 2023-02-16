local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

local diagnostics = {
    "diagnostics",
    sources = {"nvim_diagnostic"},
    sections = {"error", "warn"},
    symbols = {
        error = " ",
        warn = " "
    },
    colored = false,
    update_in_insert = false,
    always_visible = true
}

local diff = {
    "diff",
    colored = false,
    symbols = {
        added = " ",
        modified = " ",
        removed = " "
    }, -- changes diff symbols
    cond = hide_in_width
}

local mode = {
    "mode",
    fmt = function(str)
        return "-- " .. str .. " --"
    end
}

local filetype = {
    "filetype",
    icons_enabled = true,
    icon = nil
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = ""
}

local location = {
    "location",
    padding = 0
}

-- cool function for progress
local progress = function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = {"__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██"}
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
end

local spaces = function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

return {{
    "rcarriga/nvim-notify",
    keys = {{
        "<leader>un",
        function()
            require("notify").dismiss({
                silent = true,
                pending = true
            })
        end,
        desc = "Delete all Notifications"
    }},
    opts = {
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end
    }
}, {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
            require("lazy").load({
                plugins = {"dressing.nvim"}
            })
            return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
            require("lazy").load({
                plugins = {"dressing.nvim"}
            })
            return vim.ui.input(...)
        end
    end
}, {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {{
        "<leader>bp",
        "<Cmd>BufferLineTogglePin<CR>",
        desc = "Toggle pin"
    }, {
        "<leader>bP",
        "<Cmd>BufferLineGroupClose ungrouped<CR>",
        desc = "Delete non-pinned buffers"
    }},
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            diagnostics_indicator = function(_, _, diag)
                local icons = {
                    Error = " ",
                    Warn = " ",
                    Hint = " ",
                    Info = " "
                }
                local ret = (diag.error and icons.Error .. diag.error .. " " or "") ..
                                (diag.warning and icons.Warn .. diag.warning or "")
                return vim.trim(ret)
            end,
            offsets = {{
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "Directory",
                text_align = "left"
            }}
        }
    }
}, {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = {
                left = "",
                right = ""
            },
            section_separators = {
                left = "",
                right = ""
            },
            disabled_filetypes = {"alpha", "dashboard", "NvimTree", "Outline"},
            always_divide_middle = true
        },
        sections = {
            lualine_a = {branch, diagnostics},
            lualine_b = {mode},
            lualine_c = {},
            -- lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_x = {diff, spaces, "encoding", filetype},
            lualine_y = {location},
            lualine_z = {progress}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {"filename"},
            lualine_x = {"location"},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {}
    }
}, {
    "lukas-reineke/indent-blankline.nvim",
    event = {"BufReadPost", "BufNewFile"},
    opts = {
        -- char = "▏",
        char = "│",
        filetype_exclude = {"help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy"},
        show_trailing_blankline_indent = false,
        show_current_context = false
    }
}, {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = {"BufReadPre", "BufNewFile"},
    opts = {
        -- symbol = "▏",
        symbol = "│",
        options = {
            try_as_border = true
        }
    },
    config = function(_, opts)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = {"help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason"},
            callback = function()
                vim.b.miniindentscope_disable = true
            end
        })
        require("mini.indentscope").setup(opts)
    end
}, {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true
            }
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true
        }
    },
    -- stylua: ignore
    keys = {{
        "<S-Enter>",
        function()
            require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline"
    }, {
        "<leader>snl",
        function()
            require("noice").cmd("last")
        end,
        desc = "Noice Last Message"
    }, {
        "<leader>snh",
        function()
            require("noice").cmd("history")
        end,
        desc = "Noice History"
    }, {
        "<leader>sna",
        function()
            require("noice").cmd("all")
        end,
        desc = "Noice All"
    }, {
        "<c-f>",
        function()
            if not require("noice.lsp").scroll(4) then
                return "<c-f>"
            end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = {"i", "n", "s"}
    }, {
        "<c-b>",
        function()
            if not require("noice.lsp").scroll(-4) then
                return "<c-b>"
            end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = {"i", "n", "s"}
    }}
}, {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        local logo = [[
          ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗,
          ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║,
          ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║,
          ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║,
          ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║,
          ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝,
        ]]

        dashboard.section.header.val = vim.split(logo, "\n")
        dashboard.section.buttons.val = {dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                                         dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                                         dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                                         dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
                                         dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
                                         dashboard.button("s", "勒" .. " Restore Session",
            [[:lua require("persistence").load() <cr>]]), dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
                                         dashboard.button("q", " " .. " Quit", ":qa<CR>")}
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end
        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.buttons.opts.hl = "AlphaButtons"
        dashboard.opts.layout[1].val = 8
        return dashboard
    end,
    config = function(_, dashboard)
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end
            })
        end

        require("alpha").setup(dashboard.opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end
        })
    end
}}
