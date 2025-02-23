#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

KRM_OS=`uname -o`
KRM_ARCH=`uname -m`

KUSTOMIZE_KRM_ENVSUBST="./kustomize-krm-envsubst-${KRM_OS}-${KRM_ARCH}"

$SCRIPT_DIR/bin/$KUSTOMIZE_KRM_ENVSUBST $@