# What can nmap scripts do?

The Nmap Scripting Engine (NSE) allows you to write lua scripts that extend the functionality of nmap. It was designed with the following tasks in mind:

- Network discovery
- More sophisticated version detection
- Vulnerability detection
- Backdoor detection
- Vulnerability exploitation

# Hello World

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

# Script Format

At the top of your lua scirpt, define these fields:

- `description`: A short description of what the script does.
- `author`: Your name.
- `license`: The license under which the script is released. (e.g. "MIT")
- `categories`: A list of categories that the script belongs to. This is used for organizing scripts in the nmap script database. (e.g. {"discovery", "vuln"})
