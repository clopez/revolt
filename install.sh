#! /bin/bash
#
# install.sh
# Copyright (C) 2016-2017 Adrian Perez <aperez@igalia.com>
#
# Distributed under terms of the GPLv3 license.
#
set -e
shopt -s nullglob

declare -r APP_ID='org.perezdecastro.Slavolt'

source "$(dirname "$0")/install-functions.sh"
install-setup "$0" "$@"

install-bin bin/slavolt
install-desktop-file "${APP_ID}.desktop"
install-prefixed share/slavolt "${APP_ID}.gresource" -m644
install-prefixed share/appdata "${APP_ID}.appdata.xml" -m644

install-glib-gschema "${APP_ID}.gschema.xml"
for file in ./[0-9][0-9]_${APP_ID}.gschema.override ; do
	install-glib-gschema "${file}"
done

for file in slavolt/*.py ; do
	install-prefixed share/slavolt/py/slavolt "${file}" -m644
done

for size in 16x16 16x16@2x 24x24 24x24@2x 32x32 64x64 ; do
	install-icon "${APP_ID}" "${size}" apps "icons/${size}/apps/slavolt.png"
done
install-icon "${APP_ID}" scalable apps icons/scalable/apps/slavolt.svg
install-icon "${APP_ID}" symbolic apps icons/scalable/apps/slavolt-symbolic.svg
install-icon "${APP_ID}-status-blink-symbolic" scalable status icons/scalable/status/slavolt-status-blink-symbolic.svg
install-icon "${APP_ID}-status-online-symbolic" scalable status icons/scalable/status/slavolt-status-online-symbolic.svg

install-finish
