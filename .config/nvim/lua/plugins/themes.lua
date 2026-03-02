return {
    { "miikanissi/modus-themes.nvim" },
    { "ellisonleao/gruvbox.nvim" },
    { "navarasu/onedark.nvim" },
    { "tomasiser/vim-code-dark" },
    { "EdenEast/nightfox.nvim" },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            -- require('rose-pine/neovim').setup{
            --     styles = {
            --         comments = { italic = false },
            --     },
            -- }
            --vim.cmd("colorscheme rose-pine")
            -- vim.o.termguicolors = false
            --        vim.o.background = "dark"
            -- vim.cmd.colorscheme("evening")
            --
            vim.cmd("colorscheme gruvbox")
        end,
    },
}
