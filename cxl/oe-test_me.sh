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

oeqa_sanity_test() {
cat << EOF
# First run this to check if you have connectivity to qemu b2b
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json /home/mbykowsx/yocto/meta-cxl/lib/oeqa/runtime/cases --run-tests demo2.DEMO2Test.test_method_ssh
EOF
}

oeqa_run() {
cat << EOF
### Run all sanity tests ###
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests sanity


### Run all cpdk tests from cpdk_2_tests module ##
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests cpdk_2_tests


### Run all BringUpTests from bringup_2_tests ###
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests bringup_2_tests


### See dependency ###
# ssh server must be there, otherwise we cannot ssh
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests dependency.DependencyTest1

# we require ssh server dropbear must be on there
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests dependency.DependencyTest2

# no ping ran before - tests fails dependency
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests dependency.DependencyTest3

# ping ran before - tests executed and passes
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests ping dependency.DependencyTest3

# if ndctl ver. != 88 skip the test
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests dependency.DependencyTest4
EOF
}

oeqa_run_details() {
cat << EOF
# Run all the tests from module 'demo2'
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests demo2

# Run a single test
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests demo2.DEMO2Test.test_method_ssh

# Run a number of tests
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests \
demo2.DEMO2Test.test_script_fail \
demo2.DEMO2Test.test_method_ssh

# Run all sanity tests
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests sanity

# Run all cpdk tests from cpdk_2_tests module
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests cpdk_2_tests

# Run all BringUpTests from bringup_2_tests
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests bringup_2_tests

# See dependency
# ssh server must be there, otherwise we cannot ssh
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests dependency.DependencyTest1

# we require ssh server dropbear must be on there
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests dependency.DependencyTest2

# no ping ran before - tests fails dependency
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests dependency.DependencyTest3

# ping ran before - tests executed and passes
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests ping dependency.DependencyTest3

# if ndctl ver. != 88 skip the test
oe-test runtime --target-type simpleremote --target-ip b2b:2222 --server-ip b2b --packages-manifest data/config/manifest --test-data-file data/config/testdata.json $metacxl_dir/lib/oeqa/runtime/cases --run-tests dependency.DependencyTest4
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

json_process() {
cat << EOF
python3 json2md1.py /home/mbykowsx/yocto/poky/cxl/data/runtime-results/testresults.json > results.md
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
echo -e "json_process"
