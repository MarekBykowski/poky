#!/bin/bash 

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
pathadd ~/Downloads/Base_RevC_AEM_Fast_Models_11.26/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3
echo $PATH
../../meta-arm/scripts/runfvp --verbose ./tmp/deploy/images/fvp-base/core-image-base-fvp-base.fvpconf
#../../meta-arm/scripts/runfvp --verbose ./tmp/deploy/images/fvp-base/core-image-base-fvp-base.fvpconf2
