# Package

version     = "1.0.0"
author      = "Dennis Felsing; narimiran"
description = "Arbitrary-precision integers implemented in pure Nim"
license     = "MIT"

srcDir      = "src"

# Dependencies

requires "nim >= 1.4.0"

task test, "Test bigints":
  for backend in ["c", "cpp"]:
    echo "testing " & backend & " backend"
    for file in ["tbigints.nim", "tbugs.nim"]:
      exec "nim r --hints:off --backend:" & backend & " tests/" & file
