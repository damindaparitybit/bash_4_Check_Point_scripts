#!/bin/bash
#
# SCRIPT capture configuration values for bash and clish
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
ScriptDate=2020-05-06
ScriptVersion=04.26.08
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

export BASHScriptFileNameRoot=config_capture
export BASHScriptShortName="config_capture"
export BASHScriptnohupName=$BASHScriptShortName
export BASHScriptDescription=="Configuration Capture for bash and clish"

#export BASHScriptName=$BASHScriptFileNameRoot.$TemplateLevel.v$ScriptVersion
export BASHScriptName=$BASHScriptFileNameRoot.v$ScriptVersion

export BASHScriptHelpFileName="$BASHScriptFileNameRoot.help"
export BASHScriptHelpFilePath="help.v$ScriptVersion"
export BASHScriptHelpFile="$BASHScriptHelpFilePath/$BASHScriptHelpFileName"

# _sub-scripts|_template|Common|Config|GAIA|GW|[GW.CORE]|Health_Check|MDM|MGMT|Patch_Hotfix|Session_Cleanup|SmartEvent|SMS|[SMS.CORE]|SMS.migrate_backup|UserConfig|[UserConfig.CORE_G2.NPM]
export BASHScriptsFolder=Config

export BASHScripttftptargetfolder="host_data"


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
export OutputToDump=false
export OutputToChangeLog=false
export OutputToOther=true
#
# if OutputToOther is true, then this next value needs to be set
#
export OtherOutputFolder=./host_data

# if we are date-time stamping the output location as a subfolder of the 
# output folder set this to true,  otherwise it needs to be false
#
export OutputDTGSSubfolder=true
export OutputSubfolderScriptName=false
export OutputSubfolderScriptShortName=false

export notthispath=/home/
export startpathroot=.

export localdotpath=`echo $PWD`
export currentlocalpath=$localdotpath
export workingpath=$currentlocalpath

export UseGaiaVersionAndInstallation=true
export ShowGaiaVersionResults=true
export KeepGaiaVersionResultsFile=true

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

# MODIFIED 2018-11-20 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CommandLineParameterHandler () {
    #
    # CommandLineParameterHandler - Command Line Parameter Handler calling routine
    #
    
    # -------------------------------------------------------------------------------------------------
    # Check Command Line Parameter Handlerr action script exists
    # -------------------------------------------------------------------------------------------------
    
    # MODIFIED 2018-11-20 -
    
    export configured_handler_root=$cli_script_cmdlineparm_handler_root
    export actual_handler_root=$configured_handler_root
    
    if [ "$configured_handler_root" == "." ] ; then
        if [ $ScriptSourceFolder != $localdotpath ] ; then
            # Script is not running from it's source folder, might be linked, so since we expect the handler folder
            # to be relative to the script source folder, use the identified script source folder instead
            export actual_handler_root=$ScriptSourceFolder
        else
            # Script is running from it's source folder
            export actual_handler_root=$configured_handler_root
        fi
    else
        # handler root path is not period (.), so stipulating fully qualified path
        export actual_handler_root=$configured_handler_root
    fi
    
    export cli_script_cmdlineparm_handler_path=$actual_handler_root/$cli_script_cmdlineparm_handler_folder
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
            echo '  Configured Root path    : '$configured_handler_root | tee -a -i $logfilepath
            echo '  Actual Script Root path : '$actual_handler_root | tee -a -i $logfilepath
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
    
    # MODIFIED 2018-11-20 -
    
    export configured_handler_root=$gaia_version_type_handler_root
    export actual_handler_root=$configured_handler_root
    
    if [ "$configured_handler_root" == "." ] ; then
        if [ $ScriptSourceFolder != $localdotpath ] ; then
            # Script is not running from it's source folder, might be linked, so since we expect the handler folder
            # to be relative to the script source folder, use the identified script source folder instead
            export actual_handler_root=$ScriptSourceFolder
        else
            # Script is running from it's source folder
            export actual_handler_root=$configured_handler_root
        fi
    else
        # handler root path is not period (.), so stipulating fully qualified path
        export actual_handler_root=$configured_handler_root
    fi
    
    export gaia_version_type_handler_path=$actual_handler_root/$gaia_version_type_handler_folder
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
# START :  Collect and Capture Configuration and Information data
#
#==================================================================================================
#==================================================================================================


#----------------------------------------------------------------------------------------
# Configure specific parameters
#----------------------------------------------------------------------------------------

export targetversion=$gaiaversion

export outputfilepath=$outputpathbase/
export outputfileprefix=$HOSTNAME'_'$targetversion
export outputfilesuffix='_'$DATEDTGS
export outputfiletype=.txt

if [ ! -r $outputfilepath ] ; then
    mkdir -pv $outputfilepath | tee -a -i $logfilepath
    chmod 775 $outputfilepath | tee -a -i $logfilepath
else
    chmod 775 $outputfilepath | tee -a -i $logfilepath
fi


#==================================================================================================
# -------------------------------------------------------------------------------------------------
# START :  Operational Procedures
# -------------------------------------------------------------------------------------------------


# -------------------------------------------------------------------------------------------------
# CopyFileAndDump2FQDNOutputfile - Copy identified file at path to output file path and also dump to output file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-10-05 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CopyFileAndDump2FQDNOutputfile () {
    #
    # Copy identified file at path to output file path and also dump to output file
    #

    export outputfile=$outputfileprefix'_file_'$outputfilenameaddon$file2copy$outputfilesuffix$outputfiletype
    export outputfilefqfn=$outputfilepath$outputfile

    if [ ! -r $file2copypath ] ; then
        echo | tee -a -i $outputfilefqfn
        echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
        echo 'NO File Found at Path! :  ' | tee -a -i $outputfilefqfn
        echo ' - File : '$file2copy | tee -a -i $outputfilefqfn
        echo ' - Path : '"$file2copypath" | tee -a -i $outputfilefqfn
        echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
        echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    else
        echo | tee -a -i $outputfilefqfn
        echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
        echo 'Found File at Path :  ' | tee -a -i $outputfilefqfn
        echo ' - File : '$file2copy | tee -a -i $outputfilefqfn
        echo ' - Path : '"$file2copypath" | tee -a -i $outputfilefqfn
        echo 'Copy File at Path to Target : ' | tee -a -i $outputfilefqfn
        echo ' - File at Path : '"$file2copypath" | tee -a -i $outputfilefqfn
        echo ' - to Target    : '"$outputfilepath" | tee -a -i $outputfilefqfn
        echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
        echo >> $outputfilefqfn
        cp "$file2copypath" "$outputfilepath" >> $outputfilefqfn
     
        echo >> $outputfilefqfn
        echo '----------------------------------------------------------------------------' >> $outputfilefqfn
        echo 'Dump contents of Source File to Logging File :' | tee -a -i $outputfilefqfn
        echo ' - Source File  : '"$file2copypath" | tee -a -i $outputfilefqfn
        echo ' - Logging File : '$outputfilefqfn | tee -a -i $outputfilefqfn
        echo '----------------------------------------------------------------------------' >> $outputfilefqfn
        echo >> $outputfilefqfn
        cat "$file2copypath" >> $outputfilefqfn
        echo >> $outputfilefqfn
        echo '----------------------------------------------------------------------------' >> $outputfilefqfn
        echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    fi
    echo | tee -a -i $outputfilefqfn

    echo
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-31

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# CopyFileAndDump2FQDNOutputfile

