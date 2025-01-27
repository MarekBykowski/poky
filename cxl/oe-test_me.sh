#!/bin/bash

oeqa_list() {
cat << 'EOF'
oe-test runtime --list-tests module /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases
oe-test runtime --list-tests class /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases
oe-test runtime --list-tests name /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases
oe-test runtime --list-tests name /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases /yocto/yocto/poky/meta/lib/oeqa/runtime/cases
EOF
}

oeqa_run() {
cat << 'EOF'
echo ### Test QEMU ###
# Run a group of tests
oe-test runtime --target-type simpleremote --target-ip 127.0.0.1:2223 --server-ip 127.0.0.1 --packages-manifest data/config/manifest --test-data-file data/config/testdata.json /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases --run-tests demo1
# Run a single test
oe-test runtime --target-type simpleremote --target-ip 127.0.0.1:2223 --server-ip 127.0.0.1 --packages-manifest data/config/manifest --test-data-file data/config/testdata.json /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases --run-tests demo2.DEMO2Test.test_script_fail
# Run a list of tests
oe-test runtime --target-type simpleremote --target-ip 127.0.0.1:2223 --server-ip 127.0.0.1 --packages-manifest data/config/manifest --test-data-file data/config/testdata.json /yocto/yocto/meta-cxl/lib/oeqa/runtime/cases --run-tests \
demo2.DEMO2Test.test_script_fail \
demo2.DEMO2Test.test_method_ssh
EOF
}

oeqa_run_core() {
cat << 'EOF'
echo ### Test QEMU ###
oe-test runtime --target-type simpleremote --target-ip 127.0.0.1:2223 --server-ip 127.0.0.1 --packages-manifest data/manifest --test-data-file data/testdata.json /yocto/yocto/poky/meta/lib/oeqa/runtime/cases --run-tests \
ping.PingTest.test_ping \
ssh.SSHTest.test_ssh
EOF
}

echo -e "oeqa_list\noeqa_run"
