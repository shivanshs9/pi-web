#! /bin/bash

set -e

SUDO=sudo
if [ $(id -u) -eq 0 ]; then
    SUDO=
fi
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

MANIFESTS_PATH=${MANIFESTS_PATH:-"/var/lib/rancher/k3s/server/manifests"}
CHECKFILE=".k3sauto"

CLEANUP=0
while [[ $# -gt 0 ]]; do
  case $1 in
    -c|--cleanup)
      CLEANUP=1
      shift # past argument
      ;;
  esac
done


find "$SCRIPTPATH" -maxdepth 1 -type d ! -path . -print | while read path; do
	[[ ! -f $path/$CHECKFILE ]] && continue
    dir=$(basename $path)
	echo "[$dir] Found helm chart CRD for k3s."
    [[ -d $MANIFESTS_PATH/$dir ]] && $SUDO rm -r $MANIFESTS_PATH/$dir
    $SUDO mkdir -p $MANIFESTS_PATH/$dir
    (cd $path && $SUDO find . -type f ! -path ./$CHECKFILE -exec ln -f $path/{} $MANIFESTS_PATH/$dir/{} \;)
done
