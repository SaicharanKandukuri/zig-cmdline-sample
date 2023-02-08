#!/bin/bash

if command -v zig > /dev/null; then
    echo "=> zig is installed"
else
    echo "=> zig is not installed"
    exit 1
fi

echo "=> Starting test"
echo "=> zig version: $(zig version)"

echo "=> [1/3] --help"
zig build run -- --help

echo "=> [2/3] --version"
zig build run -- --version

echo "=> [3/3] --print-args (print every argument without doing anything)"
zig build run -- --print-args Yoooooooooooooooo It works
