#!/bin/bash
#
# SCRIPT Root Script Configuration Parameters
#
# (C) 2017-2018 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/bash_4_Check_Point_scripts
#
RootScriptTemplateLevel=005
RootScriptVersion=02.00.00
RootScriptDate=2018-11-20
#

RootScriptVersion=v02x00x00
RootScriptName=__root_script_config.v$RootScriptVersion
RootScriptShortName=__root_script_config
RootScriptDescription="Root Script Configuration Parameters"


# =============================================================================
# =============================================================================
# 
# =============================================================================

export DATE=`date +%Y-%m-%d-%H%M%Z`
export DATEDTG=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export DATEYMD=`date +%Y-%m-%d`

# points to where jq is installed
if [ -r ${CPDIR}/jq/jq ] ; then
    export JQ=${CPDIR}/jq/jq
elif [ -r ${CPDIR_PATH}/jq/jq ] ; then
    export JQ=${CPDIR_PATH}/jq/jq
elif [ -r ${MDS_CPDIR}/jq/jq ] ; then
    export JQ=${MDS_CPDIR}/jq/jq
#elif [ -r /opt/CPshrd-R80/jq/jq ] ; then
#    export JQ=/opt/CPshrd-R80/jq/jq
#elif [ -r /opt/CPshrd-R80.10/jq/jq ] ; then
#    export JQ=/opt/CPshrd-R80.10/jq/jq
#elif [ -r /opt/CPshrd-R80.20/jq/jq ] ; then
#    export JQ=/opt/CPshrd-R80.20/jq/jq
else
    export JQ=
fi

# WAITTIME in seconds for read -t commands
export WAITTIME=60

export customerpathroot=/var/log/__customer
export customerworkpathroot=$customerpathroot/upgrade_export
export outputpathroot=$customerworkpathroot
export dumppathroot=$customerworkpathroot/dump
export changelogpathroot=$customerworkpathroot/Change_Log



# =============================================================================
# =============================================================================
# 
# =============================================================================

# =============================================================================
# =============================================================================
