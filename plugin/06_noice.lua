local ok, noice = pcall(require, "noice")
if not ok then return end

noice.setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
  },
  views = {
    cmdline_popup = {
      position = {
        row = "10%", 
        col = "50%", 
      },
      size = {
        width = 40, 
        height = "auto",
      },
      border = {
        style = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
      },
    },
  },
})
