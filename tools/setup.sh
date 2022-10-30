#! /bin/bash

set -e

SUDO=sudo
if [ $(id -u) -eq 0 ]; then
    SUDO=
fi

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

MANIFESTS_PATH=${MANIFESTS_PATH:-"/var/lib/rancher/k3s/server/manifests"}
CHECKFILE=".k3sauto"

find "$SCRIPTPATH" -maxdepth 1 -type d ! -path . -print | while read path; do
	if [[ ! -f $path/$CHECKFILE ]]; then
		continue
	fi
    dir=$(basename $path)
	echo "[$dir] Found helm chart CRD for k3s."
    $SUDO mkdir -p $MANIFESTS_PATH/$dir
    (cd $path && $SUDO find . -type f ! -path ./$CHECKFILE -exec ln -f $path/{} $MANIFESTS_PATH/$dir/{} \;)
done
