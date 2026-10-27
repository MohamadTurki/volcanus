local autocorrect = require("util.autocorrect")
autocorrect.setup()

Snacks.toggle.option("spell", { name = "Spell Check" }):map("<leader>ts")
Snacks.toggle.new({
  id = "autocorrect",
  name = "Autocorrect",
  get = function() return autocorrect.enabled end,
  set = function(state) autocorrect.enabled = state end,
}):map("<leader>tS")
