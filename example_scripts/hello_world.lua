description = [[
A simple Hello World script for Nmap.
]]

prerule = function()
  return true
end

action = function(host, port)
  return "hello world"
end