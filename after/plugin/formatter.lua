require("conform").setup({
    -- format_after_save = function(bufnr)
    --     if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    --         return
    --     end
    --     -- ...additional logic...
    --     return { lsp_fallback = true }
    -- end,
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
})
