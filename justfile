set export
jj50 := "kprepublic/jj50"
bm40 := "kprepublic/bm40hsrgb/rev2"
annepro := "annepro2/c18"
id75 := "idobao/id75/v2"

default:
    @just --list

build KBD QMK="vial":
    cd {{QMK}} && qmk compile -kb ${{KBD}} -km as

flash KBD KM="vial":
    if [ {{KM}} = vial ]; then (cd vial; qmk flash -kb ${{KBD}} -km as-{{KM}}); fi
    if [ {{KM}} = via ]; then (cd qmk; qmk flash -kb ${{KBD}} -km as-{{KM}}); fi

clean:
    stow -D -d {{justfile_directory()}}/src -t {{justfile_directory()}}/vial .

prepare:
    #!/usr/bin/env sh
    git submodule update --init --recursive --recommend-shallow
    git config submodule.qmk.ignore all
    git config submodule.vial.ignore all

    # generate keymap.c
    for k in src/keyboards/*/as*/json-keymap.json
    do (cd qmk # qmk needs to be run from a qmk directory...
        qmk json2c ../$k > ../$(dirname $k)/json-keymap.c) 
    done

    # copy keyboard code
    stow -R -d {{justfile_directory()}}/src -t {{justfile_directory()}}/vial .
