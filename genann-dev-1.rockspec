package = "genann"
version = "dev-1"
source = {
  url = "git://github.com/rokf/luajit-genann"
}
description = {
  summary = "LuaJIT Genann wrapper",
  homepage = "https://github.com/rokf/luajit-genann",
  maintainer = "Rok Fajfar <snewix7@gmail.com>",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1, < 5.2",
}
build = {
  type = "builtin",
  modules = {
    genann = "genann.lua"
  }
}
