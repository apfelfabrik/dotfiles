local status, lualine = pcall(require, "lualine")
if not status then
  print "Could not load lualine"
  return
end

lualine.setup()
