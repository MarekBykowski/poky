#!/bin/bash

metacxl_dir=~/yocto/meta-cxl
poky_dir=~/yocto/poky

oeqa_list() {
cat << EOF
oe-test runtime --list-tests module $metacxl_dir/lib/oeqa/runtime/cases
oe-test runtime --list-tests class $metacxl_dir/lib/oeqa/runtime/cases
oe-test runtime --list-tests name $metacxl_dir/lib/oeqa/runtime/cases
oe-test runtime --list-tests module $poky_dir/meta/lib/oeqa/runtime/cases
oe-test runtime --list-tests class $poky_dir/meta/lib/oeqa/runtime/cases
oe-test runtime --list-tests name $poky_dir/meta/lib/oeqa/runtime/cases
oe-test runtime --list-tests name $metacxl_dir/lib/oeqa/runtime/cases $poky_dir/meta/lib/oeqa/runtime/cases
EOF
}

oeqa_run() {
cat << EOF
echo ### Test QEMU ###
# Run all the tests from module 'demo2'
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests demo2
# Run a single test
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests demo2.DEMO2Test.test_method_ssh
# Run a number of tests
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests \
demo2.DEMO2Test.test_script_fail \
demo2.DEMO2Test.test_method_ssh
EOF
}

oeqa_run_core() {
cat << EOF
echo ### Test QEMU ###
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $poky_dir/meta/lib/oeqa/runtime/cases --run-tests \
ping.PingTest.test_ping \
ssh.SSHTest.test_ssh
EOF
}

misc() {
cat << EOF
meta-cxl: $metacxl_dir/lib/oeqa/runtime/cases
oe-core: $poky_dir/meta/lib/oeqa/runtime/cases
full help at: oe-test runtime --help
EOF
}

echo -e "oeqa_list\noeqa_run\noeqa_run_core"
echo -e "misc"
