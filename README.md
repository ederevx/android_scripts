# Android Scripts
These are scripts that can be used to:
- Setup the build environment. (setup_env)
- Build a certain custom Android OS. (build_*)
- Build a QCOM or WSL2 custom kernel. (build_kernel)
- Generate and export Android keys. (export_keys and generate_keys)
- Patch android sources to support OnePlus 5/T with Linux kernel 4.14. (patch_rom)

## build_* scripts
Description: Build a certain custom Android OS.

Requirements:
- Needs to be called in the source's root directory.
	- e.g. `user@linux:~/repo/alpha$ ~/scripts/build_alpha`
- Check function `rom_copy_and_clean` in `setup_env`, the script will copy the output zip file towards `$SHARED_ROMS_DIR` defined in `setup_env`, make sure the directory exists and is writable.

Defaults:
- Check the script for the defaults as it varies per ROM.

Common Options:
- `-a`: Build all known types for all defined devices in the `devices_list` exported by `setup_env`.
- `-d $device`: Define for what device the source is to be built.
- `-t $type`: Build either `user`, `userdebug`, or `eng` build type.
- `-g`: Build with `WITH_GMS=true` or its equivalent.

## patch_rom script
Description: Patch android sources to support OnePlus 5/T with Linux kernel 4.14.

Requirements:
- Needs to be called in the source's root directory.
	- e.g. `user@linux:~/repo/alpha$ ~/scripts/patch_rom`

Defaults:
- It only applies the necessary patches for 4.14 by default.

Options:
- `-a`: Apply all patches.
- `-s`: Abort patches automatically if they don't apply cleanly.
- `-p $id`: Only apply the patch with `patch_id=$id`.

## export_keys script
Description: Export Android keys.

Requirements:
- Needs to be called with the source root directory passed as an argument.
	- e.g. `user@linux:~$ ~/scripts/export_keys alpha`

## generate_keys script
Description: Generate Android keys.

Requirements:
- Needs to be called with the source root directory passed as an argument.
	- e.g. `user@linux:~$ ~/scripts/generate_keys alpha`
- Requires `$VENDOR_PRIV_DIR=$1/vendor/lineage-priv` to be existent.

Defaults:
- Only copies newly generated keys but doesn't replace exiting ones.

Options:
- `-r`: Replace all existing keys in `$VENDOR_PRIV_DIR`.
