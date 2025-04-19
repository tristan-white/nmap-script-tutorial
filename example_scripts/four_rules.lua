prerule = function()
    print("pre")
    return true
end

hostrule = function(host)
    print("host")
    return true
end

portrule = function(host, port)
    print("port")
    return true
end

postrule = function()
    print("post")
    return true
end

action = function(host, port)
    print("\t", host)
    print("\t", port)
end