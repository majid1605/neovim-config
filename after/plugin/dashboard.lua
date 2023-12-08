local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    return
end

local function footer()
    local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))
    local datetime = os.date("  %m-%d-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return datetime .. "   Plugins " .. plugins_count .. nvim_version_info
end



local dashboard = require("alpha.themes.dashboard")
local logo = [[

     ███╗   ███╗ █████╗      ██╗██╗██████╗      █████╗ ███╗   ██╗██████╗     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
     ████╗ ████║██╔══██╗     ██║██║██╔══██╗    ██╔══██╗████╗  ██║██╔══██╗    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
     ██╔████╔██║███████║     ██║██║██║  ██║    ███████║██╔██╗ ██║██║  ██║    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
     ██║╚██╔╝██║██╔══██║██   ██║██║██║  ██║    ██╔══██║██║╚██╗██║██║  ██║    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
     ██║ ╚═╝ ██║██║  ██║╚█████╔╝██║██████╔╝    ██║  ██║██║ ╚████║██████╔╝    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
     ╚═╝     ╚═╝╚═╝  ╚═╝ ╚════╝ ╚═╝╚═════╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝     ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

     ]]
dashboard.section.header.val = vim.split(logo, "\n")
dashboard.section.buttons.val = {
    dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
    dashboard.button("g", "󰷾 " .. " Find text", ":Telescope live_grep <CR>"),
    dashboard.button("p", "󰷾 " .. " Find text", ":Telescope projects <CR>"),
    dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "GruvboxGreen"
dashboard.section.header.opts.hl = "GruvboxBlue"
dashboard.section.buttons.opts.hl = "GruvboxGreen"

dashboard.opts.opts.noautocmd = true
--vim.cmd[[autocmd User AlphaReady echo 'ready']]
alpha.setup(dashboard.opts)
