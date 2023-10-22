local Util = require("trouble.util")

---@alias trouble.Indent.type "top"|"middle"|"last"|"fold_open"|"fold_closed"|"ws"
---@alias trouble.Indent.symbols table<trouble.Indent.type, string|string[]>

---@class SymbolSegment: TextSegment
---@field type trouble.Indent.type

---@class trouble.Indent: {[number]: SymbolSegment}
---@field symbols table<string, SymbolSegment>
local M = {}
M.__index = M

---@type trouble.Indent.symbols
-- stylua: ignore
M.symbols = {
  top         = "│ ",
  middle      = "├╴",
  last        = "└╴",
  -- last     = "╰╴", -- rounded
  fold_open   = " ",
  fold_closed = " ",
  ws          = "  ",
}

---@param symbols? trouble.Indent.symbols
function M.new(symbols)
  local self = setmetatable({}, M)
  self.symbols = {}
  for k, v in pairs(M.symbols) do
    local symbol = symbols and symbols[k] or v
    self.symbols[k] = type(symbol) == "string" and { str = symbol } or { str = symbol[1], hl = symbol[2] }
    self.symbols[k].type = k
    self.symbols[k].hl = self.symbols[k].hl or ("TroubleIndent" .. Util.camel(k))
  end
  return self
end

function M:clone()
  local new = setmetatable({}, M)
  for k, v in pairs(self) do
    new[k] = v
  end
  return new
end

---@param other trouble.Indent.type
function M:add(other)
  table.insert(self, self.symbols[other])
  return self
end

---@return SymbolSegment?
function M:del()
  return table.remove(self)
end

---@param other trouble.Indent.type
function M:extend(other)
  return self:clone():add(other)
end

function M:multi_line()
  local last = self:del()
  if last then
    self:add(last.type == "middle" and "top" or last.type == "last" and "ws" or last.type)
  end
  return self
end

return M