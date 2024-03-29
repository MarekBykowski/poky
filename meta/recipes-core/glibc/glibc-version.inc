SRCBRANCH ?= "release/2.38/master"
PV = "2.38+git"
SRCREV_glibc ?= "44f757a6364a546359809d48c76b3debd26e77d4"
SRCREV_localedef ?= "e0eca29583b9e0f62645c4316ced93cf4e4e26e1"

GLIBC_GIT_URI ?= "git://sourceware.org/git/glibc.git;protocol=https"

UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+\.\d+(\.(?!90)\d+)*)"

CVE_STATUS[CVE-2023-4527] = "fixed-version: Fixed in stable branch updates"
CVE_STATUS[CVE-2023-4911] = "fixed-version: Fixed in stable branch updates"
CVE_STATUS[CVE-2023-4806] = "fixed-version: Fixed in stable branch updates"
CVE_STATUS[CVE-2023-4527] = "fixed-version: Fixed in stable branch updates"
