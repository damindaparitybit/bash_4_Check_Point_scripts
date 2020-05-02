#!/bin/bash
#
# SCRIPT Configure script link files and copy versioned scripts to generics
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
ScriptDate=2020-03-23
ScriptVersion=04.26.03
ScriptRevision=000
TemplateVersion=04.26.00
TemplateLevel=006
SubScriptsLevel=006
SubScriptsVersion=04.07.00
#

export BASHScriptVersion=v${ScriptVersion//./x}
export BASHScriptTemplateVersion=v${TemplateVersion//./x}
export BASHScriptTemplateLevel=$TemplateLevel.v$TemplateVersion

export BASHSubScriptsVersion=v${SubScriptsVersion//./x}
export BASHSubScriptTemplateVersion=v${TemplateVersion//./x}
export BASHExpectedSubScriptsVersion=$SubScriptsLevel.v${SubScriptsVersion//./x}

export BASHScriptFileNameRoot=generate_script_links
export BASHScriptShortName="generate_links"
export BASHScriptnohupName=$BASHScriptShortName
export BASHScriptDescription=="Generate Script Links"

#export BASHScriptName=$BASHScriptFileNameRoot.$TemplateLevel.v$ScriptVersion
export BASHScriptName=$BASHScriptFileNameRoot.v$ScriptVersion

export BASHScriptHelpFileName="$BASHScriptFileNameRoot.help"
export BASHScriptHelpFilePath="help.v$ScriptVersion"
export BASHScriptHelpFile="$BASHScriptHelpFilePath/$BASHScriptHelpFileName"

# _sub-scripts|_template|Common|Config|GAIA|GW|[GW.CORE]|Health_Check|MDM|MGMT|Patch_Hotfix|Session_Cleanup|SmartEvent|SMS|[SMS.CORE]|SMS.migrate_backup|UserConfig|[UserConfig.CORE_G2.NPM]
export BASHScriptsFolder=.

export BASHScripttftptargetfolder="_template"


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START: Root Configuration
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Date variable configuration
# -------------------------------------------------------------------------------------------------

export DATE=`date +%Y-%m-%d-%H%M%Z`
export DATEDTG=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export DATEYMD=`date +%Y-%m-%d`


# -------------------------------------------------------------------------------------------------
# Script key folders and files variable configuration
# -------------------------------------------------------------------------------------------------

export scriptspathroot=/var/log/__customer/upgrade_export/scripts
export subscriptsfolder=_sub-scripts

export rootscriptconfigfile=__root_script_config.sh


# -------------------------------------------------------------------------------------------------
# Script Operations Control variable configuration
# -------------------------------------------------------------------------------------------------

export WAITTIME=60

export R8XRequired=false
export UseR8XAPI=false
export UseJSONJQ=true
export UseJSONJQ16=true
export JQ16Required=false

# setup initial log file for output logging
export logfilepath=/var/tmp/$BASHScriptName.$DATEDTGS.log
touch $logfilepath

# Configure output file folder target
# One of these needs to be set to true, just one
#
export OutputToRoot=false
export OutputToDump=true
export OutputToChangeLog=false
export OutputToOther=false
#
# if OutputToOther is true, then this next value needs to be set
#
export OtherOutputFolder=Specify_The_Folder_Here

# if we are date-time stamping the output location as a subfolder of the 
# output folder set this to true,  otherwise it needs to be false
#
export OutputDTGSSubfolder=true
export OutputSubfolderScriptName=false
export OutputSubfolderScriptShortName=true

export notthispath=/home/
export startpathroot=.

export localdotpath=`echo $PWD`
export currentlocalpath=$localdotpath
export workingpath=$currentlocalpath

export UseGaiaVersionAndInstallation=true
export ShowGaiaVersionResults=true
export KeepGaiaVersionResultsFile=false

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# Configure basic information for formation of file path for command line parameter handler script
#
# cli_script_cmdlineparm_handler_root - root path to command line parameter handler script
# cli_script_cmdlineparm_handler_folder - folder for under root path to command line parameter handler script
# cli_script_cmdlineparm_handler_file - filename, without path, for command line parameter handler script
#
export cli_script_cmdlineparm_handler_root=$scriptspathroot
export cli_script_cmdlineparm_handler_folder=$subscriptsfolder
export cli_script_cmdlineparm_handler_file=cmd_line_parameters_handler.sub-script.$SubScriptsLevel.v$SubScriptsVersion.sh


# Configure basic information for formation of file path for configure script output paths and folders handler script
#
# script_output_paths_and_folders_handler_root - root path to configure script output paths and folders handler script
# script_output_paths_and_folders_handler_folder - folder for under root path to configure script output paths and folders handler script
# script_output_paths_and_folders_handler_file - filename, without path, for configure script output paths and folders handler script
#
export script_output_paths_and_folders_handler_root=$scriptspathroot
export script_output_paths_and_folders_handler_folder=$subscriptsfolder
export script_output_paths_and_folders_handler_file=script_output_paths_and_folders.sub-script.$SubScriptsLevel.v$SubScriptsVersion.sh


# Configure basic information for formation of file path for gaia version and type handler script
#
# gaia_version_type_handler_root - root path to gaia version and type handler script
# gaia_version_type_handler_folder - folder for under root path to gaia version and type handler script
# gaia_version_type_handler_file - filename, without path, for gaia version and type handler script
#
export gaia_version_type_handler_root=$scriptspathroot
export gaia_version_type_handler_folder=$subscriptsfolder
export gaia_version_type_handler_file=gaia_version_installation_type.sub-script.$SubScriptsLevel.v$SubScriptsVersion.sh


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# MODIFIED 2019-01-30 -

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


# -------------------------------------------------------------------------------------------------
# END:  Root Configuration
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# =================================================================================================
# START:  Command Line Parameter Handling and Help
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-01-05 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#


#
# Standard Scripts and R8X API Scripts Command Line Parameters
#
# -? | --help
# -v | --verbose
# -P <web-ssl-port> | --port <web-ssl-port> | -P=<web-ssl-port> | --port=<web-ssl-port>
# -r | --root
# -u <admin_name> | --user <admin_name> | -u=<admin_name> | --user=<admin_name>
# -p <password> | --password <password> | -p=<password> | --password=<password>
# -m <server_IP> | --management <server_IP> | -m=<server_IP> | --management=<server_IP>
# -d <domain> | --domain <domain> | -d=<domain> | --domain=<domain>
# -s <session_file_filepath> | --session-file <session_file_filepath> | -s=<session_file_filepath> | --session-file=<session_file_filepath>
# -l <log_path> | --log-path <log_path> | -l=<log_path> | --log-path=<log_path>'
#
# -o <output_path> | --output <output_path> | -o=<output_path> | --output=<output_path> 
#
# --NOWAIT
#
# --NOSTART
# --RESTART
#
# --NOHUP
# --NOHUP-Script <NOHUP_SCRIPT_NAME> | --NOHUP-Script=<NOHUP_SCRIPT_NAME>
#

export SHOWHELP=false
# MODIFIED 2018-09-29 -
#export CLIparm_websslport=443
export CLIparm_websslport=
export CLIparm_rootuser=false
export CLIparm_user=
export CLIparm_password=
export CLIparm_mgmt=
export CLIparm_domain=
export CLIparm_sessionidfile=
export CLIparm_logpath=

export CLIparm_outputpath=

export CLIparm_NOWAIT=

# --NOWAIT
#
if [ -z "$NOWAIT" ]; then
    # NOWAIT mode not set from shell level
    export CLIparm_NOWAIT=false
elif [ x"`echo "$NOWAIT" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NOWAIT mode set OFF from shell level
    export CLIparm_NOWAIT=false
elif [ x"`echo "$NOWAIT" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NOWAIT mode set ON from shell level
    export CLIparm_NOWAIT=true
else
    # NOWAIT mode set to wrong value from shell level
    export CLIparm_NOWAIT=false
fi

export CLIparm_NOSTART=false

# --NOSTART
#
if [ -z "$NOSTART" ]; then
    # NOSTART mode not set from shell level
    export CLIparm_NOSTART=false
elif [ x"`echo "$NOSTART" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NOSTART mode set OFF from shell level
    export CLIparm_NOSTART=false
elif [ x"`echo "$NOSTART" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NOSTART mode set ON from shell level
    export CLIparm_NOSTART=true
else
    # NOSTART mode set to wrong value from shell level
    export CLIparm_NOSTART=false
fi

export CLIparm_NOHUP=false
export CLIparm_NOHUPScriptName=

export REMAINS=

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-01-05

# -------------------------------------------------------------------------------------------------
# Define local command line parameter CLIparm values
# -------------------------------------------------------------------------------------------------

#export CLIparm_local1=

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# processcliremains - Local command line parameter processor
# -------------------------------------------------------------------------------------------------

processcliremains () {
    #
    
    # -------------------------------------------------------------------------------------------------
    # Process command line parameters from the REMAINS returned from the standard handler
    # -------------------------------------------------------------------------------------------------
    
    while [ -n "$1" ]; do
        # Copy so we can modify it (can't modify $1)
        OPT="$1"
    
        # testing
        echo 'OPT = '$OPT
        #
            
        # Detect argument termination
        if [ x"$OPT" = x"--" ]; then
            
            shift
            for OPT ; do
                # MODIFIED 2019-03-08
                #LOCALREMAINS="$LOCALREMAINS \"$OPT\""
                LOCALREMAINS="$LOCALREMAINS $OPT"
            done
            break
        fi
        # Parse current opt
        while [ x"$OPT" != x"-" ] ; do
            case "$OPT" in
                # Help and Standard Operations
                '-?' | --help )
                    SHOWHELP=true
                    ;;
                # Handle --flag=value opts like this
                -q=* | --qlocal1=* )
                    CLIparm_local1="${OPT#*=}"
                    #shift
                    ;;
                # and --flag value opts like this
                -q* | --qlocal1 )
                    CLIparm_local1="$2"
                    shift
                    ;;
                # Anything unknown is recorded for later
                * )
                    # MODIFIED 2019-03-08
                    #LOCALREMAINS="$LOCALREMAINS \"$OPT\""
                    LOCALREMAINS="$LOCALREMAINS $OPT"
                    break
                    ;;
            esac
            # Check for multiple short options
            # NOTICE: be sure to update this pattern to match valid options
            # Remove any characters matching "-", and then the values between []'s
            #NEXTOPT="${OPT#-[upmdsor?]}" # try removing single short opt
            NEXTOPT="${OPT#-[vrf?]}" # try removing single short opt
            if [ x"$OPT" != x"$NEXTOPT" ] ; then
                OPT="-$NEXTOPT"  # multiple short opts, keep going
            else
                break  # long form, exit inner loop
            fi
        done
        # Done with that param. move to next
        shift
    done
    # Set the non-parameters back into the positional parameters ($1 $2 ..)
    eval set -- $LOCALREMAINS
    
    export CLIparm_local1=$CLIparm_local1

}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# dumpcliparmparselocalresults
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-03-08 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumpcliparmparselocalresults () {

	#
	# Testing - Dump acquired local values
	#
    #
    workoutputfile=/var/tmp/workoutputfile.2.$DATEDTGS.txt
    echo > $workoutputfile

    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo 'Local CLI Parameters :' >> $workoutputfile
    echo >> $workoutputfile

    #echo 'CLIparm_local1          = '$CLIparm_local1 >> $workoutputfile
    #echo 'CLIparm_local2          = '$CLIparm_local2 >> $workoutputfile
    echo  >> $workoutputfile
    echo 'LOCALREMAINS            = '$LOCALREMAINS >> $workoutputfile
    
	if [ x"$SCRIPTVERBOSE" = x"true" ] ; then
	    # Verbose mode ON
	    
	    echo | tee -a -i $logfilepath
	    cat $workoutputfile | tee -a -i $logfilepath
	    echo | tee -a -i $logfilepath
	    for i ; do echo - $i | tee -a -i $logfilepath ; done
	    echo | tee -a -i $logfilepath
	    echo CLI parms - number "$#" parms "$@" | tee -a -i $logfilepath
	    echo | tee -a -i $logfilepath
        
        if [ "$NOWAIT" != "true" ] ; then
            read -t $WAITTIME -n 1 -p "Any key to continue.  Automatic continue after $WAITTIME seconds : " anykey
            echo
        fi
        
        echo | tee -a -i $logfilepath
        echo "End of local execution" | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath

    else
	    # Verbose mode OFF
	    
	    echo >> $logfilepath
	    cat $workoutputfile >> $logfilepath
	    echo >> $logfilepath
	    for i ; do echo - $i >> $logfilepath ; done
	    echo >> $logfilepath
	    echo CLI parms - number "$#" parms "$@" >> $logfilepath
	    echo >> $logfilepath
        
	fi

    rm $workoutputfile
}


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2019-03-08


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# End:  Local Command Line Parameter Handling and Help Configuration and Local Handling
# =================================================================================================
# =================================================================================================


#==================================================================================================
#==================================================================================================
#==================================================================================================
# Start of template 
#==================================================================================================
#==================================================================================================


# =================================================================================================
# =================================================================================================
# START:  Command Line Parameter Handling and Help
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# dumprawcliremains
# -------------------------------------------------------------------------------------------------

dumprawcliremains () {
    #
	if [ x"$SCRIPTVERBOSE" = x"true" ] ; then
	    # Verbose mode ON
	    
        echo | tee -a -i $logfilepath
        echo "Command line parameters remains : " | tee -a -i $logfilepath
        echo "Number parms $#" | tee -a -i $logfilepath
        echo "remains raw : \> $@ \<" | tee -a -i $logfilepath

        parmnum=0
        for k ; do
            echo -e "$parmnum \t ${k}" | tee -a -i $logfilepath
            parmnum=`expr $parmnum + 1`
        done

        echo | tee -a -i $logfilepath
        
    else
	    # Verbose mode OFF
	    
        echo >> $logfilepath
        echo "Command line parameters remains : " >> $logfilepath
        echo "Number parms $#" >> $logfilepath
        echo "remains raw : \> $@ \<" >> $logfilepath

        parmnum=0
        for k ; do
            echo -e "$parmnum \t ${k}" >> $logfilepath
            parmnum=`expr $parmnum + 1`
        done

        echo >> $logfilepath
        
	fi

}


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# CommandLineParameterHandler - Command Line Parameter Handler calling routine
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-10-03 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CommandLineParameterHandler () {
    #
    # CommandLineParameterHandler - Command Line Parameter Handler calling routine
    #
    
    # -------------------------------------------------------------------------------------------------
    # Check Command Line Parameter Handlerr action script exists
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2018-10-03 -
    
    export cli_script_cmdlineparm_handler_path=$cli_script_cmdlineparm_handler_root/$cli_script_cmdlineparm_handler_folder
    
    export cli_script_cmdlineparm_handler=$cli_script_cmdlineparm_handler_path/$cli_script_cmdlineparm_handler_file
    
    # Check that we can finde the command line parameter handler file
    #
    if [ ! -r $cli_script_cmdlineparm_handler ] ; then
        # no file found, that is a problem
        if [ "$SCRIPTVERBOSE" = "true" ] ; then
            echo | tee -a -i $logfilepath
            echo 'Command Line Parameter handler script file missing' | tee -a -i $logfilepath
            echo '  File not found : '$cli_script_cmdlineparm_handler | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo 'Other parameter elements : ' | tee -a -i $logfilepath
            echo '  Root of folder path : '$cli_script_cmdlineparm_handler_root | tee -a -i $logfilepath
            echo '  Folder in Root path : '$cli_script_cmdlineparm_handler_folder | tee -a -i $logfilepath
            echo '  Folder Root path    : '$cli_script_cmdlineparm_handler_path | tee -a -i $logfilepath
            echo '  Script Filename     : '$cli_script_cmdlineparm_handler_file | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo 'Critical Error - Exiting Script !!!!' | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo "Log output in file $logfilepath" | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
        else
            echo | tee -a -i $logfilepath
            echo 'Command Line Parameter handler script file missing' | tee -a -i $logfilepath
            echo '  File not found : '$cli_script_cmdlineparm_handler | tee -a -i $logfilepath
            echo 'Critical Error - Exiting Script !!!!' | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo "Log output in file $logfilepath" | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
        fi
    
        exit 251
    fi
    
    # -------------------------------------------------------------------------------------------------
    # Call Command Line Parameter Handlerr action script exists
    # -------------------------------------------------------------------------------------------------
    
    if [ "$SCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $logfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        echo "Calling external Command Line Paramenter Handling Script" | tee -a -i $logfilepath
        echo " - External Script : "$cli_script_cmdlineparm_handler | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
    fi
    
    . $cli_script_cmdlineparm_handler "$@"
    
    if [ "$SCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $logfilepath
        echo "Returned from external Command Line Paramenter Handling Script" | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        
        if [ "$NOWAIT" != "true" ] ; then
            read -t $WAITTIME -n 1 -p "Any key to continue.  Automatic continue after $WAITTIME seconds : " anykey
            echo
        fi
        
        echo | tee -a -i $logfilepath
        echo "Starting local execution" | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
    fi
    
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-10-03

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Call command line parameter handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-10-03 -
    
CommandLineParameterHandler "$@"

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Handle locally defined command line parameters
# -------------------------------------------------------------------------------------------------

# Check if we have left over parameters that might be handled locally
#
if [ -n "$REMAINS" ]; then
     
    dumprawcliremains $REMAINS

    processcliremains $REMAINS
    
    # MODIFIED 2019-03-08

    dumpcliparmparselocalresults $REMAINS
fi


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# =================================================================================================
# END:  Command Line Parameter Handling and Help
# =================================================================================================
# =================================================================================================


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START: Root Procedures
# -------------------------------------------------------------------------------------------------


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
# GetScriptSourceFolder - Get the actual source folder for the running script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-11-20 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetScriptSourceFolder () {
    #
    # repeated procedure description
    #

    echo >> $logfilepath

    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        TARGET="$(readlink "$SOURCE")"
        if [[ $TARGET == /* ]]; then
            echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'" >> $logfilepath
            SOURCE="$TARGET"
        else
            DIR="$( dirname "$SOURCE" )"
            echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')" >> $logfilepath
            SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
        fi
    done

    echo "SOURCE is '$SOURCE'" >> $logfilepath

    RDIR="$( dirname "$SOURCE" )"
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    if [ "$DIR" != "$RDIR" ]; then
        echo "DIR '$RDIR' resolves to '$DIR'" >> $logfilepath
    fi
    echo "DIR is '$DIR'" >> $logfilepath
    
    export ScriptSourceFolder=$DIR

    echo >> $logfilepath
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-11-20


# -------------------------------------------------------------------------------------------------
# ConfigureJQforJSON - Configure JQ variable value for JSON parsing
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-01-03 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

ConfigureJQforJSON () {
    #
    # Configure JQ variable value for JSON parsing
    #
    # variable JQ points to where jq is installed
    #
    # Apparently MDM, MDS, and Domains don't agree on who sets CPDIR, so better to check!

    #export JQ=${CPDIR}/jq/jq

    export JQNotFound=false

    # points to where jq is installed
    if [ -r ${CPDIR}/jq/jq ] ; then
        export JQ=${CPDIR}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
    elif [ -r ${CPDIR_PATH}/jq/jq ] ; then
        export JQ=${CPDIR_PATH}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
    elif [ -r ${MDS_CPDIR}/jq/jq ] ; then
        export JQ=${MDS_CPDIR}/jq/jq
        export JQNotFound=false
        export UseJSONJQ=true
    else
        export JQ=
        export JQNotFound=true
        export UseJSONJQ=false

        if $UseR8XAPI ; then
            # to use the R8X API, JQ is required!
            echo "Missing jq, not found in ${CPDIR}/jq/jq, ${CPDIR_PATH}/jq/jq, or ${MDS_CPDIR}/jq/jq !" | tee -a -i $logfilepath
            echo 'Critical Error - Exiting Script !!!!' | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo "Log output in file $logfilepath" | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            exit 1
        fi
    fi
    
    # JQ16 points to where jq 1.6 is installed, which is not generally part of Gaia, even R80.40EA (2020-01-20)
    export JQ16NotFound=true
    export UseJSONJQ16=false
    
    # As of template version v04.21.00 we also added jq version 1.6 to the mix and it lives in the customer path root /tools/JQ folder by default
    export JQ16PATH=$customerpathroot/_tools/JQ
    export JQ16FILE=jq-linux64
    export JQ16FQFN=$JQ16PATH$JQ16FILE

    if [ -r $JQ16FQFN ] ; then
        # OK we have the easy-button alternative
        export JQ16=$JQ16FQFN
        export JQ16NotFound=false
        export UseJSONJQ16=true
    elif [ -r "./_tools/JQ/$JQ16FILE" ] ; then
        # OK we have the local folder alternative
        export JQ16=./_tools/JQ/$JQ16FILE
        export JQ16NotFound=false
        export UseJSONJQ16=true
    elif [ -r "../_tools/JQ/$JQ16FILE" ] ; then
        # OK we have the parent folder alternative
        export JQ16=../_tools/JQ/$JQ16FILE
        export JQ16NotFound=false
        export UseJSONJQ16=true
    else
        export JQ16=
        export JQ16NotFound=true
        export UseJSONJQ16=false
        
        if $UseR8XAPI ; then
            if $JQ16Required ; then
                # to use the R8X API, JQ is required!
                echo 'Missing jq version 1.6, not found in '$JQ16FQFN', '"./_tools/JQ/$JQ16FILE"', or '"../_tools/JQ/$JQ16FILE"' !' | tee -a -i $logfilepath
                echo 'Critical Error - Exiting Script !!!!' | tee -a -i $logfilepath
                echo | tee -a -i $logfilepath
                echo "Log output in file $logfilepath" | tee -a -i $logfilepath
                echo | tee -a -i $logfilepath
                exit 1
            else
                echo 'Missing jq version 1.6, not found in '$JQ16FQFN', '"./_tools/JQ/$JQ16FILE"', or '"../_tools/JQ/$JQ16FILE"' !' | tee -a -i $logfilepath
                echo 'However it is not required for this operation' | tee -a -i $logfilepath
                echo | tee -a -i $logfilepath
            fi
        fi
    fi
    
    return 0
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-01-03

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# SetScriptOutputPathsAndFolders - Setup and call configure script output paths and folders handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-30 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

SetScriptOutputPathsAndFolders () {
    #
    # Setup and call configure script output paths and folders handler action script
    #
    
    export script_output_paths_and_folders_handler_path=$script_output_paths_and_folders_handler_root/$script_output_paths_and_folders_handler_folder
    
    export script_output_paths_and_folders_handler=$script_output_paths_and_folders_handler_path/$script_output_paths_and_folders_handler_file
    
    # -------------------------------------------------------------------------------------------------
    # Check output paths and folders handler action script exists
    # -------------------------------------------------------------------------------------------------
    
    # Check that we can finde the output paths and folders handler action script file
    #
    if [ ! -r $script_output_paths_and_folders_handler ] ; then
        # no file found, that is a problem
        if [ "$SCRIPTVERBOSE" = "true" ] ; then
            echo | tee -a -i $logfilepath
            echo 'output paths and folders handler action script file missing' | tee -a -i $logfilepath
            echo '  File not found : '$script_output_paths_and_folders_handler | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo 'Other parameter elements : ' | tee -a -i $logfilepath
            echo '  Root of folder path : '$script_output_paths_and_folders_handler_root | tee -a -i $logfilepath
            echo '  Folder in Root path : '$script_output_paths_and_folders_handler_folder | tee -a -i $logfilepath
            echo '  Folder Root path    : '$script_output_paths_and_folders_handler_path | tee -a -i $logfilepath
            echo '  Script Filename     : '$script_output_paths_and_folders_handler_file | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo 'Critical Error - Exiting Script !!!!' | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo "Log output in file $logfilepath" | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
        else
            echo | tee -a -i $logfilepath
            echo 'output paths and folders handler action script file missing' | tee -a -i $logfilepath
            echo '  File not found : '$script_output_paths_and_folders_handler | tee -a -i $logfilepath
            echo 'Critical Error - Exiting Script !!!!' | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo "Log output in file $logfilepath" | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
        fi
    
        exit 251
    fi
    
    # -------------------------------------------------------------------------------------------------
    # Call output paths and folders handler action script
    # -------------------------------------------------------------------------------------------------
    
    #
    # output paths and folders handler action script calling routine
    #
    
    if [ "$SCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $logfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        echo "Calling external Configure script output paths and folders Handling Script" | tee -a -i $logfilepath
        echo " - External Script : "$script_output_paths_and_folders_handler | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
    fi
    
    . $script_output_paths_and_folders_handler "$@"
    
    if [ "$SCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $logfilepath
        echo "Returned from external Configure script output paths and folders Handling Script" | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        
        if [ "$NOWAIT" != "true" ] ; then
            read -t $WAITTIME -n 1 -p "Any key to continue.  Automatic continue after $WAITTIME seconds : " anykey
            echo
        fi
        
        echo | tee -a -i $logfilepath
        echo "Continueing local execution" | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
    fi
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-30

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# GetGaiaVersionAndInstallationType - Setup and call gaia version and type handler action script
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-10-03 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

GetGaiaVersionAndInstallationType () {
    #
    # Setup and call gaia version and type handler action script
    #
    
    export gaia_version_type_handler_path=$gaia_version_type_handler_root/$gaia_version_type_handler_folder
    
    export gaia_version_type_handler=$gaia_version_type_handler_path/$gaia_version_type_handler_file
    
    # -------------------------------------------------------------------------------------------------
    # Check gaia version and type handler action script exists
    # -------------------------------------------------------------------------------------------------
    
    # Check that we can finde the gaia version and type handler file
    #
    if [ ! -r $gaia_version_type_handler ] ; then
        # no file found, that is a problem
        if [ "$SCRIPTVERBOSE" = "true" ] ; then
            echo | tee -a -i $logfilepath
            echo 'gaia version and type handler script file missing' | tee -a -i $logfilepath
            echo '  File not found : '$gaia_version_type_handler | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo 'Other parameter elements : ' | tee -a -i $logfilepath
            echo '  Root of folder path : '$gaia_version_type_handler_root | tee -a -i $logfilepath
            echo '  Folder in Root path : '$gaia_version_type_handler_folder | tee -a -i $logfilepath
            echo '  Folder Root path    : '$gaia_version_type_handler_path | tee -a -i $logfilepath
            echo '  Script Filename     : '$gaia_version_type_handler_file | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo 'Critical Error - Exiting Script !!!!' | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo "Log output in file $logfilepath" | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
        else
            echo | tee -a -i $logfilepath
            echo 'gaia version and type handler script file missing' | tee -a -i $logfilepath
            echo '  File not found : '$gaia_version_type_handler | tee -a -i $logfilepath
            echo 'Critical Error - Exiting Script !!!!' | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
            echo "Log output in file $logfilepath" | tee -a -i $logfilepath
            echo | tee -a -i $logfilepath
        fi
    
        exit 251
    fi
    
    # -------------------------------------------------------------------------------------------------
    # Call gaia version and type handler action script
    # -------------------------------------------------------------------------------------------------
    
    #
    # gaia version and type handler calling routine
    #
    
    if [ "$SCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $logfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        echo "Calling external Gaia Version and Installation Type Handling Script" | tee -a -i $logfilepath
        echo " - External Script : "$gaia_version_type_handler | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
    fi
    
    . $gaia_version_type_handler "$@"
    
    if [ "$SCRIPTVERBOSE" = "true" ] ; then
        echo | tee -a -i $logfilepath
        echo "Returned from external Gaia Version and Installation Type Handling Script" | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        
        if [ "$NOWAIT" != "true" ] ; then
            read -t $WAITTIME -n 1 -p "Any key to continue.  Automatic continue after $WAITTIME seconds : " anykey
            echo
        fi
        
        echo | tee -a -i $logfilepath
        echo "Continueing local execution" | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
        echo '--------------------------------------------------------------------------' | tee -a -i $logfilepath
        echo | tee -a -i $logfilepath
    fi
    
    # -------------------------------------------------------------------------------------------------
    # Handle results from gaia version and type handler action script locally
    # -------------------------------------------------------------------------------------------------
    
    if $ShowGaiaVersionResults ; then
        # show the results of this operation on the screen, not just the log file
        cat $gaiaversionoutputfile | tee -a -i $gaiaversionoutputfile
        echo | tee -a -i $gaiaversionoutputfile
    else
        # only log the results of this operation
        cat $gaiaversionoutputfile >> $logfilepath
        echo >> $logfilepath
    fi

    # now remove the working file
    if ! $KeepGaiaVersionResultsFile ; then
        # not keeping version results file
        rm $gaiaversionoutputfile
    fi

    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-10-03

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# END:  Root Procedures
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------
# START: Root Operations
# -------------------------------------------------------------------------------------------------


echo | tee -a -i $logfilepath
echo $BASHScriptDescription', script version '$ScriptVersion', revision '$ScriptRevision' from '$ScriptDate | tee -a -i $logfilepath
echo | tee -a -i $logfilepath

echo 'Date Time Group   :  '$DATEDTGS | tee -a -i $logfilepath
echo | tee -a -i $logfilepath


# -------------------------------------------------------------------------------------------------
# Script Source Folder
# -------------------------------------------------------------------------------------------------

# We need the Script's actual source folder to find subscripts
#
GetScriptSourceFolder


# -------------------------------------------------------------------------------------------------
# JQ and json related
# -------------------------------------------------------------------------------------------------

# MODIFIED 2020-01-03 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if $UseJSONJQ || UseJSONJQ16; then 
    ConfigureJQforJSON
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2020-01-03


#----------------------------------------------------------------------------------------
# Gaia version and installation type identification
#----------------------------------------------------------------------------------------

if $UseGaiaVersionAndInstallation ; then
    GetGaiaVersionAndInstallationType "$@"
fi


# -------------------------------------------------------------------------------------------------
# Configure script output paths and folders
# -------------------------------------------------------------------------------------------------

SetScriptOutputPathsAndFolders "$@" 


# -------------------------------------------------------------------------------------------------
# END:  Root Operations
# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


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


#==================================================================================================
#==================================================================================================
# End of template 
#==================================================================================================
#==================================================================================================
#==================================================================================================


#----------------------------------------------------------------------------------------
# Setup Basic Parameters
#----------------------------------------------------------------------------------------


#==================================================================================================
#==================================================================================================
#
# shell meat
#
#==================================================================================================
#==================================================================================================


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#
# Scripts link generation and setup
#
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------


export workingroot=$customerworkpathroot
export workingbase=$workingroot/scripts
export linksbase=$workingbase/.links


if [ ! -r $workingbase ] ; then
    echo | tee -a -i $logfilepath
    echo Error! | tee -a -i $logfilepath
    echo Missing folder $workingbase | tee -a -i $logfilepath
    echo | tee -a -i $logfilepath
    echo Exiting! | tee -a -i $logfilepath
    echo | tee -a -i $logfilepath
    exit 255
else
    chmod 775 $workingbase | tee -a -i $logfilepath
fi


if [ ! -r $linksbase ] ; then
    mkdir -pv $linksbase | tee -a -i $logfilepath
    chmod 775 $linksbase | tee -a -i $logfilepath
else
    chmod 775 $linksbase | tee -a -i $logfilepath
fi

if [ -r $workingbase/updatescripts.sh ] ; then
    chmod 775 $workingbase/updatescripts.sh | tee -a -i $logfilepath
    cp $workingbase/updatescripts.sh $workingroot | tee -a -i $logfilepath
fi




# =============================================================================
# =============================================================================
# FOLDER:  Common
# =============================================================================


export workingdir=Common
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_common_001=determine_gaia_version_and_installation_type.v04.26.00.sh
file_common_002=do_script_nohup.v04.26.00.sh

file_common_003=go_dump_folder_now.v04.26.00.sh
file_common_004=go_dump_folder_now_dtg.v04.26.00.sh
file_common_005=go_change_log_folder_now_dtg.v04.26.00.sh

file_common_006=make_dump_folder_now.v04.26.00.sh
file_common_007=make_dump_folder_now_dtg.v04.26.00.sh

ln -sf $sourcefolder/$file_common_001 $linksfolder/gaia_version_type
ln -sf $sourcefolder/$file_common_001 $workingroot/gaia_version_type

ln -sf $sourcefolder/$file_common_002 $linksfolder/do_script_nohup
ln -sf $sourcefolder/$file_common_002 $workingroot/do_script_nohup

ln -sf $sourcefolder/$file_common_003 $linksfolder/godump
ln -sf $sourcefolder/$file_common_004 $linksfolder/godtgdump
ln -sf $sourcefolder/$file_common_005 $linksfolder/goChangeLog

ln -sf $sourcefolder/$file_common_006 $linksfolder/mkdump
ln -sf $sourcefolder/$file_common_007 $linksfolder/mkdtgdump

#
# These have been replaced with alias commands
#
#ln -sf $sourcefolder/$file_common_003 $workingroot/godump
#ln -sf $sourcefolder/$file_common_004 $workingroot/godtgdump
#ln -sf $sourcefolder/$file_common_005 $workingroot/goChangeLog

#ln -sf $sourcefolder/$file_common_006 $workingroot/mkdump
#ln -sf $sourcefolder/$file_common_007 $workingroot/mkdtgdump


# =============================================================================
# =============================================================================
# FOLDER:  Config
# =============================================================================


export workingdir=Config
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_config_001=config_capture.v04.26.00.sh
file_config_002=show_interface_information.v04.26.00.sh
file_config_003=EPM_config_check.v04.26.00.sh

ln -sf $sourcefolder/$file_config_001 $linksfolder/config_capture
ln -sf $sourcefolder/$file_config_002 $linksfolder/interface_info

ln -sf $sourcefolder/$file_config_001 $workingroot/config_capture
ln -sf $sourcefolder/$file_config_002 $workingroot/interface_info

if [ $Check4EPM -gt 0 ]; then

    ln -sf $sourcefolder/$file_config_003 $linksfolder/EPM_config_check

    ln -sf $sourcefolder/$file_config_003 $workingroot/EPM_config_check

fi


# =============================================================================
# =============================================================================
# FOLDER:  GAIA
# =============================================================================


export workingdir=GAIA
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_GAIA_001=update_gaia_rest_api.sh
file_GAIA_002=update_gaia_dynamic_cli.sh


ln -sf $sourcefolder/$file_GAIA_001 $linksfolder/update_gaia_rest_api
ln -sf $sourcefolder/$file_GAIA_002 $linksfolder/update_gaia_dynamic_cli

if $IsR8XVersion ; then
    
    ln -sf $sourcefolder/$file_GAIA_001 $workingroot/update_gaia_rest_api
    ln -sf $sourcefolder/$file_GAIA_002 $workingroot/update_gaia_dynamic_cli
    
fi


# =============================================================================
# =============================================================================
# FOLDER:  GW
# =============================================================================


export workingdir=GW
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_GW_001=watch_accel_stats.v04.26.00.sh
file_GW_002=set_informative_logging_implied_rules_on_R8x.v04.26.00.sh
file_GW_003=reset_hit_count_with_backup.v04.26.00.sh
file_GW_004=show_clusterXL_information.v04.26.00.sh
file_GW_005=watch_cluster_status.v04.26.00.sh
file_GW_006=enable_rad_admin_stats.v00.01.00.sh
file_GW_007=vpn_client_operational_info.v04.26.02.sh
file_GW_008=vpn_client_operational_info.standalone.v04.26.02.sh
file_GW_009=fix_gw_missing_updatable_objects.v04.26.02.sh

ln -sf $sourcefolder/$file_GW_001 $linksfolder/watch_accel_stats
ln -sf $sourcefolder/$file_GW_002 $linksfolder/set_informative_logging_implied_rules_on_R8x
ln -sf $sourcefolder/$file_GW_003 $linksfolder/reset_hit_count_with_backup
ln -sf $sourcefolder/$file_GW_004 $linksfolder/cluster_info
ln -sf $sourcefolder/$file_GW_005 $linksfolder/watch_cluster_status
ln -sf $sourcefolder/$file_GW_006 $linksfolder/enable_rad_admin_stats_and_cpview
ln -sf $sourcefolder/$file_GW_007 $linksfolder/vpn_client_operational_info
ln -sf $sourcefolder/$file_GW_008 $linksfolder/vpn_client_operational_info.standalone
ln -sf $sourcefolder/$file_GW_009 $linksfolder/fix_gw_missing_updatable_objects


if [ "$sys_type_GW" == "true" ]; then
    
    ln -sf $sourcefolder/$file_GW_001 $workingroot/watch_accel_stats
    ln -sf $sourcefolder/$file_GW_002 $workingroot/set_informative_logging_implied_rules_on_R8x
    ln -sf $sourcefolder/$file_GW_003 $workingroot/reset_hit_count_with_backup
    
    if [[ $(cpconfig <<< 10 | grep cluster) == *"Disable"* ]]; then
        # is a cluster
        ln -sf $sourcefolder/$file_GW_004 $workingroot/cluster_info
        ln -sf $sourcefolder/$file_GW_005 $workingroot/watch_cluster_status
    fi
    
    ln -sf $sourcefolder/$file_GW_006 $workingroot/enable_rad_admin_stats_and_cpview
    ln -sf $sourcefolder/$file_GW_007 $workingroot/vpn_client_operational_info
    #ln -sf $sourcefolder/$file_GW_008 $workingroot/vpn_client_operational_info.standalone
    #ln -sf $sourcefolder/$file_GW_009 $workingroot/fix_gw_missing_updatable_objects
    
fi


# =============================================================================
# =============================================================================
# FOLDER:  GW.CORE
# =============================================================================


export workingdir=GW.CORE
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir

if [ ! -r $sourcefolder ] ; then
    # This folder is not part of the distribution
    echo 'Skipping folder '$sourcefolder | tee -a -i $logfilepath
else
    if [ ! -r $linksfolder ] ; then
        mkdir -pv $linksfolder | tee -a -i $logfilepath
        chmod 775 $linksfolder | tee -a -i $logfilepath
    else
        chmod 775 $linksfolder | tee -a -i $logfilepath
    fi
    
    file_GW_CORE_001=fix_smcias_interfaces.v04.26.00.sh
    file_GW_CORE_002=set_fwkern_dot_conf_settings_on_R8x.CORE.v04.26.01.sh
    
    ln -sf $sourcefolder/$file_GW_CORE_001 $linksfolder/fix_smcias_interfaces
    ln -sf $sourcefolder/$file_GW_CORE_002 $linksfolder/set_fwkern_dot_conf_settings_on_R8x.CORE
    
    #if [ "$sys_type_GW" == "true" ] ; then
        
        #ln -sf $sourcefolder/$file_GW_CORE_001 $workingroot/fix_smcias_interfaces
        #ln -sf $sourcefolder/$file_GW_CORE_002 $workingroot/set_fwkern_dot_conf_settings_on_R8x.CORE
        
    #fi
fi


# =============================================================================
# =============================================================================
# FOLDER:  Health_Check
# =============================================================================


export workingdir=Health_Check
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi


file_healthcheck_001=healthcheck.sh
file_healthcheck_002=run_healthcheck_to_dump_dtg.v04.26.00.sh
file_healthcheck_003=check_status_checkpoint_services.v04.26.00.sh

ln -sf $sourcefolder/$file_healthcheck_001 $linksfolder/healthcheck
ln -sf $sourcefolder/$file_healthcheck_001 $workingroot/healthcheck
ln -sf $sourcefolder/$file_healthcheck_002 $linksfolder/healthdump
ln -sf $sourcefolder/$file_healthcheck_002 $workingroot/healthdump
ln -sf $sourcefolder/$file_healthcheck_003 $linksfolder/check_point_service_status_check
ln -sf $sourcefolder/$file_healthcheck_003 $workingroot/check_point_service_status_check


# =============================================================================
# =============================================================================
# FOLDER:  MDM
# =============================================================================


export workingdir=MDM
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_MDM_001=backup_mds_ugex.v04.26.00.sh
file_MDM_002=backup_mds_w_logs_ugex.v04.26.00.sh

file_MDM_003=report_mdsstat.v04.26.00.sh
file_MDM_004=watch_mdsstat.v04.26.00.sh
file_MDM_005=show_all_domains_in_array.v04.26.00.sh

ln -sf $sourcefolder/$file_MDM_001 $linksfolder/backup_mds_ugex
ln -sf $sourcefolder/$file_MDM_002 $linksfolder/backup_mds_w_logs_ugex
ln -sf $sourcefolder/$file_MDM_003 $linksfolder/report_mdsstat
ln -sf $sourcefolder/$file_MDM_004 $linksfolder/watch_mdsstat
ln -sf $sourcefolder/$file_MDM_005 $linksfolder/show_domains_in_array

if [ "$sys_type_MDS" == "true" ]; then
    
    ln -sf $sourcefolder/$file_MDM_001 $workingroot/backup_mds_ugex
    ln -sf $sourcefolder/$file_MDM_002 $workingroot/backup_mds_w_logs_ugex
    ln -sf $sourcefolder/$file_MDM_003 $workingroot/report_mdsstat
    ln -sf $sourcefolder/$file_MDM_004 $workingroot/watch_mdsstat
    ln -sf $sourcefolder/$file_MDM_005 $workingroot/show_domains_in_array
    
fi


# =============================================================================
# =============================================================================
# FOLDER:  MGMT
# =============================================================================


export workingdir=MGMT
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_MGMT_001=identify_self_referencing_symbolic_link_files.sh
file_MGMT_002=identify_self_referencing_symbolic_link_files.Lite.sh

ln -sf $sourcefolder/$file_MGMT_001 $linksfolder/identify_self_referencing_symbolic_link_files
ln -sf $sourcefolder/$file_MGMT_001 $workingroot/identify_self_referencing_symbolic_link_files

# Done testing, providing this as a stand-alone solution
#
#ln -sf $sourcefolder/$file_MGMT_002 $linksfolder/Lite.identify_self_referencing_symbolic_link_files
#ln -sf $sourcefolder/$file_MGMT_002 $workingroot/Lite.identify_self_referencing_symbolic_link_files

if [ "$sys_type_SMS" == "true" ]; then
    echo
    if [ $Check4EPM -gt 0 ]; then
        echo    
    fi
fi

if [ "$sys_type_MDS" == "true" ]; then
    echo
fi

if [ "$sys_type_SmartEvent" == "true" ]; then
    echo
fi



# =============================================================================
# =============================================================================
# FOLDER:  Patch_HotFix
# =============================================================================


export workingdir=Patch_HotFix
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_patch_001=fix_gaia_webui_login_dot_js.sh
file_patch_002=fix_gaia_webui_login_dot_js_generic.sh

export need_fix_webui=false

if $IsR8XVersion ; then
    export need_fix_webui=false
else
    export need_fix_webui=true
fi

if [ "$need_fix_webui" == "true" ]; then
    
    ln -sf $sourcefolder/$file_patch_001 $linksfolder/fix_gaia_webui_login_dot_js
    ln -sf $sourcefolder/$file_patch_001 $workingroot/fix_gaia_webui_login_dot_js
    
    ln -sf $sourcefolder/$file_patch_002 $linksfolder/fix_gaia_webui_login_dot_js_generic

fi


# =============================================================================
# =============================================================================
# FOLDER:  Session_Cleanup
# =============================================================================


export workingdir=Session_Cleanup
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_SESSION_001=remove_zerolocks_sessions.v04.00.00.sh
file_SESSION_002=remove_zerolocks_web_api_sessions.v04.00.00.sh
file_SESSION_003=show_zerolocks_sessions.v04.00.00.sh
file_SESSION_004=show_zerolocks_web_api_sessions.v04.00.00.sh

export do_session_cleanup=false

if $IsR8XVersion ; then
    export do_session_cleanup=true
else
    export do_session_cleanup=false
fi

if [ "$do_session_cleanup" == "true" ]; then
    
    ln -sf $sourcefolder/$file_SESSION_001 $linksfolder/remove_zerolocks_sessions
    ln -sf $sourcefolder/$file_SESSION_002 $linksfolder/remove_zerolocks_web_api_sessions
    ln -sf $sourcefolder/$file_SESSION_003 $linksfolder/show_zerolocks_sessions
    ln -sf $sourcefolder/$file_SESSION_004 $linksfolder/show_zerolocks_web_api_sessions

    if [ "$sys_type_GW" == "false" ]; then
        
        ln -sf $sourcefolder/$file_SESSION_001 $workingroot/remove_zerolocks_sessions
        ln -sf $sourcefolder/$file_SESSION_002 $workingroot/remove_zerolocks_web_api_sessions
        ln -sf $sourcefolder/$file_SESSION_003 $workingroot/show_zerolocks_sessions
        ln -sf $sourcefolder/$file_SESSION_004 $workingroot/show_zerolocks_web_api_sessions
            
    fi
    
fi


# =============================================================================
# =============================================================================
# FOLDER:  SmartEvent
# =============================================================================


export workingdir=SmartEvent
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_SMEV_001=SmartEvent_Backup_R8X.v04.26.00.sh
file_SMEV_002=SmartEvent_Restore_R8X.v04.26.00-NR.sh
file_SMEV_003=Reset_SmartLog_Indexing_Back_X_Days.v04.26.00.sh
file_SMEV_004=NUKE_ALL_LOGS_AND_INDEXES.v04.26.00.sh

ln -sf $sourcefolder/$file_SMEV_001 $linksfolder/SmartEvent_Backup_R8X
ln -sf $sourcefolder/$file_SMEV_002 $linksfolder/SmartEvent_Restore_R8X
ln -sf $sourcefolder/$file_SMEV_003 $linksfolder/Reset_SmartLog_Indexing
ln -sf $sourcefolder/$file_SMEV_004 $linksfolder/SmartEvent_NUKE_Index_and_Logs

if [ "$sys_type_SmartEvent" == "true" ]; then
    
    ln -sf $sourcefolder/$file_SMEV_001 $workingroot/SmartEvent_backup
    #ln -sf $sourcefolder/$file_SMEV_002 $workingroot/SmartEvent_restore
    #ln -sf $sourcefolder/$file_SMEV_003 $workingroot/Reset_SmartLog_Indexing
    #ln -sf $sourcefolder/$file_SMEV_004 $workingroot/SmartEvent_NUKE_Index_and_Logs
    
fi


# =============================================================================
# =============================================================================
# FOLDER:  SMS
# =============================================================================


export workingdir=SMS
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_SMS_005=report_cpwd_admin_list.v04.26.00.sh
file_SMS_006=watch_cpwd_admin_list.v04.26.00.sh
file_SMS_007=restart_mgmt.v04.26.00.sh

file_SMS_008=fix_api_memory.v04.26.00.sh

file_SMS_009=reset_hit_count_on_R80_SMS_commands.001.v00.01.00.sh

ln -sf $sourcefolder/$file_SMS_005 $linksfolder/report_cpwd_admin_list
ln -sf $sourcefolder/$file_SMS_005 $workingroot/report_cpwd_admin_list

ln -sf $sourcefolder/$file_SMS_006 $linksfolder/watch_cpwd_admin_list
ln -sf $sourcefolder/$file_SMS_006 $workingroot/watch_cpwd_admin_list

ln -sf $sourcefolder/$file_SMS_007 $linksfolder/restart_mgmt

ln -sf $sourcefolder/$file_SMS_008 $linksfolder/fix_api_memory

ln -sf $sourcefolder/$file_SMS_009 $linksfolder/reset_hit_count_on_R80_SMS_commands

if [ "$sys_type_SMS" == "true" ]; then
    
    ln -sf $sourcefolder/$file_SMS_007 $workingroot/restart_mgmt
    ln -sf $sourcefolder/$file_SMS_009 $workingroot/reset_hit_count_on_R80_SMS_commands
    
fi


# =============================================================================
# =============================================================================
# FOLDER:  SMS.CORE
# =============================================================================


export workingdir=SMS.CORE
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_SMS_CORE_001=CORE-G2_install_policy.v04.26.00.raw.sh

ln -sf $sourcefolder/$file_SMS_CORE_001 $linksfolder/CORE-G2_install_policy

#if [ "$sys_type_SMS" == "true" ]; then
    
    #ln -sf $sourcefolder/$file_SMS_CORE_001 $workingroot/CORE-G2_install_policy
    
#fi


# =============================================================================
# =============================================================================
# FOLDER:  SMS.migrate_backup
# =============================================================================


export workingdir=SMS.migrate_backup
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_SMS_Migrate_001=migrate_export_npm_ugex.v04.26.02.sh
file_SMS_Migrate_002=migrate_export_w_logs_npm_ugex.v04.26.02.sh
file_SMS_Migrate_003=migrate_export_epm_ugex.v04.26.02.sh
file_SMS_Migrate_004=migrate_export_w_logs_epm_ugex.v04.26.02.sh

file_SMS_Migrate_011=migrate_server_export_npm_ugex.v04.26.02.sh
file_SMS_Migrate_012=migrate_server_export_w_logs_npm_ugex.v04.26.02.sh
file_SMS_Migrate_013=migrate_server_export_epm_ugex.v04.26.02.sh
file_SMS_Migrate_014=migrate_server_export_w_logs_epm_ugex.v04.26.02.sh

ln -sf $sourcefolder/$file_SMS_Migrate_001 $linksfolder/migrate_export_npm_ugex
ln -sf $sourcefolder/$file_SMS_Migrate_002 $linksfolder/migrate_export_w_logs_npm_ugex

if [ $Check4EPM -gt 0 ]; then
    
    ln -sf $sourcefolder/$file_SMS_Migrate_003 $linksfolder/migrate_export_epm_ugex
    ln -sf $sourcefolder/$file_SMS_Migrate_004 $linksfolder/migrate_export_w_logs_epm_ugex
    
fi

if [ "$sys_type_SMS" == "true" ]; then
    
    ln -sf $sourcefolder/$file_SMS_Migrate_001 $workingroot/migrate_export_npm_ugex
    ln -sf $sourcefolder/$file_SMS_Migrate_002 $workingroot/migrate_export_w_logs_npm_ugex
    
    ln -sf $sourcefolder/$file_SMS_Migrate_011 $workingroot/migrate_server_export_npm_ugex
    ln -sf $sourcefolder/$file_SMS_Migrate_012 $workingroot/migrate_server_export_w_logs_npm_ugex
    
    if [ $Check4EPM -gt 0 ]; then
        
        ln -sf $sourcefolder/$file_SMS_Migrate_003 $workingroot/migrate_export_epm_ugex
        ln -sf $sourcefolder/$file_SMS_Migrate_004 $workingroot/migrate_export_w_logs_epm_ugex
        
        ln -sf $sourcefolder/$file_SMS_Migrate_013 $workingroot/migrate_server_export_epm_ugex
        ln -sf $sourcefolder/$file_SMS_Migrate_014 $workingroot/migrate_server_export_w_logs_epm_ugex
        
    fi
    
fi


# =============================================================================
# =============================================================================
# FOLDER:  UserConfig
# =============================================================================


export workingdir=UserConfig
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir
if [ ! -r $linksfolder ] ; then
    mkdir -pv $linksfolder | tee -a -i $logfilepath
    chmod 775 $linksfolder | tee -a -i $logfilepath
else
    chmod 775 $linksfolder | tee -a -i $logfilepath
fi

file_USERCONF_001=add_alias_commands.all.v04.26.00.sh
file_USERCONF_002=add_alias_commands_all_users.all.v04.26.00.sh
file_USERCONF_003=update_alias_commands.all.v04.26.00.sh
file_USERCONF_004=update_alias_commands_all_users.all.v04.26.00.sh

ln -sf $sourcefolder/$file_USERCONF_001 $linksfolder/alias_commands_add_user
ln -sf $sourcefolder/$file_USERCONF_001 $workingroot/alias_commands_add_user

ln -sf $sourcefolder/$file_USERCONF_002 $linksfolder/alias_commands_add_all_users
ln -sf $sourcefolder/$file_USERCONF_002 $workingroot/alias_commands_add_all_users

ln -sf $sourcefolder/$file_USERCONF_003 $linksfolder/alias_commands_update_user
ln -sf $sourcefolder/$file_USERCONF_003 $workingroot/alias_commands_update_user

ln -sf $sourcefolder/$file_USERCONF_004 $linksfolder/alias_commands_update_all_users
ln -sf $sourcefolder/$file_USERCONF_004 $workingroot/alias_commands_update_all_users


# =============================================================================
# =============================================================================
# FOLDER:  UserConfig.CORE_G2.NPM
# =============================================================================


export workingdir=UserConfig.CORE_G2.NPM
export sourcefolder=$workingbase/$workingdir
export linksfolder=$linksbase/$workingdir

if [ ! -r $sourcefolder ] ; then
    # This folder is not part of the distribution
    echo 'Skipping folder '$sourcefolder | tee -a -i $logfilepath
else
    
    if [ ! -r $linksfolder ] ; then
        mkdir -pv $linksfolder | tee -a -i $logfilepath
        chmod 775 $linksfolder | tee -a -i $logfilepath
    else
        chmod 775 $linksfolder | tee -a -i $logfilepath
    fi
    
    file_USERCONF_005=add_alias_commands.CORE_G2.NPM.v04.26.00.sh
    file_USERCONF_006=add_alias_commands_all_users.CORE_G2.NPM.v04.26.00.sh
    file_USERCONF_007=update_alias_commands.CORE_G2.NPM.v04.26.00.sh
    file_USERCONF_008=update_alias_commands_all_users.CORE_G2.NPM.v04.26.00.sh
    
    ln -sf $sourcefolder/$file_USERCONF_005 $linksfolder/alias_commands_CORE_G2_NPM_add_user
    ln -sf $sourcefolder/$file_USERCONF_006 $linksfolder/alias_commands_CORE_G2_NPM_add_all_users
    ln -sf $sourcefolder/$file_USERCONF_007 $linksfolder/alias_commands_CORE_G2_NPM_update_user
    ln -sf $sourcefolder/$file_USERCONF_008 $linksfolder/alias_commands_CORE_G2_NPM_update_all_users
    
    #ln -sf $sourcefolder/$file_USERCONF_005 $workingroot/alias_commands_CORE_G2_NPM_add_user
    #ln -sf $sourcefolder/$file_USERCONF_006 $workingroot/alias_commands_CORE_G2_NPM_add_all_users
    #ln -sf $sourcefolder/$file_USERCONF_007 $workingroot/alias_commands_CORE_G2_NPM_update_user
    #ln -sf $sourcefolder/$file_USERCONF_008 $workingroot/alias_commands_CORE_G2_NPM_update_all_users
    
fi


# =============================================================================
# =============================================================================
# FOLDER:  
# =============================================================================

# =============================================================================
# =============================================================================

# =============================================================================
# =============================================================================

echo | tee -a -i $logfilepath
echo 'List folder : '$workingroot | tee -a -i $logfilepath
ls -alh $workingroot | tee -a -i $logfilepath
echo | tee -a -i $logfilepath
echo 'List folder : '$workingbase | tee -a -i $logfilepath
ls -alh $workingbase | tee -a -i $logfilepath
echo | tee -a -i $logfilepath
echo 'List folder : '$linksbase | tee -a -i $logfilepath
ls -alh $linksbase | tee -a -i $logfilepath
echo | tee -a -i $logfilepath
echo 'Done with links generation!' | tee -a -i $logfilepath
echo | tee -a -i $logfilepath

# =============================================================================
# =============================================================================



#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#


#==================================================================================================
#==================================================================================================
#
# end shell meat
#
#==================================================================================================
#==================================================================================================


#==================================================================================================
#==================================================================================================
#
# shell clean-up and log dump
#
#==================================================================================================
#==================================================================================================


if [ -r nul ] ; then
    rm nul >> $logfilepath
fi

if [ -r None ] ; then
    rm None >> $logfilepath
fi

echo | tee -a -i $logfilepath
echo 'List folder : '$outputpathbase | tee -a -i $logfilepath
ls -alh $outputpathbase | tee -a -i $logfilepath
echo | tee -a -i $logfilepath

echo | tee -a -i $logfilepath
echo 'Output location for all results is here : '$outputpathbase | tee -a -i $logfilepath
echo 'Log results documented in this log file : '$logfilepath | tee -a -i $logfilepath
echo | tee -a -i $logfilepath

#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
# End of Script
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------


echo
echo 'Script Completed, exiting...';echo

