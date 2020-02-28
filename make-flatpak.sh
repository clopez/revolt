#! /bin/bash
set -e

readonly BUILDDIR="$(dirname "$0")/.flatpak-build"
readonly REPODIR="$(dirname "$0")/.flatpak-repo"

cleanup () {
	rm -rf "${BUILDDIR}"
}
trap cleanup EXIT

declare -a buildargs=(
	--sandbox
	--force-clean
	--require-changes
	--repo="${REPODIR}"
	--subject="Slavolt $(date +%Y%m%d).$(git describe --always --tags)"
)

declare -a updaterepoargs=(
	--title=Slavolt
	--default-branch=master
	--prune
)

if [[ -n ${EMAIL} ]] ; then
	buildargs+=( --gpg-sign="${EMAIL}" )
	updaterepoargs+=( --gpg-sign="${EMAIL}" )
fi

set -x
flatpak-builder "${buildargs[@]}" "${BUILDDIR}" "$@" org.perezdecastro.Slavolt.json
flatpak build-update-repo "${updaterepoargs[@]}" "${REPODIR}"
