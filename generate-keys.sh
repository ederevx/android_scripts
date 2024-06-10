#!/bin/bash

# SPDX-FileCopyrightText: 2024 Edrick Sinsuan
# SPDX-License-Identifier: Apache-2.0

source setup_env

backup_certs() {
    if ! check_dir "$1"; then
        echo "USAGE: $0 ROM_PATH"
        exit 1
    fi

    if ! check_dir "$1/backup"; then
        mkdir "$1/backup"
    fi

    mv -f $1/*.pem $1/backup
    mv -f $1/*.pk8 $1/backup
}

if ! check_dir "$1"; then
    echo "USAGE: $0 ROM_PATH"
    exit 1
fi

ROM_PATH=$1

if ! check_dir "$ROM_PATH/vendor/lineage-priv"; then
    echo "The script assumes lineage-priv has been setup, set it up first!"
    exit 1
fi

if ! check_dir ~/.android-certs; then
    mkdir ~/.android-certs
else
    backup_certs ~/.android-certs
fi

subject='/C=US/ST=Florida/L=Tallahassee/O=Edrick Sinsuan/OU=Edrick Sinsuan/CN=Edrick Sinsuan/emailAddress=evcsinsuan@gmail.com'

for x in bluetooth cts_uicc_2021 media networkstack platform sdk_sandbox shared testkey releasekey; do
    $ROM_PATH/development/tools/make_key ~/.android-certs/$x "$subject"; \
done

# Backup all former keys
backup_certs $ROM_PATH/vendor/lineage-priv/keys

mv -f ~/.android-certs/*.pem $ROM_PATH/vendor/lineage-priv/keys
mv -f ~/.android-certs/*.pk8 $ROM_PATH/vendor/lineage-priv/keys