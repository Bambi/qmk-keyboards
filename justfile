set export
jj50 := "kprepublic/jj50"
bm40 := "kprepublic/bm40hsrgb/rev2"
annepro := "annepro2/c18"
id75 := "idobao/id75/v2"

default:
    @just --list

ball:
    # build all targets
    just build jj50
    just build jj50 qmk
    just build bm40 qmk

build KBD QMK="vial":
    cd {{QMK}} && qmk compile -kb ${{KBD}} -km as

flash KBD KM="vial":
    if [ {{KM}} = vial ]; then (cd vial; qmk flash -kb ${{KBD}} -km as-{{KM}}); fi
    if [ {{KM}} = via ]; then (cd qmk; qmk flash -kb ${{KBD}} -km as-{{KM}}); fi

install:
    # copy keyboard code
    stow -R -d {{justfile_directory()}}/src-qmk -t {{justfile_directory()}}/qmk .
    stow -R -d {{justfile_directory()}}/src-vial -t {{justfile_directory()}}/vial .

uninstall:
    stow -D -d {{justfile_directory()}}/src-qmk -t {{justfile_directory()}}/qmk .
    stow -D -d {{justfile_directory()}}/src-vial -t {{justfile_directory()}}/vial .

prepare:
    #!/usr/bin/env sh
    git submodule update --init --recursive --recommend-shallow
    git config submodule.qmk.ignore all
    git config submodule.vial.ignore all

    # generate keymap.c
    genkmap () {
        qmkdir=$1
        shift
        for k in "$@"
        do (cd "$qmkdir" # qmk needs to be run from a qmk directory...
            qmk json2c ../$k > ../$(dirname $k)/json-keymap.c) 
        done
    }
    genkmap qmk src-qmk/keyboards/*/as/json-keymap.json
    genkmap vial src-vial/keyboards/*/as/json-keymap.json

    just install
