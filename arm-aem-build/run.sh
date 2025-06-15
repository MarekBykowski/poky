#!/bin/bash

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
#pathadd ~/Downloads/Base_RevC_AEM_Fast_Models_11.26/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3
pathadd ~/Downloads/FVP_Base_RevC-2xAEMvA_11.29_27_Linux64/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9.3
echo $PATH

#../../meta-arm/scripts/runfvp --verbose ./tmp/deploy/images/fvp-base/core-image-base-fvp-base.fvpconf
#../../meta-arm/scripts/runfvp --verbose ./tmp/deploy/images/fvp-base/core-image-base-fvp-base.fvpconf2

if [[ $1 == armds ]]; then
	../../meta-arm/scripts/runfvp --verbose ./tmp/deploy/images/fvp-base/core-image-minimal-fvp-base.fvpconf -- --iris-server --iris-port 7101 --iris-allow-remote
else
	../../meta-arm/scripts/runfvp --verbose ./tmp/deploy/images/fvp-base/core-image-minimal-fvp-base.fvpconf
fi
