#!/bin/bash

# SPDX-FileCopyrightText: 2017 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

source setup_env

if ! check_dir "$1" || ! cd "$1"; then
    echo "USAGE: $0 PATH"
    exit_timestamp 1
fi

for x in bluetooth media networkstack platform sdk_sandbox shared; do
    echo ${x}_key_release=\"$(openssl x509 -pubkey -noout -in $x.x509.pem | grep -v '-' | tr -d '\n')\"
    echo ${x}_cert_release=\"$(openssl x509 -outform der -in $x.x509.pem | xxd -p  | tr -d '\n')\"
done

border
echo release_key=\"$(openssl x509 -pubkey -noout -in releasekey.x509.pem | grep -v '-' | tr -d '\n')\"
echo release_cert=\"$(openssl x509 -outform der -in releasekey.x509.pem | xxd -p  | tr -d '\n')\"
border
echo test_key=\"$(openssl x509 -pubkey -noout -in testkey.x509.pem | grep -v '-' | tr -d '\n')\"
echo test_cert=\"$(openssl x509 -outform der -in testkey.x509.pem | xxd -p  | tr -d '\n')\"

exit_timestamp 0