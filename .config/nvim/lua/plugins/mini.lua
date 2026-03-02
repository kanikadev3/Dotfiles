return { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup({

            -- Add custom surroundings to be used on top of builtin ones. For more
            -- information with examples, see `:h MiniSurround.config`.
            custom_surroundings = nil,

            -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
            highlight_duration = 500,

            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                add = 'sa',        -- Add surrounding in Normal and Visual modes
                delete = 'sd',     -- Delete surrounding
                find = 'sf',       -- Find surrounding (to the right)
                find_left = 'sF',  -- Find surrounding (to the left)
                highlight = 'sh',  -- Highlight surrounding
                replace = 'sr',    -- Replace surrounding

                suffix_last = 'l', -- Suffix to search with "prev" method
                suffix_next = 'n', -- Suffix to search with "next" method
            },

            -- Number of lines within which surrounding is searched
            n_lines = 20,

            -- Whether to respect selection type:
            -- - Place surroundings on separate lines in linewise mode.
            -- - Place surroundings on each line in blockwise mode.
            respect_selection_type = false,

            -- How to search for surrounding (first inside current line, then inside
            -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
            -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
            -- see `:h MiniSurround.config`.
            search_method = 'cover',

            -- Whether to disable showing non-error feedback
            -- This also affects (purely informational) helper messages shown after
            -- idle time if user input is required.
            silent = false,

        })

        local tabline = require("mini.tabline")
        tabline.setup(
        -- No need to copy this inside `setup()`. Will be used automatically.
            {
                -- Whether to show file icons (requires 'mini.icons')
                show_icons = true,

                -- Function which formats the tab label
                -- By default surrounds with space and possibly prepends with icon
                format = nil,

                -- Where to show tabpage section in case of multiple vim tabpages.
                -- One of 'left', 'right', 'none'.
                tabpage_section = 'left',
            }

        )


        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require("mini.statusline")
        -- set use_icons to true if you have a Nerd Font
        statusline.setup({ use_icons = vim.g.have_nerd_font })

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return "%2l:%-2v"
        end

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
        require("mini.pairs").setup({
            -- In which modes mappings from this `config` should be created
            modes = { insert = true, command = false, terminal = false },

            -- Global mappings. Each right hand side should be a pair information, a
            -- table with at least these fields (see more in |MiniPairs.map|):
            -- - <action> - one of 'open', 'close', 'closeopen'.
            -- - <pair> - two character string for pair to be used.
            -- By default pair is not inserted after `\`, quotes are not recognized by
            -- <CR>, `'` does not insert pair after a letter.
            -- Only parts of tables can be tweaked (others will use these defaults).
            mappings = {
                ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
                ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
                ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

                [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
                ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
                ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

                ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
                ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
                ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
            },
        })
    end,
}
