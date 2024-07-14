default:
    @just --list

build KBD:
    cd src/vial-qmk; qmk compile -kb as/{{KBD}} -km vial

flash KBD:
    cd src/vial-qmk; qmk flash -kb as/{{KBD}} -km vial

prepare:
    [ -d src/vial-qmk ] || \
        (cd src; git clone https://github.com/vial-kb/vial-qmk.git; \
         cd vial-qmk; make git-submodules; mkdir keyboards/as)

    cp -r keyboards/* src/vial-qmk/keyboards/as
    
