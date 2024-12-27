#!/bin/bash

oeqa_list() {
cat << 'EOF'
oe-test runtime --list-tests name /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases
oe-test runtime --list-tests name /yocto/yocto/poky/meta/lib/oeqa/runtime/cases
oe-test runtime --list-tests name /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases
oe-test runtime --list-tests class /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases
oe-test runtime --list-tests module /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases
EOF
}

oeqa_run() {
cat << 'EOF'
oe-test runtime --target-type simpleremote --target-ip 127.0.0.1:2223 --server-ip 127.0.0.1 --packages-manifest data/manifest --test-data-file data/testdata.json /yocto/yocto/poky/meta/lib/oeqa/runtime/cases --run-tests \
ping.PingTest.test_ping \
ssh.SSHTest.test_ssh
EOF
}
