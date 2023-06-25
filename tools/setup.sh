#! /bin/bash

set -e

SUDO=sudo
if [ $(id -u) -eq 0 ]; then
    SUDO=
fi
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# default: /var/lib/rancher/k3s/server/manifests
MANIFESTS_PATH=${MANIFESTS_PATH:-"/mnt/data1/k8s/k3s/server/manifests"}
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


find "$SCRIPTPATH" -maxdepth 1 ! -path . -print | while read path; do
	[[ -d $path ]] && [[ ! -f $path/$CHECKFILE ]] && continue
  dir=$(basename $path)
	echo "[$dir] Found helm chart CRD for k3s."
  $SUDO [ -d $MANIFESTS_PATH/$dir ] && $SUDO rm -r $MANIFESTS_PATH/$dir
  $SUDO cp -r $path $MANIFESTS_PATH/$dir
done
