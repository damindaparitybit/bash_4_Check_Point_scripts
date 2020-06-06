#!/bin/bash
#
# SCRIPT Show current VPN Client Operational Information
#
# (C) 2016-2020 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/bash_4_Check_Point_scripts
#
# ALL SCRIPTS ARE PROVIDED AS IS WITHOUT EXPRESS OR IMPLIED WARRANTY OF FUNCTION OR POTENTIAL FOR 
# DAMAGE Or ABUSE.  AUTHOR DOES NOT ACCEPT ANY RESPONSIBILITY FOR THE USE OF THESE SCRIPTS OR THE 
# RESULTS OF USING THESE SCRIPTS.  USING THESE SCRIPTS STIPULATES A CLEAR UNDERSTANDING OF RESPECTIVE
# TECHNOLOGIES AND UNDERLYING PROGRAMMING CONCEPTS AND STRUCTURES AND IMPLIES CORRECT IMPLEMENTATION
# OF RESPECTIVE BASELINE TECHNOLOGIES FOR PLATFORM UTILIZING THE SCRIPTS.  THIRD PARTY LIMITATIONS
# APPLY WITHIN THE SPECIFICS THEIR RESPECTIVE UTILIZATION AGREEMENTS AND LICENSES.  AUTHOR DOES NOT
# AUTHORIZE RESALE, LEASE, OR CHARGE FOR UTILIZATION OF THESE SCRIPTS BY ANY THIRD PARTY.
#
#
ScriptDate=2020-03-19
ScriptVersion=04.26.02
ScriptRevision=000
TemplateVersion=04.26.00
TemplateLevel=006
SubScriptsLevel=NA
SubScriptsVersion=NA
#

