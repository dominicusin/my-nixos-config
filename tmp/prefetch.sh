#!/bin/sh

nix-prefetch-url --type sha256 file:///root/nix/jdk-8u151-linux-x64.tar.gz
nix-prefetch-url --type sha256 file:///root/nix/linuxx64-13.7.0.10276927.tar.gz
nix-prefetch-url --type sha256 file:///root/nix/sqldeveloper-17.3.1.279.0537-no-jre.zip
nix-prefetch-url --type sha256 file:///root/nix/sqldeveloper-4.1.1.19.59-no-jre.zip

