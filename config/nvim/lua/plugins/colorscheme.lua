local status, _ = pcall(vim.cmd, "colorscheme smyck")
if not status then
  print "Could not switch colorscheme"
  return
end
