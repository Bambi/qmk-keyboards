set export
jj50 := "kprepublic/jj50"
bm40 := "kprepublic/bm40hsrgb/rev2"
annepro := "annepro2/c18"
id75 := "idobao/id75/v2"

default:
    @just --list

build KBD KM="vial":
    if [ {{KM}} = vial ]; then (cd src/vial; qmk compile -kb ${{KBD}} -km as-{{KM}}); fi
    if [ {{KM}} = via ]; then (cd src/qmk; qmk compile -kb ${{KBD}} -km as-{{KM}}); fi

flash KBD KM="vial":
    if [ {{KM}} = vial ]; then (cd src/vial; qmk flash -kb ${{KBD}} -km as-{{KM}}); fi
    if [ {{KM}} = via ]; then (cd src/qmk; qmk flash -kb ${{KBD}} -km as-{{KM}}); fi

clean:
    #!/usr/bin/env sh
    for f in vial src/qmk
    do (cd $f; qmk clean
        rm -rf keyboards/$jj50/keymaps/as*
        rm -rf keyboards/$bm40/keymaps/as*
        rm -rf keyboards/annepro2/keymaps/as*
        rm -rf keyboards/idobao/id75/keymaps/as*)
    done

prepare:
    #!/usr/bin/env sh
    git submodule update --init --recursive --recommend-shallow

    # generate keymap.c
    for k in keyboards/*/as*/json-keymap.json
    do (cd qmk # qmk needs to be run from a qmk directory...
        qmk json2c ../$k > ../$(dirname $k)/json-keymap.c) 
    done

    # copy keyboard code
    for f in vial src/qmk
    do (cp -r keyboards/jj50/as* ${f}/keyboards/${jj50}/keymaps
        cp -r keyboards/bm40/as* ${f}/keyboards/${bm40}/keymaps
        cp -r keyboards/annepro/as* ${f}/keyboards/annepro2/keymaps
        cp -r keyboards/id75/as* ${f}/keyboards/idobao/id75/keymaps)
    done
