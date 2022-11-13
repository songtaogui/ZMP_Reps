#!/usr/bin/env bash
# Songtao Gui 2022/11/13

set -o nounset
set -o pipefail

function addpath() {
    echo $PATH | grep "${PWD}:" > /dev/null
    if [ $? -ne 0 ];then
        echo "export PATH=$PWD:\$PATH" >>~/.bashrc &&\
        source ~/.bashrc
    fi
}

# >>>>>>>>>>>>>>>>>>>>>>>> Load Common functions >>>>>>>>>>>>>>>>>>>>>>>>
export quiet=FALSE
export sdir=$PWD
source ${sdir}/dep/common.sh
if [ $? -ne 0 ];then 
    echo -e "\033[31m\033[7m[ERROR]\033[0m --> Cannot load common functions from easybash lib: ${sdir}/dep/common.sh" >&2
    exit 1;
fi
export verbose=TRUE
# <<<<<<<<<<<<<<<<<<<<<<<< Common functions <<<<<<<<<<<<<<<<<<<<<<<<

# install RepEx
gst_log "Install RepEx ..."
cd ${sdir}/dep/RepEx || exit 1
make all
if [ $? -ne 0 ];then gst_err "make RepEx failed: Non-zero exit"; exit 1;fi

# install GenericRepeatFinder
gst_log "Install GenericRepeatFinder ..."
cd ${sdir}/dep/GenericRepeatFinder/src || exit 1
make clean &&\
make -j 4
if [ $? -ne 0 ];then gst_err "make GenericRepeatFinder failed: Non-zero exit"; exit 1;fi

gst_log "Make sure you have seqkit installed ..."
check_sftw_path seqkit
gst_rcd "PASS"

# copy executables
gst_log "Make executables ..."
cd ${sdir}/bin || exit 1
cp ${sdir}/dep/RepEx/src/bin/{direct,gaps,identical,similar} ./ &&\
cp ${sdir}/dep/GenericRepeatFinder/bin/{grf-alignment,grf-alignment2,grf-dbn,grf-filter,grf-intersperse,grf-main,grf-mite-cluster,grf-nest,ltr_finder} ./ &&\
chmod 775 * &&\
addpath

if [ $? -ne 0 ];then gst_err "Make executables failed: Non-zero exit"; exit 1;fi

gst_log "Done! You can test for ZMP_Reps by running:
cd test && ZMP_Reps -i test.fa -o test_reps --verbose
"
