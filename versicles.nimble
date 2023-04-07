# Package

version       = "0.8.1"
author        = "Thiago Navarro"
description   = "Lib and CLI tool to manipulate biblical verses!"
license       = "MIT"
srcDir        = "src"
bin           = @["versicles"]

binDir = "build"
installExt = @["nim"]


# Dependencies

requires "nim >= 1.6.4"

requires "cligen"
requires "util >= 2.0.0"
requires "bibleTools >= 1.2.0"
