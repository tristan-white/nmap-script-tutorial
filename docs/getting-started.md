## What can nmap scripts do?

The Nmap Scripting Engine (NSE) allows you to write lua scripts that extend the functionality of nmap. It was designed with the following tasks in mind:

- Network discovery
- More sophisticated version detection
- Vulnerability detection
- Backdoor detection
- Vulnerability exploitation

## Hello World

A simple "hello world" nmap script could look like this...

```lua
description = "A simple Hello World script for Nmap."
author = "Your Name"
license = "MIT"
catgories = {"some_category_name"}

prerule = function()
  return true
end

action = function(host, port)
  return "hello world"
end
```

...and then its output would look like this:

<!-- termynal -->
```
$ nmap --script=./helloworld.nse 127.0.0.1
Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-04-18 20:35 EDT
Pre-scan script results:
|_helloworld: hello world
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000019s latency).
Not shown: 999 closed tcp ports (conn-refused)
PORT     STATE SERVICE
8000/tcp open  http-alt

Nmap done: 1 IP address (1 host up) scanned in 0.04 seconds
```

<br>

# Script Format

At the top of your lua scirpt, define these fields:

- `description`: A short description of what the script does.
- `author`: Your name.
- `license`: The license under which the script is released. (e.g. "MIT")
- `categories`: A list of categories that the script belongs to. This is used for organizing scripts in the nmap script database. (e.g. {"discovery", "vuln"})

## Rules and Actions


A rule is a Lua function that returns either true or false. 

Rules determine whether a script should be run against a target. 

Scripts can have one or more (up to four) rules. Each rule is evaluated at different phases of the nmap run.

`hostrule` and `portrule` take args that are lua [tables](https://www.lua.org/pil/2.5.html) which contain information on the target against which the script is executed.

### prerule()

Called before any any hosts are scanned, during the pre-scanning phase.

### hostrule(host)

Called during Nmap's normal scanning process after Nmap has performed host discovery, port scanning, version detection, and OS detection against the target host.

For each host that is up, nmap calls `hostrule`, passing it info about the host in the `host` table. The `hostrule` function can then check properties of the host to determine if it should trigger the `action`. For example, it might check to see if `host.ip` is a certain value, then return `true` to trigger the action. In lua, this would look like this:

```lua
hostrule = function(host)
    if host.ip == "192.168.1.1" then
        return true
    end
    return false
end
```

### portrule(host, port)




### postrule()