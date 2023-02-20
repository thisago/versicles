# Package

version       = "0.2.0"
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
requires "util"
