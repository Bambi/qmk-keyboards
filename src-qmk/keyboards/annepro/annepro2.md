# Anne Pro QMK Configuration

## Références
Doc here: https://openannepro.github.io/install/
https://levelup.gitconnected.com/how-anne-pro-2-powered-by-qmk-changed-my-workflow-even-further-82390b9a9422

## Compilation
qmk compile -kb annepro2/c18 -km default-layer-indicators
# put keyboard into DFU/IAP mode: trun on with Esc pressed
../AnnePro2-Tools/target/release/annepro2_tools annepro2_c18_default-layer-indicators.bin

## Compilation Shine (RGB)
make C18
# put keyboard into DFU/IAP mode
../AnnePro2-Tools/target/release/annepro2_tools --boot -t led build/annepro2-shine-C18.bin