# -------------------------------------------------------------------------------------------------
# FindFilesAndCollectIntoArchive - Document identified file locations to output file path and also collect into archive
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-10-05 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FindFilesAndCollectIntoArchive () {
    #
    # Document identified file locations to output file path and also collect into archive
    #

    export file2findpath="/"
    export file2findname=${file2find/\*/(star)}
    export command2run=find
    export outputfile=$outputfileprefix'_'$command2run'_'$file2findname$outputfilesuffix$outputfiletype
    export outputfilefqfn=$outputfilepath$outputfile
    
    echo | tee -a -i $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo 'Find file : '$file2find' and document locations' | tee -a -i $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo >> $outputfilefqfn
    
    find / -name "$file2find" 2> /dev/null >> "$outputfilefqfn"
    
    export archivefile='archive_'$file2findname$outputfilesuffix'.tgz'
    export archivefqfn=$outputfilepath$archivefile
    
    echo >> $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo 'Archive all found Files to Target Archive' | tee -a -i $outputfilefqfn
    echo ' - Found Files    : '$file2find | tee -a -i $outputfilefqfn
    echo ' - Target Archive : '$archivefqfn | tee -a -i $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo >> $outputfilefqfn
    
    tar czvf $archivefqfn --exclude=$customerworkpathroot* $(find / -name "$file2find" 2> /dev/null) >> $outputfilefqfn

    echo >> $outputfilefqfn
    echo '----------------------------------------------------------------------------' >> $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo | tee -a -i $outputfilefqfn
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-31

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#FindFilesAndCollectIntoArchive


# -------------------------------------------------------------------------------------------------
# FindFilesAndCollectIntoArchiveAllVariants - Document identified file locations to output file path and also collect into archive all variants
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-10-05 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FindFilesAndCollectIntoArchiveAllVariants () {
    #
    # Document identified file locations to output file path and also collect into archive all variants
    #

    export file2findpath="/"
    export file2findname=${file2find/\*/(star)}
    export command2run=find
    export outputfile=$outputfileprefix'_'$command2run'_'$file2findname'_all_variants'$outputfilesuffix$outputfiletype
    export outputfilefqfn=$outputfilepath$outputfile
    
    echo | tee -a -i $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo 'Find file : '$file2find'* and document locations' | tee -a -i $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo >> $outputfilefqfn
    
    find / -name "$file2find*" 2> /dev/null >> "$outputfilefqfn"
    
    export archivefile='archive_'$file2findname'_all_variants'$outputfilesuffix'.tgz'
    export archivefqfn=$outputfilepath$archivefile
    
    echo >> $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo 'Archive all found Files* to Target Archive' | tee -a -i $outputfilefqfn
    echo ' - Found Files    : '$file2find'*' | tee -a -i $outputfilefqfn
    echo ' - Target Archive : '$archivefqfn | tee -a -i $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo >> $outputfilefqfn
    
    tar czvf $archivefqfn --exclude=$customerworkpathroot* $(find / -name "$file2find*" 2> /dev/null) >> $outputfilefqfn

    echo >> $outputfilefqfn
    echo '----------------------------------------------------------------------------' >> $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo | tee -a -i $outputfilefqfn
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-31

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#export file2find=cpm.elg

#FindFilesAndCollectIntoArchiveAllVariants


# -------------------------------------------------------------------------------------------------
# FindFilesAndCollectIntoArchiveSpecific - Document identified file locations to output file path and also collect into archive specific variants
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-10-05 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

FindFilesAndCollectIntoArchiveSpecific () {
    #
    # Document identified file locations to output file path and also collect into archive specific variants
    #

    export file2findpath="/"
    export file2findname=${file2find/\*/(star)}
    export command2run=find
    export outputfile=$outputfileprefix'_'$command2run'_'$file2findname'_specific_variants'$outputfilesuffix$outputfiletype
    export outputfilefqfn=$outputfilepath$outputfile
    
    echo | tee -a -i $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo 'Find file : '$file2find'* and document locations' | tee -a -i $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo >> $outputfilefqfn
    
    find / -name "$file2find*" 2> /dev/null >> "$outputfilefqfn"
    
    export archivefile='archive_'$file2findname'_specific_variants'$outputfilesuffix'.tgz'
    export archivefqfn=$outputfilepath$archivefile
    
    echo >> $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo 'Archive all found Files* to Target Archive' | tee -a -i $outputfilefqfn
    echo ' - Found Files    : '$file2findname | tee -a -i $outputfilefqfn
    echo ' - Exclude        : '$file2findstartpath'/' | tee -a -i $outputfilefqfn
    echo ' - Start Path     : '$file2findexclude'/*' | tee -a -i $outputfilefqfn
    echo ' - Target Archive : '$archivefqfn | tee -a -i $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo >> $outputfilefqfn
    
    tar czvf $archivefqfn --exclude=$file2findexclude/* $(find $file2findstartpath/ -name "$file2find*" 2> /dev/null) >> $outputfilefqfn

    echo >> $outputfilefqfn
    echo '----------------------------------------------------------------------------' >> $outputfilefqfn
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo | tee -a -i $outputfilefqfn
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-31

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#export file2find=cpm.elg
#export file2findstartpath=$MDS_FWDIR/log
#export file2findexclude=$MDS_FWDIR/log/imported_logs

#FindFilesAndCollectIntoArchiveSpecific


# -------------------------------------------------------------------------------------------------
# CopyFiles2CaptureFolder - repeated proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-10-05 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

CopyFiles2CaptureFolder () {
    #
    # repeated procedure description
    #
    
    export targetpath=$outputfilepath$command2run/
    export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
    export outputfilefqfn=$outputfilepath$outputfile
    
    echo | tee -a -i "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo 'Copy files from Source to Target' | tee -a -i "$outputfilefqfn"
    echo ' - Source : '$sourcepath | tee -a -i "$outputfilefqfn"
    echo ' - Target : '$targetpath | tee -a -i "$outputfilefqfn"
    echo ' - Log to : '"$outputfilefqfn" | tee -a -i "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo >> "$outputfilefqfn"
    
    mkdir -pv $targetpath >>"$outputfilefqfn"

    echo >> "$outputfilefqfn"
    
    cp -a -v $sourcepath $targetpath | tee -a -i "$outputfilefqfn"

    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo | tee -a -i "$outputfilefqfn"
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-31

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#CopyFiles2CaptureFolder


# -------------------------------------------------------------------------------------------------
# DoCommandAndDocument - Execute command and document results to dedicated file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-10-05 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

DoCommandAndDocument () {
    #
    # repeated procedure description
    #

    export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
    export outputfilefqfn=$outputfilepath$outputfile
    
    echo | tee -a -i "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
    echo 'Execute Command with output to Output Path : ' | tee -a -i "$outputfilefqfn"
    echo ' - Execute Command    : '$command2run | tee -a -i "$outputfilefqfn"
    echo ' - Output Path        : '$outputfilefqfn | tee -a -i "$outputfilefqfn"
    echo ' - Command with Parms # '"$@" | tee -a -i "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    
    "$@" >> "$outputfilefqfn"
    
    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
    echo | tee -a -i "$outputfilefqfn"
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED YYYY-MM-DD

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#DoCommandAndDocument


# -------------------------------------------------------------------------------------------------
# END :  Operational Procedures
# -------------------------------------------------------------------------------------------------
#==================================================================================================


#----------------------------------------------------------------------------------------
# bash - Gaia Version information 
#----------------------------------------------------------------------------------------

export command2run=Gaia_version
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

# This was already collected earlier and saved in a dedicated file

cp $gaiaversionoutputfile $outputfilefqfn | tee -a -i $logfilepath
rm $gaiaversionoutputfile | tee -a -i $logfilepath


#----------------------------------------------------------------------------------------
# bash - First Time Wizard (FTW) execution Completed
#----------------------------------------------------------------------------------------

export command2run=FTW_Completed

DoCommandAndDocument ls -la /etc/.wizard_accepted
DoCommandAndDocument tail -n 10 /var/log/ftw_install.log


#----------------------------------------------------------------------------------------
# bash - backup user's home folder
#----------------------------------------------------------------------------------------

export homebackuproot=$startpathroot

export expandedpath=$(cd $homebackuproot ; pwd)
export homebackuproot=$expandedpath
export checkthispath=`echo "${expandedpath}" | grep -i "$notthispath"`
export isitthispath=`test -z $checkthispath; echo $?`

if [ $isitthispath -eq 1 ] ; then
    #Oh, Oh, we're in the home directory executing, not good!!!
    #Configure homebackuproot for $alternatepathroot folder since we can't run in /home/
    export homebackuproot=$alternatepathroot
else
    #OK use the current folder and create host_data sub-folder
    export homebackuproot=$startpathroot
fi

if [ ! -r $homebackuproot ] ; then
    #not where we're expecting to be, since $homebackuproot is missing here
    #maybe this hasn't been run here yet.
    #OK, so make the expected folder and set permissions we need
    mkdir -pv $homebackuproot
    chmod 775 $homebackuproot
else
    #set permissions we need
    chmod 775 $homebackuproot
fi

export expandedpath=$(cd $homebackuproot ; pwd)
export homebackuproot=${expandedpath}
export homebackuppath="$homebackuproot/home.backup"

if [ ! -r $homebackuppath ] ; then
    mkdir -pv $homebackuppath
    chmod 775 $homebackuppath
else
    chmod 775 $homebackuppath
fi

export command2run=backup-home
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile
touch "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo 'Execute '$command2run' to '$outputhomepath' with output to : '$outputfilefqfn >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo "Current path : " >> "$outputfilefqfn"
pwd >> "$outputfilefqfn"

echo "Copy /home folder to $outputhomepath" >> "$outputfilefqfn"
cp -a -v "/home/" "$outputhomepath" >> "$outputfilefqfn"

echo
echo 'Execute '$command2run' to '$homebackuppath' with output to : '$outputfilefqfn
echo >> "$outputfilefqfn"

pushd /home

echo >> "$outputfilefqfn"
echo "Current path : " >> "$outputfilefqfn"
pwd >> "$outputfilefqfn"

echo "Copy /home folder contents to $homebackuppath" >> "$outputfilefqfn"
cp -a -v "." "$homebackuppath" >> "$outputfilefqfn"

popd

echo >> "$outputfilefqfn"
echo "Current path : " >> "$outputfilefqfn"
pwd >> "$outputfilefqfn"

echo >> "$outputfilefqfn"

echo "Current path : " >> "$outputfilefqfn"
pwd >> "$outputfilefqfn"


#----------------------------------------------------------------------------------------
# bash - gather licensing information
#----------------------------------------------------------------------------------------

export command2run=cplic_print

DoCommandAndDocument cplic print -x

#
#export command2run=cplic_db_print
#
#DoCommandAndDocument cplic db_print -all
#


#----------------------------------------------------------------------------------------
# bash - memory
#----------------------------------------------------------------------------------------

export command2run=memory

DoCommandAndDocument free -m -t


#----------------------------------------------------------------------------------------
# bash and clish - disk space and operational space for backups, upgrades, snapshots
#----------------------------------------------------------------------------------------

export command2run=disk_space
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

DoCommandAndDocument df -hT
DoCommandAndDocument fdisk -l
DoCommandAndDocument mount
DoCommandAndDocument parted -l

CheckAndUnlockGaiaDB

echo | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'Execute Command with output to Output Path : ' | tee -a -i "$outputfilefqfn"
echo ' - Execute Command    : '$command2run | tee -a -i "$outputfilefqfn"
echo ' - Output Path        : '$outputfilefqfn | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'clish -i -c "show snapshots"' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

clish -i -c "show snapshots" >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo | tee -a -i "$outputfilefqfn"

DoCommandAndDocument vgdisplay -C
DoCommandAndDocument vgdisplay -v


#----------------------------------------------------------------------------------------
# bash - gather rpm package information
#----------------------------------------------------------------------------------------

export command2run=rpm-query-all
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'Execute Command with output to Output Path : ' | tee -a -i "$outputfilefqfn"
echo ' - Execute Command    : '$command2run | tee -a -i "$outputfilefqfn"
echo ' - Output Path        : '$outputfilefqfn | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'rpm -qa | sort' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

rpm -qa | sort -f >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo | tee -a -i "$outputfilefqfn"


#----------------------------------------------------------------------------------------
# bash - gather SmartLog User Settings details information
#----------------------------------------------------------------------------------------

export command2run=SmartLog_User_Settings
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo | tee -a -i "$outputfilefqfn"

SmartLogUserSettingFolder=

case "$gaiaversion" in
    R77 | R77.10 | R77.20 | R77.30 )
        SmartLogUserSettingFolder=/opt/CPSmartLog-R77/data/users_settings
        ;;
    R80 | R80.10 )
        SmartLogUserSettingFolder=/opt/CPSmartLog-R80/data/users_settings
        ;;
    R80.20.M1 | R80.20.M2 | R80.20 )
        SmartLogUserSettingFolder=/opt/CPSmartLog-R80.20/data/users_settings
        ;;
    R80.30 ) 
        SmartLogUserSettingFolder=/opt/CPSmartLog-R80.30/data/users_settings
        ;;
    R80.40 ) 
        SmartLogUserSettingFolder=/opt/CPSmartLog-R80.40/data/users_settings
        ;;
    *)
        SmartLogUserSettingFolder=
        ;;
esac

export sourcepath=$SmartLogUserSettingFolder
export targetpath=$outputfilepath$command2run/

echo | tee -a -i "$outputfilefqfn"
if [ -z $SmartLogUserSettingFolder ] ; then
    # Missing SmartLogUserSettingsFolder value not set so skip
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
    echo 'Missing SmartLogUserSettingsFolder value not set so skip!' | tee -a -i "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
elif [ ! -r $SmartLogUserSettingFolder ] ; then
    # Not able to read SmartLogUserSettingsFolder so skip
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
    echo 'Not able to read SmartLogUserSettingsFolder so skip' | tee -a -i "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
else
    # able to read SmartLogUserSettingsFolder so collect
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
    echo 'Execute Command with output to Output Path : ' | tee -a -i "$outputfilefqfn"
    echo ' - Execute Command    : '$command2run | tee -a -i "$outputfilefqfn"
    echo ' - Output Path        : '$outputfilefqfn | tee -a -i "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
    echo >> "$outputfilefqfn"

    echo 'ls -alhR '$SmartLogUserSettingFolder >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    ls -alhR $SmartLogUserSettingFolder >> "$outputfilefqfn"
    
    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo 'Copy files from Source to Target' | tee -a -i "$outputfilefqfn"
    echo ' - Source : '$sourcepath | tee -a -i "$outputfilefqfn"
    echo ' - Target : '$targetpath | tee -a -i "$outputfilefqfn"
    echo ' - Log to : '"$outputfilefqfn" | tee -a -i "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo >> "$outputfilefqfn"
    
    mkdir -pv $targetpath >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    
    cp -a -v $sourcepath $targetpath >> "$outputfilefqfn"

    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
    
fi

echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo | tee -a -i "$outputfilefqfn"


#----------------------------------------------------------------------------------------
# bash - gather arp details
#----------------------------------------------------------------------------------------

export command2run=arp

DoCommandAndDocument arp -vn
DoCommandAndDocument arp -av


#----------------------------------------------------------------------------------------
# bash - gather route details
#----------------------------------------------------------------------------------------

export command2run=route

DoCommandAndDocument route -vn


#----------------------------------------------------------------------------------------
# bash - collect /etc/routed*.conf and copy if it exists
#----------------------------------------------------------------------------------------

# /etc/routed*.conf
export file2copy=routed.conf
export file2copypath="/etc/$file2copy"

export outputfilenameaddon=
CopyFileAndDump2FQDNOutputfile

export file2copy=routed0.conf
export file2copypath="/etc/$file2copy"

export outputfilenameaddon=
CopyFileAndDump2FQDNOutputfile

export file2find=routed*.conf

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# bash - generate device and system information via dmidecode
#----------------------------------------------------------------------------------------

export command2run=dmidecode

DoCommandAndDocument dmidecode


#----------------------------------------------------------------------------------------
# bash - collect /var/log/dmesg and copy if it exists
#----------------------------------------------------------------------------------------

# /var/log/dmesg
export file2copy=dmesg
export file2copypath="/var/log/$file2copy"

dmesg > $file2copypath

export outputfilenameaddon=
CopyFileAndDump2FQDNOutputfile


#----------------------------------------------------------------------------------------
# bash - generate hardware informatation via lshw only if not old kernel
#----------------------------------------------------------------------------------------

export command2run=lshw

if [ $isitoldkernel -ne 1 ] ; then

    DoCommandAndDocument lshw

fi


#----------------------------------------------------------------------------------------
# bash - collect /etc/modprobe.conf and copy if it exists
#----------------------------------------------------------------------------------------

# /etc/modprobe.conf
export file2copy=modprobe.conf
export file2copypath="/etc/$file2copy"

export outputfilenameaddon=
CopyFileAndDump2FQDNOutputfile

export file2find=modprobe.conf

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# bash - gather interface details - lspci
#----------------------------------------------------------------------------------------

export command2run=lspci

DoCommandAndDocument lspci -n -v


#----------------------------------------------------------------------------------------
# bash - gather interface details
#----------------------------------------------------------------------------------------

export command2run=ifconfig

DoCommandAndDocument ifconfig


#----------------------------------------------------------------------------------------
# bash - gather interfaces via ls
#----------------------------------------------------------------------------------------

export command2run=ls_sys_class_net

DoCommandAndDocument ls -1 /sys/class/net


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# InterfacesDoCommandAndDocument - For Interfaces execute command and document results to dedicated file
# -------------------------------------------------------------------------------------------------

# MODIFIED 2019-01-31 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

InterfacesDoCommandAndDocument () {
    #
    # For Interfaces execute command and document results to dedicated file
    #

    echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
    echo 'Execute : '"$@" >> "$interfaceoutputfilefqfn"
    echo >> "$interfaceoutputfilefqfn"
    
    "$@" >> "$interfaceoutputfilefqfn"
    
    echo >> "$interfaceoutputfilefqfn"
    echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
    
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2019-01-31

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#InterfacesDoCommandAndDocument


#----------------------------------------------------------------------------------------
# bash - Collect Interface Information per interface
#----------------------------------------------------------------------------------------

export command2run=interfaces_details
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

export dmesgfilefqfn=$outputfilepath'dmesg'
if [ ! -r $dmesgfilefqfn ] ; then
    echo | tee -a -i $outputfilefqfn
    echo 'No dmesg file at :  '$dmesgfilefqfn | tee -a -i $outputfilefqfn
    echo 'Generating dmesg file!' | tee -a -i $outputfilefqfn
    echo | tee -a -i $outputfilefqfn
    dmesg > $dmesgfilefqfn
else
    echo | tee -a -i $outputfilefqfn
    echo 'found dmesg file at :  '$dmesgfilefqfn | tee -a -i $outputfilefqfn
    echo | tee -a -i $outputfilefqfn
fi
echo | tee -a -i $outputfilefqfn

echo > $outputfilefqfn
echo '----------------------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
echo '----------------------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
echo | tee -a -i $outputfilefqfn
echo 'Execute Commands with output to Output Path : ' | tee -a -i "$outputfilefqfn"
echo ' - Execute Commands   : '$command2run | tee -a -i "$outputfilefqfn"
echo ' - Output Path        : '$outputfilefqfn | tee -a -i "$outputfilefqfn"
echo | tee -a -i $outputfilefqfn
echo '----------------------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
echo | tee -a -i $outputfilefqfn

echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'clish -i -c "show interfaces"' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

CheckAndUnlockGaiaDB

clish -i -c "show interfaces" | tee -a -i $outputfilefqfn

echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo | tee -a -i "$outputfilefqfn"

IFARRAY=()

GETINTERFACES="`clish -i -c "show interfaces"`"

echo | tee -a -i $outputfilefqfn
echo '----------------------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
echo 'Build array of interfaces : ' | tee -a -i $outputfilefqfn
echo | tee -a -i $outputfilefqfn

arraylength=0
while read -r line; do

    if [ $arraylength -eq 0 ]; then
    	echo -n 'Interfaces :  ' | tee -a -i $outputfilefqfn
    else
    	echo -n ', ' | tee -a -i $outputfilefqfn
    fi

    #IFARRAY+=("$line")
    if [ "$line" == 'lo' ]; then
        echo -n 'Not adding '$line | tee -a -i $outputfilefqfn
    else 
        IFARRAY+=("$line")
    	echo -n $line | tee -a -i $outputfilefqfn
    fi
	
	arraylength=${#IFARRAY[@]}
	arrayelement=$((arraylength-1))
	
done <<< "$GETINTERFACES"

echo | tee -a -i $outputfilefqfn

echo | tee -a -i $outputfilefqfn
echo '----------------------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
echo | tee -a -i $outputfilefqfn

echo 'Identified Interfaces in array for detail data collection :' | tee -a -i $outputfilefqfn
echo | tee -a -i $outputfilefqfn

for j in "${IFARRAY[@]}"
do
    #echo "$j, ${j//\'/}"  | tee -a -i $outputfilefqfn
    echo $j | tee -a -i $outputfilefqfn
done
echo | tee -a -i $outputfilefqfn

echo | tee -a -i $outputfilefqfn
echo '----------------------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
echo | tee -a -i $outputfilefqfn

export ifshortoutputfile=$outputfileprefix'_'$command2run'_short'$outputfilesuffix$outputfiletype
export ifshortoutputfilefqfn=$outputfilepath$ifshortoutputfile

touch $ifshortoutputfilefqfn
echo | tee -a -i $ifshortoutputfilefqfn
echo '----------------------------------------------------------------------------------------' | tee -a -i $ifshortoutputfilefqfn

for i in "${IFARRAY[@]}"
do

    export currentinterface=$i
    
    export chkinterface4=`expr substr $i 1 4`
    
    #Check if the interface is a bond interface
    
    export bondckeck=`[[ 'bond' = $chkinterface4 ]]; echo $?`
    if [ $bondckeck -eq 0 ] ; then export interfaceisbond=true; else export interfaceisbond=false; fi
    
    #------------------------------------------------------------------------------------------------------------------
    # Short Information
    #------------------------------------------------------------------------------------------------------------------
    
    echo 'Interface : '$i | tee -a -i $ifshortoutputfilefqfn
    ifconfig $i | grep -i HWaddr | tee -a -i $ifshortoutputfilefqfn
    if $interfaceisbond ; then
        echo 'bond interface' | tee -a -i $ifshortoutputfilefqfn
    else
        ethtool -i $i | grep -i bus | tee -a -i $ifshortoutputfilefqfn
    fi
    echo '----------------------------------------------------------------------------------------' | tee -a -i $ifshortoutputfilefqfn
    
    #------------------------------------------------------------------------------------------------------------------
    # Detailed Information
    #------------------------------------------------------------------------------------------------------------------
    
    export interfaceoutputfile=$outputfileprefix'_'$command2run'_'$i$outputfilesuffix$outputfiletype
    export interfaceoutputfilefqfn=$outputfilepath$interfaceoutputfile
    
    echo 'Executing commands for interface : '$currentinterface' with output to file : '$interfaceoutputfilefqfn | tee -a -i $outputfilefqfn
    #echo | tee -a -i $outputfilefqfn
    
    echo >> $interfaceoutputfilefqfn
    echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
    echo 'Execute clish -i -c "show interface '$i'"' >> $interfaceoutputfilefqfn
    echo >> $interfaceoutputfilefqfn
    
    clish -i -c "show interface $i" >> $interfaceoutputfilefqfn
    
    InterfacesDoCommandAndDocument ifconfig $i
    
    #------------------------------------------------------------------------------------------------------------------
    # Detailed Information not available for bond interfaces
    #------------------------------------------------------------------------------------------------------------------
    
    if $interfaceisbond ; then
        # bond interface, skip details not relevant for bond interfaces
        
        echo >> $interfaceoutputfilefqfn
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        echo 'Interface '$i' is bond interface so no further details relevant or available!' >> $interfaceoutputfilefqfn
        echo 'Interface '$i' is bond interface so no further details relevant or available!' | tee -a -i $ifshortoutputfilefqfn
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        echo >> $interfaceoutputfilefqfn
        
    else
        # not a bond interface, so drill down available details for the interface
        
        echo >> $interfaceoutputfilefqfn
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        echo 'Interface '$i' is not a bond, so drill into further details!' >> $interfaceoutputfilefqfn
        echo 'Interface '$i' is not a bond, so drill into further details!' | tee -a -i $ifshortoutputfilefqfn
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        
        echo >> $interfaceoutputfilefqfn
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        echo 'Execute clish -i -c "show interface '$i' rx-ringsize"' >> $interfaceoutputfilefqfn
        echo >> $interfaceoutputfilefqfn
        
        clish -i -c "show interface $i rx-ringsize" >> $interfaceoutputfilefqfn
        
        echo >> $interfaceoutputfilefqfn
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        echo 'Execute clish -i -c "show interface '$i' tx-ringsize"' >> $interfaceoutputfilefqfn
        echo >> $interfaceoutputfilefqfn
        
        clish -i -c "show interface $i tx-ringsize" >> $interfaceoutputfilefqfn
        
        echo >> $interfaceoutputfilefqfn
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        echo 'Execute clish -i -c show interface '$i' multi-queue verbose"' >> $interfaceoutputfilefqfn
        echo >> $interfaceoutputfilefqfn
        
        clish -i -c "show interface $i multi-queue verbose" >> $interfaceoutputfilefqfn
        
        echo >> $interfaceoutputfilefqfn
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        
        InterfacesDoCommandAndDocument ethtool $i
        InterfacesDoCommandAndDocument ethtool -a $i
        InterfacesDoCommandAndDocument ethtool -i $i
        InterfacesDoCommandAndDocument ethtool -g $i
        InterfacesDoCommandAndDocument ethtool -k $i
        InterfacesDoCommandAndDocument ethtool -S $i
        
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        echo 'Execute grep of driver for '$i >> $interfaceoutputfilefqfn
        echo >> $interfaceoutputfilefqfn
        
        export interfacedriver=`ethtool -i $i | grep -i "driver:" | cut -d " " -f 2`
        InterfacesDoCommandAndDocument modinfo $interfacedriver
        
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        echo 'Execute grep of dmesg for '$i >> $interfaceoutputfilefqfn
        echo >> $interfaceoutputfilefqfn
        
        cat $dmesgfilefqfn | grep -i $i >> $interfaceoutputfilefqfn
        
        echo >> $interfaceoutputfilefqfn
        echo '----------------------------------------------------------------------------------------' >> $interfaceoutputfilefqfn
        
    fi
    
    #------------------------------------------------------------------------------------------------------------------
    # Dump Detailed interface Information into consolidated interface file
    #------------------------------------------------------------------------------------------------------------------
    
    cat $interfaceoutputfilefqfn >> $outputfilefqfn
    echo >> $outputfilefqfn
    
    echo >> $outputfilefqfn
    echo '----------------------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
    echo >> $outputfilefqfn
    
done

echo | tee -a -i $outputfilefqfn
echo '----------------------------------------------------------------------------------------' | tee -a -i $outputfilefqfn
echo | tee -a -i $outputfilefqfn


#----------------------------------------------------------------------------------------
# bash - collect /etc/sysconfig/network and backup if it exists
#----------------------------------------------------------------------------------------

# /etc/sysconfig/network
export file2copy=network
export file2copypath="/etc/sysconfig/$file2copy"

export outputfilenameaddon=
CopyFileAndDump2FQDNOutputfile

export file2find=modprobe.conf


#----------------------------------------------------------------------------------------
# bash - gather interface details from /etc/sysconfig/networking
#----------------------------------------------------------------------------------------

# /etc/sysconfig/networking

export command2run=etc_sysconfig_networking
export sourcepath=/etc/sysconfig/networking

CopyFiles2CaptureFolder

#----------------------------------------------------------------------------------------
# bash - gather interface details from /etc/sysconfig/network-scripts
#----------------------------------------------------------------------------------------

# /etc/sysconfig/network-scripts

export command2run=etc_sysconfig_networking_scripts
export sourcepath=/etc/sysconfig/network-scripts

CopyFiles2CaptureFolder

#----------------------------------------------------------------------------------------
# bash - gather interface name rules
#----------------------------------------------------------------------------------------

export command2run=interfaces_naming_rules
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

export file2copy=00-OS-XX.rules
export file2copypath="/etc/udev/rules.d/$file2copy"

export outputfilenameaddon=
CopyFileAndDump2FQDNOutputfile

export file2find=$file2copy

FindFilesAndCollectIntoArchiveAllVariants


export file2copy=00-ANACONDA.rules
export file2copypath="/etc/sysconfig/$file2copy"

export outputfilenameaddon=
CopyFileAndDump2FQDNOutputfile

export file2find=$file2copy

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# bash - collect /etc/sysconfig/hwconf and backup if it exists
#----------------------------------------------------------------------------------------

# /etc/sysconfig/hwconf
export file2copy=hwconf
export file2copypath="/etc/sysconfig/$file2copy"

export outputfilenameaddon=
CopyFileAndDump2FQDNOutputfile

export file2find=$file2copy

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
# Special files to collect and backup (at some time)
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#
#    smartlog_settings.conf
#
#    user.def - sk98239 (Location of 'user.def' file on Management Server
#
#    table.def - sk98339 (Location of 'table.def' files on Management Server)
#
#    crypt.def - sk98241 (Location of 'crypt.def' files on Security Management Server)
#    crypt.def - sk108600 (VPN Site-to-Site with 3rd party)
#
#    implied_rules.def - sk92281 (Creating customized implied rules for Check Point Security Gateway - 'implied_rules.def' file)
#
#    base.def - sk95147 (Modifying definitions of packet inspection on Security Gateway for different protocols - 'base.def' file)
#
#    vpn_table.def - sk92332 (Customizing the VPN configuration for Check Point Security Gateway - 'vpn_table.def' file)
#
#    rtsp.def - sk35945 (RTSP traffic is dropped when SecureXL is enabled)
#
#    ftp.def - sk61781 (FTP packet is dropped - Attack Information: The packet was modified due to a potential Bounce Attack Evasion Attempt (Telnet Options))
#
#    DCE RPC files - sk42402 (Legitimate DCE-RPC (MS DCOM) bind packets dropped by IPS)
#

# tar czvf user.def.$(date +%Y%m%d-%H%M%S).tgz $(find / -name user.def 2> /dev/null)
# tar czvf user.def.$(date +%Y%m%d-%H%M%S).tgz $(find / -name user.def 2> /dev/null)
#

#----------------------------------------------------------------------------------------
# bash - collect $SMARTLOGDIR/conf/smartlog_settings.conf and backup if it exists
#----------------------------------------------------------------------------------------

# $SMARTLOGDIR/conf/smartlog_settings.conf
export file2copy=smartlog_settings.conf
export file2copypath="$SMARTLOGDIR/conf/$file2copy"

export outputfilenameaddon=
#CopyFileAndDump2FQDNOutputfile

if [[ $sys_type_MDS = 'true' ]] ; then
    
    # HANDLE MDS and Domains

    # HANDLE MDS
    export outputfilenameaddon=MDS_

	CopyFileAndDump2FQDNOutputfile

    # HANDLE MDS Domains

else
    # System is not MDS, so no need to cycle through domains
    
	CopyFileAndDump2FQDNOutputfile
fi

export file2find=$file2copy

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# bash - identify user.def files - sk98239
#----------------------------------------------------------------------------------------

# $FWDIR/conf/user.def
export file2find=user.def

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# bash - identify table.def files - sk98339
#----------------------------------------------------------------------------------------

# $FWDIR/lib/table.def
export file2find=table.def

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# bash - identify crypt.def files - sk98241 and sk108600
#----------------------------------------------------------------------------------------

#
#    crypt.def - sk98241 (Location of 'crypt.def' files on Security Management Server)
#    crypt.def - sk108600 (VPN Site-to-Site with 3rd party)
#

export file2find=crypt.def

FindFilesAndCollectIntoArchiveAllVariants

#----------------------------------------------------------------------------------------
# bash - identify implied_rules.def files - sk92281
#----------------------------------------------------------------------------------------

#
#    implied_rules.def - sk92281 (Creating customized implied rules for Check Point Security Gateway - 'implied_rules.def' file)
#

export file2find=implied_rules.def

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# base.def - sk95147 (Modifying definitions of packet inspection on Security Gateway for different protocols - 'base.def' file)
#----------------------------------------------------------------------------------------

# 
export file2find=base.def

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# vpn_table.def - sk92332 (Customizing the VPN configuration for Check Point Security Gateway - 'vpn_table.def' file)
#----------------------------------------------------------------------------------------

# 
export file2find=vpn_table.def

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# rtsp.def - sk35945 (RTSP traffic is dropped when SecureXL is enabled)
#----------------------------------------------------------------------------------------

# 
export file2find=rtsp.def

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# ftp.def - sk61781 (FTP packet is dropped - Attack Information: The packet was modified due to a potential Bounce Attack Evasion Attempt (Telnet Options))
#----------------------------------------------------------------------------------------

# 
export file2find=ftp.def

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# bash - collect /opt/CPUserCheckPortal/phpincs/conf/TPAPI.ini and backup if it exists
#----------------------------------------------------------------------------------------

# /opt/CPUserCheckPortal/phpincs/conf/TPAPI.ini
export file2copy=TPAPI.ini
export file2copypath="/opt/CPUserCheckPortal/phpincs/conf/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
# files to collect sk160392 - List of Check Point Configuration Files on a Security Gateway that need to be re-configured after performing a clean installation on a Security Gateway 
#----------------------------------------------------------------------------------------

# Note: Some of these might not exist by default and may need to be created manually.
# 
# Note: Some of these might not be relevant, depending on whether these existed on the Security Gateway previously.
# 
# 
#     $FWDIR/boot/modules/fwkern.conf 
#     $FWDIR/boot/modules/vpnkern.conf 
#     $PPKDIR/boot/modules/simkern.conf 
# R80.40
#     $PPKDIR/conf/simkern.conf 
#     $PPKDIR/boot/modules/sim_aff.conf 
#     $FWDIR/conf/fwaffinity.conf 
#     $FWDIR/conf/fwauthd.conf 
#     $FWDIR/conf/local.arp 
#     $FWDIR/conf/discntd.if 
#     $FWDIR/conf/cpha_bond_ls_config.conf 
#     $FWDIR/conf/resctrl 
#     $FWDIR/conf/vsaffinity_exception.conf 
#     $FWDIR/database/qos_policy.C
# 


#----------------------------------------------------------------------------------------
# Create directories to store the *.conf files
#----------------------------------------------------------------------------------------

export conffilespathroot=$outputpathroot/conf_files
export conffilespathFWDIRbootmodules=$conffilespathroot/FWDIR_boot_modules
export conffilespathPPKDIRbootmodules=$conffilespathroot/PPKDIR_boot_modules
export conffilespathPPKDIRconf=$conffilespathroot/PPKDIR_conf
export conffilespathFWDIRconf=$conffilespathroot/FWDIR_conf
export conffilespathFWDIRdatabase=$conffilespathroot/FWDIR_database

if [ ! -r $conffilespathroot ] ; then
    mkdir -pv $conffilespathroot
    chmod 775 $conffilespathroot
else
    #set permissions we need
    chmod 775 $conffilespathroot
fi

if [ ! -r $conffilespathFWDIRbootmodules ] ; then
    mkdir -pv $conffilespathFWDIRbootmodules
    chmod 775 $conffilespathFWDIRbootmodules
else
    #set permissions we need
    chmod 775 $conffilespathFWDIRbootmodules
fi

if [ ! -r $conffilespathPPKDIRbootmodules ] ; then
    mkdir -pv $conffilespathPPKDIRbootmodules
    chmod 775 $conffilespathPPKDIRbootmodules
else
    #set permissions we need
    chmod 775 $conffilespathPPKDIRbootmodules
fi

if [ ! -r $conffilespathPPKDIRconf ] ; then
    mkdir -pv $conffilespathPPKDIRconf
    chmod 775 $conffilespathPPKDIRconf
else
    #set permissions we need
    chmod 775 $conffilespathPPKDIRconf
fi

if [ ! -r $conffilespathFWDIRconf ] ; then
    mkdir -pv $conffilespathFWDIRconf
    chmod 775 $conffilespathFWDIRconf
else
    #set permissions we need
    chmod 775 $conffilespathFWDIRconf
fi

if [ ! -r $conffilespathFWDIRdatabase ] ; then
    mkdir -pv $conffilespathFWDIRdatabase
    chmod 775 $conffilespathFWDIRdatabase
else
    #set permissions we need
    chmod 775 $conffilespathFWDIRdatabase
fi

#if [ -r $file2copypath ] ; then
    #cp "$file2copypath" $conffilespathFWDIRbootmodules &>> $outputfilefqfn
    #cp "$file2copypath" $conffilespathPPKDIRbootmodules &>> $outputfilefqfn
    #cp "$file2copypath" $conffilespathPPKDIRconf &>> $outputfilefqfn
    #cp "$file2copypath" $conffilespathFWDIRconf &>> $outputfilefqfn
    #cp "$file2copypath" $conffilespathFWDIRdatabase &>> $outputfilefqfn
#fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/boot/modules/fwkern.conf and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/boot/modules/fwkern.conf
export file2copy=fwkern.conf
export file2copypath="$FWDIR/boot/modules/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRbootmodules &>> $outputfilefqfn
fi

if [ -r $file2copypath ] ; then
    cp "$file2copypath" . &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/boot/modules/vpnkern.conf and backup if it exists  - SK101219 and sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/boot/modules/vpnkern.conf
export file2copy=vpnkern.conf
export file2copypath="$FWDIR/boot/modules/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRbootmodules &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $PPKDIR/boot/modules/simkern.conf and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $PPKDIR/boot/modules/simkern.conf
export file2copy=simkern.conf
export file2copypath="$PPKDIR/boot/modules/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathPPKDIRbootmodules &>> $outputfilefqfn
fi

# At some version this moved and $PPKDIR/boot/modules/simkern.conf was deprecated
# $PPKDIR/conf/simkern.conf
export file2copy=simkern.conf
export file2copypath="$PPKDIR/conf/$file2copy"

export outputfilenameaddon=alternate

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathPPKDIRconf &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $PPKDIR/boot/modules/simkern.conf and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $PPKDIR/boot/modules/sim_aff.conf
export file2copy=sim_aff.conf
export file2copypath="$PPKDIR/boot/modules/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathPPKDIRbootmodules &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/conf/fwaffinity.conf and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/conf/fwaffinity.conf
export file2copy=fwaffinity.conf
export file2copypath="$FWDIR/conf/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRconf &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/conf/fwauthd.conf and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/conf/fwauthd.conf
export file2copy=fwauthd.conf
export file2copypath="$FWDIR/conf/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRconf &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/conf/local.arp and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/conf/local.arp
export file2copy=local.arp
export file2copypath="$FWDIR/conf/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRconf &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/conf/discntd.if and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/conf/discntd.if
export file2copy=discntd.if
export file2copypath="$FWDIR/conf/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRconf &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/conf/cpha_bond_ls_config.conf  and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/conf/cpha_bond_ls_config.conf
export file2copy=cpha_bond_ls_config.conf
export file2copypath="$FWDIR/conf/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRconf &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/conf/resctrl  and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/conf/resctrl
export file2copy=resctrl
export file2copypath="$FWDIR/conf/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRconf &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/conf/vsaffinity_exception.conf  and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/conf/vsaffinity_exception.conf
export file2copy=vsaffinity_exception.conf
export file2copypath="$FWDIR/conf/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRconf &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/database/qos_policy.C  and backup if it exists - sk160392
#----------------------------------------------------------------------------------------

# $FWDIR/database/qos_policy.C
export file2copy=qos_policy.C
export file2copypath="$FWDIR/database/$file2copy"

export outputfilenameaddon=

CopyFileAndDump2FQDNOutputfile

if [ -r $file2copypath ] ; then
    cp "$file2copypath" $conffilespathFWDIRdatabase &>> $outputfilefqfn
fi


#----------------------------------------------------------------------------------------
# files to collect sk160392 - List of Check Point Configuration Files on a Security Gateway that need to be re-configured after performing a clean installation on a Security Gateway 
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------


#----------------------------------------------------------------------------------------
# bash - collect $FWDIR/conf/malware_config and copy if it exists
#----------------------------------------------------------------------------------------

# /etc/modprobe.conf
export file2copy=malware_config
export file2copypath="$FWDIR/conf"

export outputfilenameaddon=
CopyFileAndDump2FQDNOutputfile

export file2find=malware_config

FindFilesAndCollectIntoArchiveAllVariants


#----------------------------------------------------------------------------------------
# bash - GW - status of SecureXL
#----------------------------------------------------------------------------------------

if [ $Check4GW -eq 1 ]; then
    
    export command2run=fwaccel-statistics

    DoCommandAndDocument fwaccel stat
    DoCommandAndDocument fwaccel stats
    DoCommandAndDocument fwaccel stats -s
    DoCommandAndDocument fwaccel stats -p
    DoCommandAndDocument fwaccel templates
    DoCommandAndDocument fwaccel templates -S
    DoCommandAndDocument fwaccel ranges -l
    DoCommandAndDocument fwaccel ranges

fi


#----------------------------------------------------------------------------------------
# bash - Management Systems Information
#----------------------------------------------------------------------------------------

if [[ $sys_type_MDS = 'true' ]] ; then

    export command2run=cpwd_admin
    export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
    export outputfilefqfn=$outputfilepath$outputfile
    
    echo
    echo 'Execute '$command2run' with output to : '$outputfilefqfn
    
    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    echo '$FWDIR_PATH/scripts/cpm_status.sh' >> "$outputfilefqfn"
    echo | tee -a -i "$outputfilefqfn"
    
    if $IsR8XVersion; then
        # cpm_status.sh only exists in R8X
        $MDS_FWDIR/scripts/cpm_status.sh | tee -a -i "$outputfilefqfn"
        echo | tee -a -i "$outputfilefqfn"
    else
        echo | tee -a -i "$outputfilefqfn"
    fi

    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    echo 'mdsstat' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    
    export COLUMNS=128
    mdsstat >> "$outputfilefqfn"

    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    echo 'cpwd_admin list' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    
    cpwd_admin list >> "$outputfilefqfn"

elif [[ $sys_type_SMS = 'true' ]] || [[ $sys_type_SmartEvent = 'true' ]] ; then

    export command2run=cpwd_admin
    export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
    export outputfilefqfn=$outputfilepath$outputfile
    
    echo >> "$outputfilefqfn"
    echo 'Execute Command with output to Output Path : ' >> "$outputfilefqfn"
    echo ' - Execute Command    : '$command2run >> "$outputfilefqfn"
    echo ' - Output Path        : '$outputfilefqfn >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    command >> "$outputfilefqfn"
    
    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    echo '$MDS_FWDIR/scripts/cpm_status.sh' >> "$outputfilefqfn"
    echo | tee -a -i "$outputfilefqfn"
    
    if $IsR8XVersion; then
        # cpm_status.sh only exists in R8X
        $MDS_FWDIR/scripts/cpm_status.sh | tee -a -i "$outputfilefqfn"
        echo | tee -a -i "$outputfilefqfn"
    else
        echo | tee -a -i "$outputfilefqfn"
    fi

    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    echo 'cpwd_admin list' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    
    cpwd_admin list >> "$outputfilefqfn"

fi

echo | tee -a -i "$outputfilefqfn"


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#


#----------------------------------------------------------------------------------------
# API Information
#----------------------------------------------------------------------------------------

if $IsR8XVersion; then
    # api currently only exists in R8X
    echo 'Check if we have API and Gaia REST API and report...'

    if [[ $sys_type_SMS = 'true' ]] || [[ $sys_type_SmartEvent = 'true' ]] ||  [[ $sys_type_MDS = 'true' ]]; then
        # Management API is possible only on management server

        export command2run=api_status
    
        DoCommandAndDocument api status
    fi

    rpm -q gaia_api &> /dev/null
    if [ $? -eq 0 ]; then
        # Gaia REST API installed
        export command2run=gaia_api_status
    
        DoCommandAndDocument gaia_api status
    fi

else
    # api currently only exists in R8X
    echo 'No API or Gaia REST API in this version...'
fi
echo


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#

#----------------------------------------------------------------------------------------
# bash - GW - status of Identity Awareness
#----------------------------------------------------------------------------------------

if [ $Check4GW -eq 1 ]; then
    
    echo 'Check Status of Identity Awareness'
    echo

    export command2run=identity_awareness_details

    DoCommandAndDocument pdp status show
    DoCommandAndDocument pep show pdp all
    DoCommandAndDocument pdp auth kerberos_encryption get
    
fi


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#

#----------------------------------------------------------------------------------------
# bash - process listing
#----------------------------------------------------------------------------------------

export command2run=ps_process_status
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo
echo 'Execute '$command2run' with output to : '$outputfilefqfn

echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'ps -AFM -- process listing' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

ps -AFM >> "$outputfilefqfn"

echo >> "$outputfilefqfn"

echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo | tee -a -i "$outputfilefqfn"


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#

#----------------------------------------------------------------------------------------
# bash - Port utilization and potential overlaps
#----------------------------------------------------------------------------------------

export command2run=netstat
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo
echo 'Execute '$command2run' with output to : '$outputfilefqfn

echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'netstat -nap -- Ports used' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

netstat -nap >> "$outputfilefqfn"

echo >> "$outputfilefqfn"

echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo | tee -a -i "$outputfilefqfn"


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#

#----------------------------------------------------------------------------------------
# bash - Port utilization and potential overlaps - Endpoint Management (EPM)
#----------------------------------------------------------------------------------------

export command2run=netstat_for_EPM
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo
echo 'Execute '$command2run' with output to : '$outputfilefqfn

echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'netstat -nap | grep 8080 -- Endpoint Port use of 8080' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

netstat -nap | grep 8080 >> "$outputfilefqfn"

echo >> "$outputfilefqfn"

echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'netstat -nap | grep 8009 -- Endpoint Port use of 8009' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

netstat -nap | grep 8009 >> "$outputfilefqfn"

echo >> "$outputfilefqfn"

echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'netstat -nap | grep 8005 -- Endpoint Port use of 8005' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

netstat -nap | grep 8005 >> "$outputfilefqfn"

echo >> "$outputfilefqfn"

echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'netstat -nap | grep 80 -- Endpoint Port use of 80' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

netstat -nap | grep 80 >> "$outputfilefqfn"

echo >> "$outputfilefqfn"

echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'netstat -nap | grep 443 -- Endpoint Port use of 443' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

netstat -nap | grep 443 >> "$outputfilefqfn"

echo >> "$outputfilefqfn"

echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo 'netstat -nap | grep 4434 -- Endpoint Port use of 4434' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

netstat -nap | grep 4434 >> "$outputfilefqfn"

echo >> "$outputfilefqfn"

echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
echo | tee -a -i "$outputfilefqfn"


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#

#----------------------------------------------------------------------------------------
# bash - Document TLS Version in use
#----------------------------------------------------------------------------------------

export command2run=Check_TLS_Version
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo
echo 'Execute '$command2run' with output to : '$outputfilefqfn

cpopenssl ciphers -v `more /web/templates/httpd-ssl.conf.templ | grep SSLCipherSuite` | grep -i tls | awk '{print $2}' | sort --unique | tee -a -i "$outputfilefqfn"

echo


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#

#----------------------------------------------------------------------------------------
# bash - Gateway Threat Prevention TEX Information
#----------------------------------------------------------------------------------------

export command2run=Gateway_TEX_Info
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

if [ "$sys_type_GW" == "true" ]; then
    
    echo >> "$outputfilefqfn"
    echo 'Execute '$command2run' with output to : '$outputfilefqfn | tee -a -i "$outputfilefqfn"
    
    echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    echo 'Check TEX service DNS information:' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    
    nslookup -query=SRV te.checkpoint.com >> "$outputfilefqfn"
    
    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
    
    DoCommandAndDocument cpstat threat-emulation -f default
    DoCommandAndDocument cat $FWDIR/teCurrentPack/te_ver.ini
    DoCommandAndDocument tecli advanced cloud geo status
    DoCommandAndDocument tecli show downloads all
    DoCommandAndDocument tecli advanced analyzer show
    DoCommandAndDocument tecli advanced engine version
    DoCommandAndDocument tecli advanced wem status
    DoCommandAndDocument tecli show downloads images all
    
    #DoCommandAndDocument 
    
    echo >> "$outputfilefqfn"
    echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    
else
    echo 'Not a gateway, not checking TEX info'
fi


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#


#----------------------------------------------------------------------------------------
# bash - ?what next?
#----------------------------------------------------------------------------------------

#export command2run=command
#export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
#export outputfilefqfn=$outputfilepath$outputfile

#echo
#echo 'Execute '$command2run' with output to : '$outputfilefqfn
#$command2run > "$outputfilefqfn"

#echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
#echo >> "$outputfilefqfn"
#echo 'fwacell stats -s' >> "$outputfilefqfn"
#echo >> "$outputfilefqfn"
#
#fwaccel stats -s >> "$outputfilefqfn"
#


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
#


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
# clish operations - might have issues if user is in Gaia webUI
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------


echo | tee -a $logfilepath
echo 'Execute clish opertations with common log in : '$clishoutputfilefqfn | tee -a $logfilepath
echo | tee -a $logfilepath

export command2run=clish_commands
export clishoutputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export clishoutputfilefqfn=$outputfilepath$clishoutputfile

echo | tee -a $clishoutputfilefqfn
echo 'Execute clish opertations with common log in : '$clishoutputfilefqfn | tee -a $clishoutputfilefqfn
echo | tee -a $clishoutputfilefqfn


#----------------------------------------------------------------------------------------
# clish - save configuration to file
#----------------------------------------------------------------------------------------

export command2run=clish_config
export configfile=$command2run'_'$outputfileprefix$outputfilesuffix
export configfilefqfn=$outputfilepath$configfile
export outputfile=$command2run'_'$outputfileprefix$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo | tee -a $outputfilefqfn
echo 'Execute '$command2run' with output to : '$configfilefqfn | tee -a $outputfilefqfn
echo | tee -a $outputfilefqfn

CheckAndUnlockGaiaDB

clish -i -s -c "save configuration $configfile" >> $outputfilefqfn

cp "$configfile" "$configfilefqfn" >> $outputfilefqfn
cp "$configfile" "$configfilefqfn.txt" >> $outputfilefqfn

cat $outputfilefqfn >> $clishoutputfilefqfn

#----------------------------------------------------------------------------------------
# clish - show assets
#----------------------------------------------------------------------------------------

export command2run=clish_assets
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo | tee -a $clishoutputfilefqfn
echo 'Execute Command with output to Output Path : ' | tee -a -i $clishoutputfilefqfn
echo ' - Execute Command    : '$command2run | tee -a -i $clishoutputfilefqfn
echo ' - Output Path        : '$outputfilefqfn | tee -a -i $clishoutputfilefqfn
echo | tee -a $clishoutputfilefqfn

echo >> "$outputfilefqfn"
echo 'Execute Command with output to Output Path : ' >> "$outputfilefqfn"
echo ' - Execute Command    : '$command2run >> "$outputfilefqfn"
echo ' - Output Path        : '$outputfilefqfn >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo 'clish show asset all :' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

CheckAndUnlockGaiaDB

clish -i -c "show asset all" >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo 'clish show asset system :' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

CheckAndUnlockGaiaDB

clish -i -c "show asset system" >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

cat $outputfilefqfn >> $clishoutputfilefqfn


#----------------------------------------------------------------------------------------
# bash - generate hardware status information
#----------------------------------------------------------------------------------------

export command2run=hardware_status
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo | tee -a $clishoutputfilefqfn
echo 'Execute Command with output to Output Path : ' | tee -a -i $clishoutputfilefqfn
echo ' - Execute Command    : '$command2run | tee -a -i $clishoutputfilefqfn
echo ' - Output Path        : '$outputfilefqfn | tee -a -i $clishoutputfilefqfn
echo | tee -a $clishoutputfilefqfn

echo >> "$outputfilefqfn"
echo 'Execute Command with output to Output Path : ' >> "$outputfilefqfn"
echo ' - Execute Command    : '$command2run >> "$outputfilefqfn"
echo ' - Output Path        : '$outputfilefqfn >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo 'clish show asset all :' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

CheckAndUnlockGaiaDB

clish -i -c "show asset all" >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo 'clish show sysenv al :' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

CheckAndUnlockGaiaDB

clish -i -c "show sysenv al" >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

cat $outputfilefqfn >> $clishoutputfilefqfn

export command2run=hardware_status
DoCommandAndDocument cpstat os -f power_supply


#----------------------------------------------------------------------------------------
# clish and bash - Gather version information from all possible methods
#----------------------------------------------------------------------------------------

export command2run=versions
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo | tee -a $clishoutputfilefqfn
echo 'Execute Command with output to Output Path : ' | tee -a -i $clishoutputfilefqfn
echo ' - Execute Command    : '$command2run | tee -a -i $clishoutputfilefqfn
echo ' - Output Path        : '$outputfilefqfn | tee -a -i $clishoutputfilefqfn
echo | tee -a $clishoutputfilefqfn

echo >> "$outputfilefqfn"
echo 'Execute Command with output to Output Path : ' >> "$outputfilefqfn"
echo ' - Execute Command    : '$command2run >> "$outputfilefqfn"
echo ' - Output Path        : '$outputfilefqfn >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

touch $outputfilefqfn
echo 'Versions:' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo 'uname for kernel version : ' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
uname -a >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo 'clish : ' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

CheckAndUnlockGaiaDB

clish -i -c "show version all" >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
clish -i -c "show version os build" >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo 'cpinfo -y all : ' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
cpinfo -y all >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo 'fwm ver : ' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
fwm ver >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo 'fw ver : ' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
fw ver >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
echo 'cpvinfo $MDS_FWDIR/cpm-server/dleserver.jar : ' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"
cpvinfo $MDS_FWDIR/cpm-server/dleserver.jar >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

echo >> "$outputfilefqfn"
echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"

if $IsR8XVersion; then
    # installed_jumbo_take only exists in R7X
    echo >> "$outputfilefqfn"
else
    echo >> "$outputfilefqfn"
    echo 'installed_jumbo_take : ' >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
    installed_jumbo_take >> "$outputfilefqfn"
    echo >> "$outputfilefqfn"
fi

echo '----------------------------------------------------------------------------' >> "$outputfilefqfn"
echo >> "$outputfilefqfn"

cat $outputfilefqfn >> $clishoutputfilefqfn


#----------------------------------------------------------------------------------------
# clish and bash - Gather ClusterXL information from all possible methods if it is a cluster
#----------------------------------------------------------------------------------------

export command2run=ClusterXL
export outputfile=$outputfileprefix'_'$command2run$outputfilesuffix$outputfiletype
export outputfilefqfn=$outputfilepath$outputfile

echo
echo 'ClusterXL information - if relevant'
echo

if [ "$sys_type_GW" == "true" ]; then
    
    echo 'A Gateway so maybe ClusterXL'
    
    if [[ $(cpconfig <<< 10 | grep cluster) == *"Disable"* ]]; then
        # is a cluster
        echo 'A cluster member.'
        echo
    
        touch $outputfilefqfn
    
        DoCommandAndDocument cphaprob state
        DoCommandAndDocument cphaprob mmagic
        DoCommandAndDocument cphaprob -a if
        DoCommandAndDocument cphaprob -ia list
        DoCommandAndDocument cphaprob -l list
        DoCommandAndDocument cphaprob syncstat
        DoCommandAndDocument cpstat ha -f all
        
        echo | tee -a -i "$outputfilefqfn"
        echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
        echo 'Execute Command with output to Output Path : ' | tee -a -i "$outputfilefqfn"
        echo ' - Execute Command    : '$command2run | tee -a -i "$outputfilefqfn"
        echo ' - Output Path        : '$outputfilefqfn | tee -a -i "$outputfilefqfn"
        echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
        echo 'Sync Status : fw ctl pstat | grep -A50 Sync:' | tee -a -i "$outputfilefqfn"
        echo >> "$outputfilefqfn"
    
        fw ctl pstat | grep -A50 Sync: >> "$outputfilefqfn"
    
        echo >> "$outputfilefqfn"
        echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
        echo | tee -a -i "$outputfilefqfn"
        
        echo | tee -a -i "$outputfilefqfn"
        echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
        echo 'Execute Command with output to Output Path : ' | tee -a -i "$outputfilefqfn"
        echo ' - Execute Command    : '$command2run | tee -a -i "$outputfilefqfn"
        echo ' - Output Path        : '$outputfilefqfn | tee -a -i "$outputfilefqfn"
        echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
        echo 'clish -c "show routed cluster-state detailed"' >> "$outputfilefqfn"
        echo >> "$outputfilefqfn"
    
        CheckAndUnlockGaiaDB
    
        clish -c "show routed cluster-state detailed" >> "$outputfilefqfn"
        
        echo >> "$outputfilefqfn"
        echo '----------------------------------------------------------------------------' | tee -a -i "$outputfilefqfn"
        echo | tee -a -i "$outputfilefqfn"
    else
        # is not a cluster
        echo 'Not a cluster member.'
        echo
    fi
else

    echo 'Not a Gateway so no ClusterXL'

fi


cat $outputfilefqfn >> $clishoutputfilefqfn


#----------------------------------------------------------------------------------------
# Wrap-up the common log for clish including operations
#----------------------------------------------------------------------------------------

echo | tee -a $clishoutputfilefqfn
echo 'opertations clish with common log in completed!' | tee -a $clishoutputfilefqfn
echo | tee -a $clishoutputfilefqfn


#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
# End of clish operations - might have issues if user is in Gaia webUI
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------


#==================================================================================================
#==================================================================================================
#
# END :  Collect and Capture Configuration and Information data
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
echo 'List files : '$outputpathbase'/fw*' | tee -a -i $logfilepath
ls -alh $outputpathroot/fw* | tee -a -i $logfilepath
echo | tee -a -i $logfilepath

echo >> $logfilepath
echo 'Output location for all results is here : '$outputpathbase >> $logfilepath
echo 'Log results documented in this log file : '$logfilepath >> $logfilepath
echo >> $logfilepath


#==================================================================================================
#==================================================================================================
#
# Archive results for easy transport
#
#==================================================================================================
#==================================================================================================


export expandedpath=$(cd $OtherOutputFolder ; pwd)
export archivepathbase=$expandedpath
export archivefiletype=.tgz
export archivefilename=$HOSTNAME'_'$targetversion_$BASHScriptName.$DATEDTGS$archivefiletype
export archivefqfn=$archivepathbase/$archivefilename

if $OutputSubfolderScriptName ; then
    # Add script name to the Subfolder name
    export archivestartfolder=$DATEDTGS.$BASHScriptName
elif $OutputSubfolderScriptShortName ; then
    # Add short script name to the Subfolder name
    export archivestartfolder=$DATEDTGS.$BASHScriptShortName
else
    export archivestartfolder=$DATEDTGS
fi

echo | tee -a -i $logfilepath
echo '----------------------------------------------------------------------------'
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo | tee -a -i $logfilepath
echo 'Archive of operation results' | tee -a -i $logfilepath
echo ' - from '$archivepathbase/$archivestartfolder | tee -a -i $logfilepath
echo ' - to : '$archivefqfn | tee -a -i $logfilepath
echo | tee -a -i $logfilepath
echo '----------------------------------------------------------------------------' | tee -a -i $logfilepath
echo | tee -a -i $logfilepath

#tar czvf $archivefqfn --directory=$archivepathbase $outputpathbase $DATEDTGS
tar czvf $archivefqfn --directory=$archivepathbase $archivestartfolder

echo
echo '----------------------------------------------------------------------------'
echo '----------------------------------------------------------------------------'
echo


#==================================================================================================
#==================================================================================================
#
# Push Archived results to tftp server
#
#==================================================================================================
#==================================================================================================

export archivetftptargetfolder=$tftptargetfolder_root/$BASHScripttftptargetfolder
export archivetftpfilefqfn=$archivetftptargetfolder/$archivefilename

if $EXPORTRESULTSTOTFPT ; then
    
    if [ ! -z $MYTFTPSERVER ]; then
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo 'Push archive file : '$archivefqfn
        echo ' - to tftp server : '$MYTFTPSERVER
        echo ' - target path    : '$archivetftpfilefqfn
        echo '----------------------------------------------------------------------------'
        echo
        
        tftp -v -m binary $MYTFTPSERVER -c put $archivefqfn $archivetftpfilefqfn
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo
        
    else
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo 'tftp server value $MYTFTPSERVER not set!'
        echo '  Not executing push to that tftp server!'
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo
        
    fi

    if [ ! -z $MYTFTPSERVER1 ] && [ $MYTFTPSERVER1 != $MYTFTPSERVER ]; then
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo 'Push archive file : '$archivefqfn
        echo ' - to tftp server : '$MYTFTPSERVER1
        echo ' - target path    : '$archivetftpfilefqfn
        echo '----------------------------------------------------------------------------'
        echo
        
        tftp -v -m binary $MYTFTPSERVER1 -c put $archivefqfn $archivetftpfilefqfn
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo
        
    else
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo 'tftp server value $MYTFTPSERVER1 not set!'
        echo '  Not executing push to that tftp server!'
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo
        
    fi
    
    if [ ! -z $MYTFTPSERVER2 ] && [ $MYTFTPSERVER2 != $MYTFTPSERVER ]; then
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo 'Push archive file : '$archivefqfn
        echo ' - to tftp server : '$MYTFTPSERVER2
        echo ' - target path    : '$archivetftpfilefqfn
        echo '----------------------------------------------------------------------------'
        echo
        
        tftp -v -m binary $MYTFTPSERVER2 -c put $archivefqfn $archivetftpfilefqfn
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo
        
    else
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo 'tftp server value $MYTFTPSERVER2 not set!'
        echo '  Not executing push to that tftp server!'
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo
        
    fi
    
    if [ ! -z $MYTFTPSERVER3 ] && [ $MYTFTPSERVER3 != $MYTFTPSERVER ]; then
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo 'Push archive file : '$archivefqfn
        echo ' - to tftp server : '$MYTFTPSERVER3
        echo ' - target path    : '$archivetftpfilefqfn
        echo '----------------------------------------------------------------------------'
        echo
        
        tftp -v -m binary $MYTFTPSERVER3 -c put $archivefqfn $archivetftpfilefqfn
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo
        
    else
        
        echo
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo 'tftp server value $MYTFTPSERVER3 not set!'
        echo '  Not executing push to that tftp server!'
        echo '----------------------------------------------------------------------------'
        echo '----------------------------------------------------------------------------'
        echo
        
    fi
    
else
    
    echo
    echo '----------------------------------------------------------------------------'
    echo '----------------------------------------------------------------------------'
    echo 'tftp server results export not enabled!'
    echo '----------------------------------------------------------------------------'
    echo '----------------------------------------------------------------------------'
    echo
    
fi


#==================================================================================================
#==================================================================================================
#
# Final information to the executing script
#
#==================================================================================================
#==================================================================================================


echo
echo 'Output location for all results is here : '$outputpathbase
echo 'Log results documented in this log file : '$logfilepath
echo 'Archive of operation is here            : '$archivefqfn
echo

#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------
# End of Script
#----------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------


echo
echo 'Script Completed, exiting...';echo

