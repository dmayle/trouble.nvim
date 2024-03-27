local Util = require("trouble.util")

local M = {}

-- stylua: ignore
M.colors = {
  -- General
  Normal            = "NormalFloat",
  Text              = "Normal",
  Preview           = "Visual",

  -- Item
  FileName          = "Directory",
  Directory         = "Directory",
  IconDirectory     = "Special",
  Source            = "Comment",
  Pos               = "LineNr",
  Count             = "TabLineSel",

  -- Indent Guides
  Indent            = "LineNr",
  IndentFoldClosed  = "CursorLineNr",
  IndentFoldOpen    = "TroubleIndent",
  IndentTop         = "TroubleIndent",
  IndentMiddle      = "TroubleIndent",
  IndentLast        = "TroubleIndent",
  IndentWs          = "TroubleIndent",

  -- LSP Symbol Kinds
  IconArray         = "@punctuation.bracket",
  IconBoolean       = "@boolean",
  IconClass         = "@type",
  IconConstant      = "@constant",
  IconConstructor   = "@constructor",
  IconEnum          = "@lsp.type.enum",
  IconEnumMember    = "@lsp.type.enumMember",
  IconEvent         = "Special",
  IconField         = "@field",
  IconFile          = "Normal",
  IconFunction      = "@function",
  IconInterface     = "@lsp.type.interface",
  IconKey           = "@lsp.type.keyword",
  IconMethod        = "@method",
  IconModule        = "@namespace",
  IconNamespace     = "@namespace",
  IconNull          = "@constant.builtin",
  IconNumber        = "@number",
  IconObject        = "@constant",
  IconOperator      = "@operator",
  IconPackage       = "@namespace",
  IconProperty      = "@property",
  IconString        = "@string",
  IconStruct        = "@lsp.type.struct",
  IconTypeParameter = "@lsp.type.typeParameter",
  IconVariable      = "@variable",
}

function M.setup()
  M.link(M.colors)
  M.source("fs")
end

---@param prefix? string
---@param links table<string, string>
function M.link(links, prefix)
  for k, v in pairs(links) do
    k = (prefix or "Trouble") .. k
    vim.api.nvim_set_hl(0, k, { link = v, default = true })
  end
end

---@param source string
---@param links? table<string, string>
function M.source(source, links)
  ---@type table<string, string>
  links = vim.tbl_extend("force", {
    FileName = "TroubleFileName",
    Source = "TroubleSource",
    Pos = "TroublePos",
    Count = "TroubleCount",
  }, links or {})
  M.link(links, "Trouble" .. Util.camel(source))
end

return M
