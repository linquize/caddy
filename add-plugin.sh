#!/bin/sh
if [ -z "$1" ]; then
	echo "import path cannot be empty" 1>&2
	exit 1
fi

PLUGIN_GO=caddy/caddymain/plugin.go
if [ ! -f "$PLUGIN_GO" ]; then
	echo "package caddymain\n" > "$PLUGIN_GO"
fi

echo "adding $1" 1>&2
go get "$1" && \
	echo import _ \""$1"\" >> "$PLUGIN_GO"
