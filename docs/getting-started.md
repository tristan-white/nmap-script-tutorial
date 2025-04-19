## What can nmap scripts do?

The Nmap Scripting Engine (NSE) allows you to write lua scripts that extend the functionality of nmap. It was designed to help enable users to do custome tasks dealing with:

- Network discovery
- More sophisticated version detection
- Vulnerability detection
- Backdoor detection
- Vulnerability exploitation

## Hello World

A simple "hello world" nmap script could look like this...

```lua
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

At the top of your script, you may optionally define these fields:

- `description`: A short description of what the script does. This is shown in the 
- `author`: Your name.
- `license`: The license under which the script is released. (e.g. "MIT")
- `categories`: A list of categories that the script belongs to. This is used for organizing scripts in the nmap script database. (e.g. {"discovery", "vuln"})

## The Action

The action is a lua function named `action` defined by your script that gets triggered if any rule evaluates to true.

It takes two arguments: `host` and `port`. The `host` argument is a table that contains information about the target hosts, and the `port` argument is a table that contains information about the target ports.

!!! tip "Lua Tables"

    If you're coming from python, you can sort of think of lua tables as dictionaries or objects, but lua tables are more flexible and can be used as arrays as well. See [here](https://www.lua.org/pil/2.5.html) for a quick intro to lua tables.

## Rules and Actions

A rule is a Lua function that returns either true or false. 

Rules determine whether a script should be run against a target. 

Scripts can have one or more (up to four) rules. Each rule is evaluated at different phases of the nmap run.

`hostrule` and `portrule` take args that are lua tables which contain information on the target against which the script is executed.

### prerule()

Called before any any hosts are scanned, during the pre-scanning phase.

### hostrule(host)

Called during Nmap's normal scanning process after Nmap has performed host discovery, port scanning, version detection, and OS detection against the target host.

For each host that is up, nmap calls `hostrule`, passing it info about the host in the `host` table. The `hostrule` function can then check properties of the host to determine if it should trigger the `action`. For example, it might check to see if `host.ip` is a certain value, then return `true` to trigger the action. In lua, this would look like this:

```lua
hostrule = function(host)
    return host.ip == "192.168.1.1"
end

action = function(host, port)
    return "hello world"
end
```

### portrule(host, port)

This function gets called for every port on every host that is up.

??? example

    Consider this script:

    ```lua title="portrule.nse"
    portrule = function(host, port)
        return port.number == 8000
    end 
    action = function(host, port)
        return "port 8000 is open"
    end
    ```     

    Running it produces this output:

    <!-- termynal -->
    ```
    $ nmap --script=./portrule.nse 127.0.0.1
    Starting Nmap 7.94SVN ( https://nmap.org ) at 2025-04-19 08:59 EDT
    Nmap scan report for localhost (127.0.0.1)
    Host is up (0.000022s latency).
    Not shown: 998 closed tcp ports (conn-refused)
    PORT     STATE SERVICE
    631/tcp  open  ipp
    8000/tcp open  http-alt
    |_portrule: Port 8000 is open on 127.0.0.1

    Nmap done: 1 IP address (1 host up) scanned in 0.04 seconds
    ```

    Notice that although two ports were open, nmap only ran the action for port 8000.



### postrule()