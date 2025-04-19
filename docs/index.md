# Nmap Script Tutorial

These docs give a brief intro to writing [nmap](https://nmap.org/) scripts.

The nmap guide already has documenation on this, namely its chapter on the [Nmap Scripting Engine](https://nmap.org/book/nse.html). In fact, much of these docs are taken straight from there. However, the nmap guide is a bit old and lacks some helpful navigation features that could enhance its readability.

The goal of these docs are to provide a faster quickstart guide to those looking to create lua scripts to extend nmap's functionality.

## Prerequisites

- Familitary with nmap.
- Very basic knowledge of the lua programming language.
    - See [here](https://www.lua.org/pil/1.html) for an intro to lua.
- These docs are written with the assumption that you are using a linux system; some info may not apply to other platforms.