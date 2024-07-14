default:
    @just --list

build KBD:
    cd src/vial-qmk; qmk compile -kb as/{{KBD}} -km vial

flash KBD:
    cd src/vial-qmk; qmk flash -kb as/{{KBD}} -km vial

clean:
    cd src/vial-qmk; qmk clean; rm -rf keyboards/as

prepare:
    #!/usr/bin/env bash
    shopt -s extglob
    keyboards=src/vial-qmk/keyboards
    [ -d src/vial-qmk ] || \
        (cd src; git clone https://github.com/vial-kb/vial-qmk.git; \
         cd vial-qmk; make git-submodules)

    [ -d ${keyboards}/as ] || mkdir ${keyboards}/as
    cp -r keyboards/* ${keyboards}/as
    mkdir ${keyboards}/as/bm40/rev2
    cp ${keyboards}/kprepublic/bm40hsrgb/rev2/!(keymaps) ${keyboards}/as/bm40/rev2
    
