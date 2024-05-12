local theme = "default"

if theme == "custom" then
  return {}
end

local theme_module = "base46.integrations.statusline." .. theme
return require(theme_module)
