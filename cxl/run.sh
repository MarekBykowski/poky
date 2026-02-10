#!/bin/bash

exec runqemu slirp nographic 2>&1 | tee see
