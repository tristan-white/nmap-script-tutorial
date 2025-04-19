portrule = function(host, port)
    return port.number == 8000
end

action = function(host, port)
    return "Port " .. port.number .. " is open on " .. host.ip
end