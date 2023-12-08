
local map = vim.keymap.set

vim.g.mapleader = " "

-- Add console log to code with variable
function addWordToNextLine()
  local currentWord = vim.fn.expand("<cword>")
  local currentFile = vim.fn.expand("%:t")
  local currentLine = vim.fn.line(".")+1
  local message = "Output from "..currentFile.." and line "..currentLine.." : "
  local newLine = 'console.log("'..message  ..'",'.. currentWord..');'
  vim.api.nvim_feedkeys('o', 'n', true)
  vim.api.nvim_feedkeys(newLine, 'n', true)
end

map('n', '<leader>mc', ':lua addWordToNextLine()<CR>', { noremap = true, silent = true })



-- Selecte text and put in (),[],...
function wrapSelectionWithMatchingSymbols(openSymbol, closeSymbol)
  -- Get the start and end positions of the selected range
  local visualStart = vim.fn.getpos("'<")
  local visualEnd = vim.fn.getpos("'>")

  -- Get the content of the selected text
  local lines = vim.fn.getline(visualStart[2], visualEnd[2])
  local selectedText = table.concat(lines, "\n")

  -- Modify the first line
  lines[1] = lines[1]:sub(1, visualStart[3] - 1) .. openSymbol .. lines[1]:sub(visualStart[3])

  -- Modify the last line
  lines[#lines] = lines[#lines]:sub(1, visualEnd[3]) .. closeSymbol .. lines[#lines]:sub(visualEnd[3] + 1)

  -- Set the modified lines
  vim.fn.setline(visualStart[2], lines)

  -- Adjust the visual selection to include the added symbols
  vim.fn.setpos("'<", { visualStart[1], visualStart[2], visualStart[3] + #openSymbol })
  vim.fn.setpos("'>", { visualEnd[1], visualEnd[2], visualEnd[3] + #closeSymbol })
end

map('v', '<leader>(', [[:lua wrapSelectionWithMatchingSymbols('(', ')')<CR>%]], { noremap = true, silent = true })
map('v', '<leader>[', [[:lua wrapSelectionWithMatchingSymbols('[', ']')<CR>%]], { noremap = true, silent = true })
map('v', '<leader>{', [[:lua wrapSelectionWithMatchingSymbols('{', '}')<CR>%]], { noremap = true, silent = true })
map('v', '<leader><', [[:lua wrapSelectionWithMatchingSymbols('<', '>')<CR>%]], { noremap = true, silent = true })
map('v', "<leader>'", [[:lua wrapSelectionWithMatchingSymbols("'", "'")<CR>f']], { noremap = true, silent = true })
map('v', '<leader>"', [[:lua wrapSelectionWithMatchingSymbols('"', '"')<CR>f"]], { noremap = true, silent = true })
map('v', '<leader>`', [[:lua wrapSelectionWithMatchingSymbols('`', '`')<CR>f`]], { noremap = true, silent = true })



-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds,{ noremap = true, silent = true })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds,{ noremap = true, silent = true })
vim.keymap.set('n', 'zP', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.lsp.buf.hover()
    end
end)


-- Automatically close brackets, parentheses, and quotes

map("i", "'", "''<left>")
map("i", "`", "``<left>")
map("i", "\"", "\"\"<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "{;", "{};<left><left>")
map("i", "/*", "/**/<left><left>")


-- Move selected lines up/down
map("x", "J", ":move '>+1<CR>gv=gv", {})
map("x", "K", ":move '<-2<CR>gv=gv", {})

-- map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")


-- save file
map({ "i", "v" }, "<C-s>", "<Esc>:wa<CR>",{ silent = true, noremap = true })

-- greatest remap ever
map("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

map({ "n", "v" }, "<leader>d", [["_d]])


map("i", "<C-c>", "<Esc>")

map("n", "Q", "<nop>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
--map("n", "<leader>f", vim.lsp.buf.format)

map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

-- map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

map("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
map("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

map("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Normal --
-- Better window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

--map("v", "(", "c(<C-r><C-o>)<Esc>")
-- Search and Replace
map("v", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>i<CR>]], { silent = true })
map("v", "<leader>sa", [[/\<<C-r><C-w>\><CR>]], { silent = true })
-- SymbolsOutline plugin
map("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR>", { silent = true })
map("n", "<leader>ms", ":SymbolsOutline<CR>", { silent = true })

-- map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })             -- restore last workspace session for current directory
-- map("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory

-- Buffer line (tab)
map("n", "<C-A-c>", ":BufferLinePickClos<cr>", { silent = true, noremap = true })
map("n", "<C-A-n>", ":BufferLineCycleNext<cr>", { silent = true, noremap = true })
map("n", "<C-A-p>", ":BufferLineCyclePrev<cr>", { silent = true, noremap = true })

map("n", "<leader>ct", ":CloakToggle>", { silent = true, noremap = true })

-- Neogen define doc block
local opts = { noremap = true, silent = true }
map("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
map("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
map("i", "<C-l>", ":lua require('neogen').jump_next<CR>", opts)
map("i", "<C-h>", ":lua require('neogen').jump_prev<CR>", opts)

-- NvimTree plugin
map("n", "<C-A-m>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

-- Refactor Plugin
map("x", "<leader>re", ":Refactor extract ")
map("x", "<leader>rf", ":Refactor extract_to_file ")

map("x", "<leader>rv", ":Refactor extract_var ")

map({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

map("n", "<leader>rI", ":Refactor inline_func")

map("n", "<leader>rb", ":Refactor extract_block")
map("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- Trouble plugin
map("n", "<leader>xx", function() require("trouble").toggle() end)
map("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
map("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
map("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
map("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
map("n", "gR", function() require("trouble").toggle("lsp_references") end)

-- Undotree plugin
map("n", "<leader>u", vim.cmd.UndotreeToggle)

-- inc-rename.nvim plugin
map("n", "<leader>rn", ":IncRename ")
map("n", "<leader>rnw", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
------ harpoon
--  vim.keymap.set("n", "<leader>a", mark.add_file)
--  vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

--  vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
--  vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
--  vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
--  vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)

--- LSP
--[[
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})
]]
--


--[[
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "lh", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    ]]
--


-- Telescop

--[[
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sp', require('telescope.builtin').spell_suggest	, { desc = '[S]earch [S]ell' })
vim.keymap.set('n', '<leader>so', require('telescope.builtin').oldfiles	, { desc = '[S]earch [O]ld' })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()

]]
--
