#!/bin/bash
#
# SCRIPT for BASH to remove zero locks sessions on MDM
#
# (C) 2017-2018 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/bash_4_Check_Point_scripts
#
ScriptVersion=00.05.00
ScriptDate=2018-06-30
#

export BASHScriptVersion=v00x05x00

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START: Basic Configuration
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Date variable configuration
# -------------------------------------------------------------------------------------------------

export DATE=`date +%Y-%m-%d-%H%M%Z`
export DATEDTG=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export DATEYMD=`date +%Y-%m-%d`

echo 'Date Time Group   :  '$DATE $DATEDTG $DATEDTGS
echo 'Date (YYYY-MM-DD) :  '$DATEYMD
echo
    

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# JQ and json related
# -------------------------------------------------------------------------------------------------

# points to where jq is installed
export JQ=${CPDIR}/jq/jq
    
# -------------------------------------------------------------------------------------------------
# END:  Basic Configuration
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START: Root Script Configuration
# -------------------------------------------------------------------------------------------------

export scriptspathroot=/var/log/__customer/upgrade_export/scripts
export rootscriptconfigfile=__root_script_config.sh


# -------------------------------------------------------------------------------------------------
# localrootscriptconfiguration - Local Root Script Configuration setup
# -------------------------------------------------------------------------------------------------

localrootscriptconfiguration () {
    #
    # Local Root Script Configuration setup
    #

    # WAITTIME in seconds for read -t commands
    export WAITTIME=60
    
    export customerpathroot=/var/log/__customer
    export customerworkpathroot=$customerpathroot/upgrade_export
    export outputpathroot=$customerworkpathroot/dump
    export changelogpathroot=$customerworkpathroot/Change_Log
    
    echo
    return 0
}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

if [ -r "$scriptspathroot/$rootscriptconfigfile" ] ; then
    # Found the Root Script Configuration File in the folder for scripts
    # So let's call that script to configure what we need

    . $scriptspathroot/$rootscriptconfigfile "$@"
    errorreturn=$?
elif [ -r "../$rootscriptconfigfile" ] ; then
    # Found the Root Script Configuration File in the folder above the executiong script
    # So let's call that script to configure what we need

    . ../$rootscriptconfigfile "$@"
    errorreturn=$?
elif [ -r "$rootscriptconfigfile" ] ; then
    # Found the Root Script Configuration File in the folder with the executiong script
    # So let's call that script to configure what we need

    . $rootscriptconfigfile "$@"
    errorreturn=$?
else
    # Did not the Root Script Configuration File
    # So let's call local configuration

    localrootscriptconfiguration "$@"
    errorreturn=$?
fi


# -------------------------------------------------------------------------------------------------
# END:  Root Script Configuration
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


#export outputpathbase=$outputpathroot/$DATE
export outputpathbase=$outputpathroot/$DATEDTGS
#export outputpathbase=$outputpathroot/$DATEYMD

if [ ! -r $outputpathroot ] 
then
    mkdir $outputpathroot
fi
if [ ! -r $outputpathbase ] 
then
    mkdir $outputpathbase
fi

echo 'Created folder :  '$outputpathbase
echo
ls -al $outputpathbase
echo

deletefile=$outputpathbase/sessions_to_delete_uid.$DATEDTGS.csv
dumpfile=$outputpathbase/delete_session.$DATEDTGS.json

echo 'Management CLI Login'

export sessionfile=$outputpathbase/id.txt

#mgmt_cli login -r true --port 4434 domain 'System Data' > $sessionfile
mgmt_cli login -r true "$@" > $sessionfile
cat $sessionfile
echo

echo 'Show zero locks sessions'
echo

echo 'All sessions' >> $dumpfile
echo >> $dumpfile
echo '.uid, .locks, .changes, .expired-session, username' >> $dumpfile
mgmt_cli -r true -s $sessionfile show sessions details-level full --format json | jq -r '.objects[] | (.uid + ", " + (.locks|tostring) + ", " + (.changes|tostring) + ", " + (."expired-session"|tostring) + ", " + ."user-name")' >> $dumpfile
echo >> $dumpfile

echo 'Zero locks sessions' >> $dumpfile
echo >> $dumpfile
echo '.uid, .locks, .changes, .expired-session, username' >> $dumpfile
mgmt_cli -r true -s $sessionfile show sessions details-level full --format json | jq -r '.objects[] | select((.locks==0) and (.changes==0) and (."expired-session"==true)) | (.uid + ", " + (.locks|tostring) + ", " + (.changes|tostring) + ", " + (."expired-session"|tostring) + ", " + ."user-name")' >> $dumpfile
echo >> $dumpfile

cat $dumpfile

echo
echo 'Management CLI Logout and Clean-up'

mgmt_cli logout -s $sessionfile
rm $sessionfile

echo
ls -al $outputpathbase
echo