export BASHScriptVersion=v${ScriptVersion//./x}
export BASHScriptTemplateVersion=v${TemplateVersion//./x}
export BASHScriptTemplateLevel=$TemplateLevel.v$TemplateVersion

export BASHSubScriptsVersion=v${SubScriptsVersion//./x}
export BASHSubScriptTemplateVersion=v${TemplateVersion//./x}
export BASHExpectedSubScriptsVersion=$SubScriptsLevel.v${SubScriptsVersion//./x}

export BASHScriptFileNameRoot=vpn_client_operational_info
export BASHScriptShortName=vpn_client_ops_info
export BASHScriptnohupName=$BASHScriptShortName
export BASHScriptDescription=="Show current VPN Client Operational Information"

#export BASHScriptName=$BASHScriptFileNameRoot.$TemplateLevel.v$ScriptVersion
export BASHScriptName=$BASHScriptFileNameRoot.$TemplateLevel.v$ScriptVersion

export BASHScriptHelpFileName="$BASHScriptFileNameRoot.help"
export BASHScriptHelpFilePath="help.v$ScriptVersion"
export BASHScriptHelpFile="$BASHScriptHelpFilePath/$BASHScriptHelpFileName"

# _sub-scripts|_template|Common|Config|GAIA|GW|[GW.CORE]|Health_Check|MDM|MGMT|Patch_Hotfix|Session_Cleanup|SmartEvent|SMS|[SMS.CORE]|SMS.migrate_backup|UserConfig|[UserConfig.CORE_G2.NPM]
export BASHScriptsFolder=GW

export BASHScripttftptargetfolder="_template"


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
# Other variable configuration
# -------------------------------------------------------------------------------------------------


WAITTIME=20

export R8XRequired=false
export UseR8XAPI=false
export UseJSONJQ=true
export UseJSONJQ16=true
export JQ16Required=false


# -------------------------------------------------------------------------------------------------
# CheckAndUnlockGaiaDB - Check and Unlock Gaia database
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-31 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CheckAndUnlockGaiaDB () {
    #
    # CheckAndUnlockGaiaDB - Check and Unlock Gaia database
    #
    
    echo -n 'Unlock gaia database : '

    export gaiadbunlocked=false

    until $gaiadbunlocked ; do

        export checkgaiadblocked=`clish -i -c "lock database override" | grep -i "owned"`
        export isclishowned=`test -z $checkgaiadblocked; echo $?`

        if [ $isclishowned -eq 1 ]; then 
            echo -n '.'
            export gaiadbunlocked=false
        else
            echo -n '!'
            export gaiadbunlocked=true
        fi

    done

    echo; echo
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-31

#CheckAndUnlockGaiaDB

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Gaia Version
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-12-18 -

export checkR77version=`echo "${FWDIR}" | grep -i "R77"`
export checkifR77version=`test -z $checkR77version; echo $?`
if [ $checkifR77version -eq 1 ] ; then
    export isitR77version=true
else
    export isitR77version=false
fi
#echo $isitR77version

export checkR80version=`echo "${FWDIR}" | grep -i "R80"`
export checkifR80version=`test -z $checkR80version; echo $?`
if [ $checkifR80version -eq 1 ] ; then
    export isitR80version=true
else
    export isitR80version=false
fi
#echo $isitR80version

if $isitR77version; then
    echo "This is an R77.X version..."
    export UseR8XAPI=false
    export UseJSONJQ=false
    export UseJSONJQ16=false
elif $isitR80version; then
    echo "This is an R80.X version..."
    export UseR8XAPI=$UseR8XAPI
    export UseJSONJQ=$UseJSONJQ
    export UseJSONJQ16=$UseJSONJQ16
else
    echo "This is not an R77.X or R80.X version ????"
fi


# Removing dependency on clish to avoid collissions when database is locked
# And then finding out R77.30 and earlier don't work with that solution...

# MODIFIED 2019-01-18 -

if $isitR77version; then

    # This is an R77.X version...
    # We don't have the luxury of python get_platform.py script
    #
    export productversion=$(clish -i -c "show version product" | cut -d " " -f 6)

    # Keep the first string before next space in returned product version, since that could be owned 
    # if clish is owned elsewhere
    #
    export gaiaversion=$(echo $productversion | cut -d " " -f 1)

    # check if clish is owned and if it is, try a different alternative to get the version
    #
    export checkgaiaversion=`echo "${gaiaversion}" | grep -i "owned"`
    export isclishowned=`test -z $checkgaiaversion; echo $?`
    if [ $isclishowned -eq 1 ]; then 
        cpreleasefile=/etc/cp-release
        export gaiaversion=$(cat $cpreleasefile | cut -d " " -f 4)
    fi

elif $isitR80version; then

    # Requires that $JQ is properly defined in the script
    # so $UseJSONJQ = true must be set on template version 2.0.0 and higher
    #
    # Test string, use this to validate if there are problems:
    #
    #export pythonpath=$MDS_FWDIR/Python/bin/;echo $pythonpath;echo
    #$pythonpath/python --help
    #$pythonpath/python --version
    #

    export productversion=$(clish -i -c "show version product" | cut -d " " -f 6)

    # Keep the first string before next space in returned product version, since that could be owned 
    # if clish is owned elsewhere
    #
    export gaiaversion=$(echo $productversion | cut -d " " -f 1)

    # check if clish is owned and if it is, try a different alternative to get the version
    #
    export checkgaiaversion=`echo "${gaiaversion}" | grep -i "owned"`
    export isclishowned=`test -z $checkgaiaversion; echo $?`
    if [ $isclishowned -eq 1 ]; then 
        cpreleasefile=/etc/cp-release
        if [ -r $cpreleasefile ] ; then
            # OK we have the easy-button alternative
            export gaiaversion=$(cat $cpreleasefile | cut -d " " -f 4)
        else
            # OK that's not going to work without the file

            # Requires that $JQ is properly defined in the script
            # so $UseJSONJQ = true must be set on template version 0.32.0 and higher
            #
            export pythonpath=$MDS_FWDIR/Python/bin/
            if $UseJSONJQ ; then
                export get_platform_release=`$pythonpath/python $MDS_FWDIR/scripts/get_platform.py -f json | $JQ '. | .release'`
            else
                export get_platform_release=`$pythonpath/python $MDS_FWDIR/scripts/get_platform.py -f json | ${CPDIR_PATH}/jq/jq '. | .release'`
            fi
            
            export platform_release=${get_platform_release//\"/}
            export get_platform_release_version=`echo ${get_platform_release//\"/} | cut -d " " -f 4`
            export platform_release_version=${get_platform_release_version//\"/}
            
            export gaiaversion=$platform_release_version
        fi
    fi

else

    # This is not an R77.X or R80.X version ????
    # Maybe the R80.X approach works...
    
    # Requires that $JQ is properly defined in the script
    # so $UseJSONJQ = true must be set on template version 2.0.0 and higher
    #
    # Test string, use this to validate if there are problems:
    #
    #export pythonpath=$MDS_FWDIR/Python/bin/;echo $pythonpath;echo
    #$pythonpath/python --help
    #$pythonpath/python --version
    #

    export productversion=$(clish -i -c "show version product" | cut -d " " -f 6)

    # Keep the first string before next space in returned product version, since that could be owned 
    # if clish is owned elsewhere
    #
    export gaiaversion=$(echo $productversion | cut -d " " -f 1)

    # check if clish is owned and if it is, try a different alternative to get the version
    #
    export checkgaiaversion=`echo "${gaiaversion}" | grep -i "owned"`
    export isclishowned=`test -z $checkgaiaversion; echo $?`
    if [ $isclishowned -eq 1 ]; then 
        cpreleasefile=/etc/cp-release
        if [ -r $cpreleasefile ] ; then
            # OK we have the easy-button alternative
            export gaiaversion=$(cat $cpreleasefile | cut -d " " -f 4)
        else
            # OK that's not going to work without the file

            # Requires that $JQ is properly defined in the script
            # so $UseJSONJQ = true must be set on template version 0.32.0 and higher
            #
            export pythonpath=$MDS_FWDIR/Python/bin/
            if $UseJSONJQ ; then
                export get_platform_release=`$pythonpath/python $MDS_FWDIR/scripts/get_platform.py -f json | $JQ '. | .release'`
            else
                export get_platform_release=`$pythonpath/python $MDS_FWDIR/scripts/get_platform.py -f json | ${CPDIR_PATH}/jq/jq '. | .release'`
            fi
            
            export platform_release=${get_platform_release//\"/}
            export get_platform_release_version=`echo ${get_platform_release//\"/} | cut -d " " -f 4`
            export platform_release_version=${get_platform_release_version//\"/}
            
            export gaiaversion=$platform_release_version
        fi
    fi

fi


echo 'Gaia Version : $gaiaversion = '$gaiaversion
echo


# -------------------------------------------------------------------------------------------------
# Script Version Operations
# -------------------------------------------------------------------------------------------------


export toolsversion=$gaiaversion


# -------------------------------------------------------------------------------------------------
# Validate we are working on a system that handles this operation
# -------------------------------------------------------------------------------------------------


case "$gaiaversion" in
    R80 | R80.10 | R80.20.M1 | R80.20.M2 | R80.20 | R80.30 | R80.40 ) 
        export IsR8XVersion=true
        ;;
    *)
        export IsR8XVersion=false
        ;;
esac

if $R8XRequired && ! $IsR8XVersion; then
    # we expect to run on R8X versions, so this is not where we want to execute
    echo "System is running Gaia version '$gaiaversion', which is not supported!" | tee -a -i $logfilepath
    echo | tee -a -i $logfilepath
    echo "This script is not meant for versions prior to R80, exiting!" | tee -a -i $logfilepath
    echo | tee -a -i $logfilepath
    echo | tee -a -i $logfilepath
    echo 'Output location for all results is here : '$outputpathbase | tee -a -i $logfilepath
    echo 'Log results documented in this log file : '$logfilepath | tee -a -i $logfilepath
    echo | tee -a -i $logfilepath
    
    exit 255
fi


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# Start of Script Operations
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# local scripts variables configuration
# -------------------------------------------------------------------------------------------------


targetfolder=/var/log/__customer/upgrade_export


# -------------------------------------------------------------------------------------------------
# logfile configuration
# -------------------------------------------------------------------------------------------------


# setup initial log file for output logging
export logfilefolder=$targetfolder/dump/$DATEDTGS.$BASHScriptShortName
export logfilepath=$logfilefolder/$BASHScriptName.$DATEDTGS.log

if [ ! -w $logfilefolder ]; then
    mkdir -pv $logfilefolder
fi

touch $logfilepath


# -------------------------------------------------------------------------------------------------
# Script intro
# -------------------------------------------------------------------------------------------------


echo | tee -a -i $logfilepath
echo $BASHScriptDescription', script version '$ScriptVersion', revision '$ScriptRevision' from '$ScriptDate | tee -a -i $logfilepath
echo | tee -a -i $logfilepath

echo 'Date Time Group   :  '$DATEDTGS | tee -a -i $logfilepath
echo | tee -a -i $logfilepath


# -------------------------------------------------------------------------------------------------
# script plumbing 1
# -------------------------------------------------------------------------------------------------


#if $IsR8XVersion ; then
    # Do something because R8X
    
    #echo
#else
    # Do something else because not R8X
    
    #echo
#fi


export targetversion=$gaiaversion

export outputpathbase=$targetfolder/dump
export outputfilepath=$outputpathbase/$DATEDTGS.$BASHScriptShortName/
export outputfileprefix=$HOSTNAME'_'$targetversion
export outputfilesuffix='_'$DATEDTGS
export outputfiletype=.txt

if [ ! -r $outputfilepath ] ; then
    mkdir -pv $outputfilepath | tee -a -i $logfilepath
    chmod 775 $outputfilepath | tee -a -i $logfilepath
else
    chmod 775 $outputfilepath | tee -a -i $logfilepath
fi


export command2run=office_mode_users
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo >> "$logfilepath"
echo >> "$logfilepath"
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo ' - Execute Command    : '$command2run | tee -a -i $logfilepath
echo ' - Output File        : '$outputfilefqfn | tee -a -i $logfilepath
echo ' - Command            : fw tab -t om_assigned_ips -f' | tee -a -i $logfilepath
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo >> "$logfilepath"

fw tab -t om_assigned_ips -f &>> "$outputfilefqfn"

cat "$outputfilefqfn" | tee -a -i $logfilepath

echo >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo >> "$logfilepath"

export command2run=SNX_users
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo ' - Execute Command    : '$command2run | tee -a -i $logfilepath
echo ' - Output File        : '$outputfilefqfn | tee -a -i $logfilepath
echo ' - Command            : fw tab -t sslt_om_ip_params -f' | tee -a -i $logfilepath
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo >> "$logfilepath"

fw tab -t sslt_om_ip_params -f &>> "$outputfilefqfn"

cat "$outputfilefqfn" | tee -a -i $logfilepath

echo >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo >> "$logfilepath"

# number of remote access users (SecuRemote/SecureClient/Endpoint Connect/SNX)
# sk54641 - SNMP OID for the number Remote Access users (SR/SC/EPC/SNX) currently connected to a VPN-1 gateway
# https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk54641

export command2run=remote_access_vpn_users_all_clients_table
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo ' - Execute Command    : '$command2run | tee -a -i $logfilepath
echo ' - Output File        : '$outputfilefqfn | tee -a -i $logfilepath
echo ' - Command            : fw tab -t userc_users -f -u' | tee -a -i $logfilepath
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo >> "$logfilepath"

fw tab -t userc_users -f -u &>> "$outputfilefqfn"

cat "$outputfilefqfn" | tee -a -i $logfilepath

echo >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo >> "$logfilepath"

# number of remote access users (SecuRemote/SecureClient/Endpoint Connect/SNX)
# sk54641 - SNMP OID for the number Remote Access users (SR/SC/EPC/SNX) currently connected to a VPN-1 gateway
# https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk54641

export command2run=remote_access_vpn_users_all_clients
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo ' - Execute Command    : '$command2run | tee -a -i $logfilepath
echo ' - Output File        : '$outputfilefqfn | tee -a -i $logfilepath
echo ' - Command            : fw tab -t userc_users -s' | tee -a -i $logfilepath
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo >> "$logfilepath"

fw tab -t userc_users -s &>> "$outputfilefqfn"

cat "$outputfilefqfn" | tee -a -i $logfilepath

echo >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo >> "$logfilepath"

export command2run=L2TP_users
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo ' - Execute Command    : '$command2run | tee -a -i $logfilepath
echo ' - Output File        : '$outputfilefqfn | tee -a -i $logfilepath
echo ' - Command            : fw tab -t L2TP_tunnels -f' | tee -a -i $logfilepath
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo >> "$logfilepath"

fw tab -t L2TP_tunnels -f &>> "$outputfilefqfn"

cat "$outputfilefqfn" | tee -a -i $logfilepath

echo >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo >> "$logfilepath"

export command2run=MAB_users_connected_no_SNX
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo ' - Execute Command    : '$command2run | tee -a -i $logfilepath
echo ' - Output File        : '$outputfilefqfn | tee -a -i $logfilepath
echo ' - Command            : fw tab -t cvpn_session' | tee -a -i $logfilepath
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo >> "$logfilepath"

fw tab -t cvpn_session &>> "$outputfilefqfn"

cat "$outputfilefqfn" | tee -a -i $logfilepath

echo >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo >> "$logfilepath"

export command2run=Office_Mode_users_connected_in_Visitor_Mode
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo ' - Execute Command    : '$command2run | tee -a -i $logfilepath
echo ' - Output File        : '$outputfilefqfn | tee -a -i $logfilepath
echo ' - Command            : vpn show_tcpt' | tee -a -i $logfilepath
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo >> "$logfilepath"

vpn show_tcpt &>> "$outputfilefqfn"

cat "$outputfilefqfn" | tee -a -i $logfilepath

echo >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo '----------------------------------------------------------------------------' >> "$logfilepath"
echo >> "$logfilepath"


# -------------------------------------------------------------------------------------------------
# Closing operations and log file information
# -------------------------------------------------------------------------------------------------


if [ -r nul ] ; then
    rm nul >> $logfilepath
fi

if [ -r None ] ; then
    rm None >> $logfilepath
fi

echo | tee -a -i $logfilepath
echo 'List folder : '$logfilefolder | tee -a -i $logfilepath
ls -alh $logfilefolder | tee -a -i $logfilepath
echo | tee -a -i $logfilepath

echo | tee -a -i $logfilepath
echo 'Log File : '$logfilepath | tee -a -i $logfilepath
echo | tee -a -i $logfilepath


# -------------------------------------------------------------------------------------------------
# End of script Operations
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

echo
echo 'Script Completed, exiting...';echo