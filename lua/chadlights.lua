local merge_tb = require("base46").merge_tb

local highlights = {}
local hl_dir = vim.fn.stdpath "data" .. "/site/pack/packer/opt/base46/lua/integrations"

-- push hl_dir file names to table
local hl_files = require("plenary.scandir").scan_dir(hl_dir, {})

for _, file in ipairs(hl_files) do
   local a = vim.fn.fnamemodify(file, ":t")
   a = vim.fn.fnamemodify(a, ":r")

   local integration = require("integrations." .. a)
   highlights = merge_tb(highlights, integration)
end

-- polish theme specific highlights
local polish_hl = require("base46").get_colors "polish_hl"

if polish_hl then
   highlights = merge_tb(highlights, polish_hl)
end

-- local set_transparent = require("core.utils").load_config().ui.transparency
if ui.transparency then
   highlights = merge_tb(highlights, require "nv_glassy")
end

-- finally set all highlights :D
for hl, col in pairs(highlights) do
   vim.api.nvim_set_hl(0, hl, col)
end
