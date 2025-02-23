#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

KRM_VERSION="v0.10.0"
KRM_OS=`uname -o`
KRM_ARCH=`uname -m`

KUSTOMIZE_KRM_ENVSUBST="$SCRIPT_DIR/bin/kustomize-krm-envsubst"

if [ -f $SCRIPT_DIR/bin/$KUSTOMIZE_KRM_ENVSUBST ]; then
  $SCRIPT_DIR/bin/$KUSTOMIZE_KRM_ENVSUBST $@
  curl \
    -Lo $SCRIPT_DIR/bin/krm_envsubst.tar.gz \
    https://github.com/logandavies181/kustomize-krm-envsubst/releases/download/${KRM_VERSION}/kustomize-krm-envsubst_${KRM_OS}_${KRM_ARCH}.tar.gz
  cd $SCRIPT_DIR/bin
  tar -xvf $SCRIPT_DIR/bin/krm_envsubst.tar.gz -C $SCRIPT_DIR/bin
fi

$KUSTOMIZE_KRM_ENVSUBST $@