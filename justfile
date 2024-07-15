set export
jj50 := "kprepublic/jj50"
bm40 := "kprepublic/bm40hsrgb/rev2"
annepro := "annepro2/c18"

default:
    @just --list

build KBD:
    cd src/vial-qmk; qmk compile -kb ${{KBD}} -km as

flash KBD:
    cd src/vial-qmk; qmk flash -kb {{KBD}} -km as

clean:
    cd src/vial-qmk; qmk clean
    rm -rf keyboards/$jj50/keymaps/as
    rm -rf keyboards/$bm40/keymaps/as
    rm -rf keyboards/annepro2/keymaps/as

prepare:
    #!/usr/bin/env sh
    keyboards=src/vial-qmk/keyboards
    [ -d src/vial-qmk ] || \
        (cd src; git clone https://github.com/vial-kb/vial-qmk.git; \
         cd vial-qmk; make git-submodules)
    cp -r keyboards/jj50/as ${keyboards}/${jj50}/keymaps
    cp -r keyboards/bm40/as ${keyboards}/${bm40}/keymaps
    cp -r keyboards/annepro/as ${keyboards}/annepro2/keymaps   
