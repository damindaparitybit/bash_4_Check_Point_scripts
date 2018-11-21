#!/bin/bash
#
# SCRIPT Template for CLI Operations for command line parameters handling
#
TemplateVersion=00.32.00
CommonScriptsVersion=00.32.00
ScriptVersion=00.32.00
ScriptRevision=000
ScriptDate=2018-11-20

#

export APIActionsScriptVersion=v00x32x00
export APIActionScriptTemplateVersion=v00x32x00
ActionScriptName=cmd_line_parameters_handler.action.common.005.v$ScriptVersion

# =================================================================================================
# Validate Actions Script version is correct for caller
# =================================================================================================


if [ x"$APICommonScriptsVersion" = x"$APIActionsScriptVersion" ] ; then
    # Script and Actions Script versions match, go ahead
    echo | tee -a -i $APICLIlogfilepath
    echo 'Verify Actions Scripts Version - OK' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
else
    # Script and Actions Script versions don't match, ALL STOP!
    echo | tee -a -i $APICLIlogfilepath
    echo 'Verify Actions Scripts Version - Missmatch' | tee -a -i $APICLIlogfilepath
    echo 'Calling Script version : '$APICommonScriptsVersion | tee -a -i $APICLIlogfilepath
    echo 'Actions Script version : '$APIActionsScriptVersion | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo 'Critical Error - Exiting Script !!!!' | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath
    echo "Log output in file $APICLIlogfilepath" | tee -a -i $APICLIlogfilepath
    echo | tee -a -i $APICLIlogfilepath

    exit 250
fi


# =================================================================================================
# =================================================================================================
# START action script:  handle command line parameters
# =================================================================================================


echo | tee -a -i $APICLIlogfilepath
echo 'ActionScriptName:  '$ActionScriptName'  Script Version: '$APIActionsScriptVersion'  Revision:  '$ScriptRevision | tee -a -i $APICLIlogfilepath

# -------------------------------------------------------------------------------------------------
# Handle important basics
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# CheckAPIScriptVerboseOutput - Check if verbose output is configured externally
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-02 -\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# CheckAPIScriptVerboseOutput - Check if verbose output is configured externally via shell level 
# parameter setting, if it is, the check it for correct and valid values; otherwise, if set, then
# reset to false because wrong.
#

CheckAPIScriptVerboseOutput () {

    if [ -z $APISCRIPTVERBOSE ] ; then
        # Verbose mode not set from shell level
        echo "!! Verbose mode not set from shell level" | tee -a -i $APICLIlogfilepath
        export APISCRIPTVERBOSE=false
        echo | tee -a -i $APICLIlogfilepath
    elif [ x"`echo "$APISCRIPTVERBOSE" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
        # Verbose mode set OFF from shell level
        echo "!! Verbose mode set OFF from shell level" | tee -a -i $APICLIlogfilepath
        export APISCRIPTVERBOSE=false
        echo | tee -a -i $APICLIlogfilepath
    elif [ x"`echo "$APISCRIPTVERBOSE" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
        # Verbose mode set ON from shell level
        echo "!! Verbose mode set ON from shell level" | tee -a -i $APICLIlogfilepath
        export APISCRIPTVERBOSE=true
        echo | tee -a -i $APICLIlogfilepath
        echo 'Script :  '$0 | tee -a -i $APICLIlogfilepath
        echo 'Verbose mode enabled' | tee -a -i $APICLIlogfilepath
        echo | tee -a -i $APICLIlogfilepath
    else
        # Verbose mode set to wrong value from shell level
        echo "!! Verbose mode set to wrong value from shell level >"$APISCRIPTVERBOSE"<" | tee -a -i $APICLIlogfilepath
        echo "!! Settting Verbose mode OFF, pending command line parameter checking!" | tee -a -i $APICLIlogfilepath
        export APISCRIPTVERBOSE=false
        echo | tee -a -i $APICLIlogfilepath
    fi
    
    export APISCRIPTVERBOSECHECK=true

    echo | tee -a -i $APICLIlogfilepath
    return 0
}

#
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/-  MODIFIED 2018-05-02

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# Command Line Parameter Handling Action Script should only do this if we didn't do it in the calling script

if [ x"$APISCRIPTVERBOSECHECK" = x"true" ] ; then
    # Already checked status of $APISCRIPTVERBOSE
    echo "Status of verbose output at start of command line handler: $APISCRIPTVERBOSE"
else
    # Need to check status of $APISCRIPTVERBOSE

    CheckAPIScriptVerboseOutput

    echo "Status of verbose output at start of command line handler: $APISCRIPTVERBOSE" | tee -a -i $APICLIlogfilepath
fi


# =================================================================================================
# =================================================================================================
# START:  Command Line Parameter Handling and Help
# =================================================================================================

# MODIFIED 2018-09-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#


#
# Standard R8X API Scripts Command Line Parameters
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
# -x <export_path> | --export <export_path> | -x=<export_path> | --export=<export_path> 
# -i <import_path> | --import-path <import_path> | -i=<import_path> | --import-path=<import_path>'
# -k <delete_path> | --delete-path <delete_path> | -k=<delete_path> | --delete-path=<delete_path>'
#
# -c <csv_path> | --csv <csv_path> | -c=<csv_path> | --csv=<csv_path>'
#
# --NSO | --no-system-objects
# --SO | --system-objects
#
# --NOWAIT
#
# --CLEANUPWIP
# --NODOMAINFOLDERS
# --CSVEXPORTADDIGNOREERR
#

export SHOWHELP=false
# MODIFIED 2018-09-21 -
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
export CLIparm_exportpath=
export CLIparm_importpath=
export CLIparm_deletepath=

export CLIparm_csvpath=

# MODIFIED 2018-06-24 -
#export CLIparm_NoSystemObjects=true
export CLIparm_NoSystemObjects=false

export CLIparm_NOWAIT=
export CLIparm_CLEANUPWIP=
export CLIparm_NODOMAINFOLDERS=
export CLIparm_CSVEXPORTADDIGNOREERR=

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

# --CLEANUPWIP
#
if [ -z "$CLEANUPWIP" ]; then
    # CLEANUPWIP mode not set from shell level
    export CLIparm_CLEANUPWIP=false
elif [ x"`echo "$CLEANUPWIP" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CLEANUPWIP mode set OFF from shell level
    export CLIparm_CLEANUPWIP=false
elif [ x"`echo "$CLEANUPWIP" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CLEANUPWIP mode set ON from shell level
    export CLIparm_CLEANUPWIP=true
else
    # CLEANUPWIP mode set to wrong value from shell level
    export CLIparm_CLEANUPWIP=false
fi

# --NODOMAINFOLDERS
#
if [ -z "$NODOMAINFOLDERS" ]; then
    # NODOMAINFOLDERS mode not set from shell level
    export CLIparm_NODOMAINFOLDERS=false
elif [ x"`echo "$NODOMAINFOLDERS" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # NODOMAINFOLDERS mode set OFF from shell level
    export CLIparm_NODOMAINFOLDERS=false
elif [ x"`echo "$NODOMAINFOLDERS" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # NODOMAINFOLDERS mode set ON from shell level
    export CLIparm_NODOMAINFOLDERS=true
else
    # NODOMAINFOLDERS mode set to wrong value from shell level
    export CLIparm_NODOMAINFOLDERS=false
fi

# --CSVEXPORTADDIGNOREERR
#
if [ -z "$CSVEXPORTADDIGNOREERR" ]; then
    # CSVEXPORTADDIGNOREERR mode not set from shell level
    export CLIparm_CSVEXPORTADDIGNOREERR=false
elif [ x"`echo "$CSVEXPORTADDIGNOREERR" | tr '[:upper:]' '[:lower:]'`" = x"false" ] ; then
    # CSVEXPORTADDIGNOREERR mode set OFF from shell level
    export CLIparm_CSVEXPORTADDIGNOREERR=false
elif [ x"`echo "$CSVEXPORTADDIGNOREERR" | tr '[:upper:]' '[:lower:]'`" = x"true" ] ; then
    # CSVEXPORTADDIGNOREERR mode set ON from shell level
    export CLIparm_CSVEXPORTADDIGNOREERR=true
else
    # CLEANUPWIP mode set to wrong value from shell level
    export CLIparm_CSVEXPORTADDIGNOREERR=false
fi

export REMAINS=

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-09-21

# -------------------------------------------------------------------------------------------------
# dumpcliparmparseresults
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-03-3 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumpcliparmparseresults () {

	#
	# Testing - Dump aquired values
	#
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #                                    1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #                          01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    export outstring=
    export outstring=$outstring"Parameters : \n"

    if $UseR8XAPI ; then
    
        export outstring=$outstring"CLIparm_rootuser        ='$CLIparm_rootuser' \n"
        export outstring=$outstring"CLIparm_user            ='$CLIparm_user' \n"
        export outstring=$outstring"CLIparm_password        ='$CLIparm_password' \n"
        
        export outstring=$outstring"CLIparm_websslport      ='$CLIparm_websslport' \n"
        export outstring=$outstring"CLIparm_mgmt            ='$CLIparm_mgmt' \n"
        export outstring=$outstring"CLIparm_domain          ='$CLIparm_domain' \n"
        export outstring=$outstring"CLIparm_sessionidfile   ='$CLIparm_sessionidfile' \n"

    fi

    export outstring=$outstring"CLIparm_logpath         ='$CLIparm_logpath' \n"
    export outstring=$outstring"CLIparm_outputpath      ='$CLIparm_outputpath' \n"
    
    if [ x"$script_use_export" = x"true" ] ; then
        export outstring=$outstring"CLIparm_exportpath      ='$CLIparm_exportpath' \n"
    fi
    if [ x"$script_use_import" = x"true" ] ; then
        export outstring=$outstring"CLIparm_importpath      ='$CLIparm_importpath' \n"
    fi
    if [ x"$script_use_delete" = x"true" ] ; then
        export outstring=$outstring"CLIparm_deletepath      ='$CLIparm_deletepath' \n"
    fi
    if [ x"$script_use_csvfile" = x"true" ] ; then
        export outstring=$outstring"CLIparm_csvpath         ='$CLIparm_csvpath' \n"
    fi
    
    if $UseR8XAPI ; then
        export outstring=$outstring"CLIparm_NoSystemObjects ='$CLIparm_NoSystemObjects' \n"
    fi
	
    export outstring=$outstring"SHOWHELP                ='$SHOWHELP' \n"
    export outstring=$outstring" \n"
    export outstring=$outstring"APISCRIPTVERBOSE        ='$APISCRIPTVERBOSE' \n"
    export outstring=$outstring"NOWAIT                  ='$NOWAIT' \n"
    export outstring=$outstring"CLEANUPWIP              ='$CLEANUPWIP' \n"
    export outstring=$outstring"NODOMAINFOLDERS         ='$NODOMAINFOLDERS' \n"
    export outstring=$outstring"CSVEXPORTADDIGNOREERR   ='$CSVEXPORTADDIGNOREERR' \n"
    export outstring=$outstring" \n"
    export outstring=$outstring"CLIparm_NOWAIT          ='$CLIparm_NOWAIT' \n"

    if $UseR8XAPI ; then
        export outstring=$outstring"CLIparm_CLEANUPWIP      ='$CLIparm_CLEANUPWIP' \n"
        export outstring=$outstring"CLIparm_NODOMAINFOLDERS ='$CLIparm_NODOMAINFOLDERS' \n"
        export outstring=$outstring"C_CSVEXPORTADDIGNOREERR ='$CLIparm_CSVEXPORTADDIGNOREERR' \n"
    fi

    export outstring=$outstring" \n"
    export outstring=$outstring"remains                 ='$REMAINS' \n"
    
	if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
	    # Verbose mode ON
	    
	    echo | tee -a -i $APICLIlogfilepath
	    echo -e $outstring | tee -a -i $APICLIlogfilepath
	    echo | tee -a -i $APICLIlogfilepath
	    for i ; do echo - $i | tee -a -i $APICLIlogfilepath ; done
	    echo CLI parms - number "$#" parms "$@" | tee -a -i $APICLIlogfilepath
	    echo | tee -a -i $APICLIlogfilepath
        
    else
	    # Verbose mode ON
	    
	    echo >> $APICLIlogfilepath
	    echo -e $outstring >> $APICLIlogfilepath
	    echo >> $APICLIlogfilepath
	    for i ; do echo - $i >> $APICLIlogfilepath ; done
	    echo CLI parms - number "$#" parms "$@" >> $APICLIlogfilepath
	    echo >> $APICLIlogfilepath
        
	fi

}


#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-03-3


# -------------------------------------------------------------------------------------------------
# dumprawcliparms
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

dumprawcliparms () {
    #
    echo | tee -a -i $APICLIlogfilepath
    echo "Command line parameters before : " | tee -a -i $APICLIlogfilepath
    echo "Number parms $#" | tee -a -i $APICLIlogfilepath
    echo "parms raw : \> $@ \<" | tee -a -i $APICLIlogfilepath
    for k ; do
        echo "$k $'\t' ${k}" | tee -a -i $APICLIlogfilepath
    done
    echo | tee -a -i $APICLIlogfilepath
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-09-21


# =================================================================================================
# -------------------------------------------------------------------------------------------------
# START:  Common Help display proceedure
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Help display proceedure
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-03-2 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

# Show help information

doshowhelp () {
    #
    # Screen width template for sizing, default width of 80 characters assumed
    #
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    echo
    echo -n $0' [-?][-v]'
    if $UseR8XAPI ; then
        echo -n '|[-r]|[-u <admin_name>]|[-p <password>]]|[-P <web ssl port>]'
        echo -n '|[-m <server_IP>]|[-d <domain>]'
        echo -n '|[-s <session_file_filepath>]'
        echo -n '|[--SO|--NSO]'
    fi
    echo -n '|[-l <log_path>]'
    echo -n '|[-o <output_path>]'
    if [ x"$script_use_export" = x"true" ] ; then
        echo -n '|[-x <export_path>]'
    fi
    if [ x"$script_use_import" = x"true" ] ; then
        echo -n '|[-i <import_path>]'
    fi
    if [ x"$script_use_delete" = x"true" ] ; then
        echo -n '|[-k <delete_path>]'
    fi
    if [ x"$script_use_csvfile" = x"true" ] ; then
        echo -n '|[-c <csv_path>]'
    fi
    echo

    echo
    echo ' Script Version:  '$ScriptVersion'  Date:  '$ScriptDate
    echo
    echo ' Standard Command Line Parameters: '
    echo
    echo '  Show Help                  -? | --help'
    echo '  Verbose mode               -v | --verbose'
    echo
    if $UseR8XAPI ; then
        echo '  Authenticate as root       -r | --root'
        echo '  Set Console User Name      -u <admin_name> | --user <admin_name> |'
        echo '                             -u=<admin_name> | --user=<admin_name>'
        echo '  Set Console User password  -p <password> | --password <password> |'
        echo '                             -p=<password> | --password=<password>'
        echo
        echo '  Set [web ssl] Port         -P <web-ssl-port> | --port <web-ssl-port> |'
        echo '                             -P=<web-ssl-port> | --port=<web-ssl-port>'
        echo '  Set Management Server IP   -m <server_IP> | --management <server_IP> |'
        echo '                             -m=<server_IP> | --management=<server_IP>'
        echo '  Set Management Domain      -d <domain> | --domain <domain> |'
        echo '                             -d=<domain> | --domain=<domain>'
        echo '  Set session file path      -s <session_file_filepath> |'
        echo '                             --session-file <session_file_filepath> |'
        echo '                             -s=<session_file_filepath> |'
        echo '                             --session-file=<session_file_filepath>'
        echo
    fi
    echo '  Set log file path          -l <log_path> | --log-path <log_path> |'
    echo '                             -l=<log_path> | --log-path=<log_path>'
    echo '  Set output file path       -o <output_path> | --output <output_path> |'
    echo '                             -o=<output_path> | --output=<output_path>'
    echo
    if [ x"$script_use_export" = x"true" ] ; then
        echo '  Set export file path       -x <export_path> | --export <export_path> |'
        echo '                             -x=<export_path> | --export=<export_path>'
    fi
    if [ x"$script_use_import" = x"true" ] ; then
        echo '  Set import file path       -i <import_path> | --import-path <import_path> |'
        echo '                             -i=<import_path> | --import-path=<import_path>'
    fi
    if [ x"$script_use_delete" = x"true" ] ; then
        echo '  Set delete file path       -k <delete_path> | --delete-path <delete_path> |'
        echo '                             -k=<delete_path> | --delete-path=<delete_path>'
    fi
    if [ x"$script_use_csvfile" = x"true" ] ; then
        echo '  Set csv file path          -c <csv_path> | --csv <csv_path |'
        echo '                             -c=<csv_path> | --csv=<csv_path>'
    fi
    if $UseR8XAPI ; then
        echo
        echo '  NO System Objects Export   --NSO | --no-system-objects  {default mode}'
        echo '  Export System Objects      --SO | --system-objects'
    fi
    echo
    echo '  No waiting in verbose mode --NOWAIT'
    if $UseR8XAPI ; then
        echo '  Remove WIP folders after   --CLEANUPWIP'
        echo '  No domain name in folders  --NODOMAINFOLDERS'
        echo '  CSV export add err handler --CSVEXPORTADDIGNOREERR'
        echo
        echo '  session_file_filepath = fully qualified file path for session file'
    fi
    echo '  log_path = fully qualified folder path for log files'
    echo '  output_path = fully qualified folder path for output files'

    if [ x"$script_use_export" = x"true" ] ; then
        echo '  export_path = fully qualified folder path for export file'
    fi
    if [ x"$script_use_import" = x"true" ] ; then
        echo '  import_path = fully qualified folder path for import files'
    fi
    if [ x"$script_use_delete" = x"true" ] ; then
        echo '  delete_path = fully qualified folder path for delete files'
    fi
    if [ x"$script_use_csvfile" = x"true" ] ; then
        echo '  csv_path = fully qualified file path for csv file'
    fi

    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
    if $UseR8XAPI ; then
        echo
        echo ' NOTE:  Only use Management Server IP (-m) parameter if operating from a '
        echo '        different host than the management host itself.'
        echo
        echo ' NOTE:  Use the Domain Name (text) with the Domain (-d) parameter when'
        echo '        Operating in Multi Domain Management environment.'
        echo '        Use the "Global" domain for the global domain objects.'
        echo '          Quotes NOT required!'
        echo '        Use the "System Data" domain for system domain objects.'
        echo '          Quotes REQUIRED!'
        echo
        echo ' NOTE:  System Objects are NOT exported in CSV or Full JSON dump mode!'
        echo '        Control of System Objects with --SO and --NSO only works with CSV or'
        echo '        Full JSON dump.  Standard JSON dump does not support selection of the'
        echo '        System Objects during operation, so all System Objects are collected'
    fi
    echo

    echo ' Example: General :'
    echo
    if $UseR8XAPI ; then
        echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump"'
        echo
        echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -d Global --SO -s "/var/tmp/id.txt"'
        echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -d "System Data" --NSO -s "/var/tmp/id.txt"'
        echo
    
    
        if [ x"$script_use_export" = x"true" ] ; then
            echo ' Example: Export:'
            echo
            echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export"'
            echo
        fi
    
        if [ x"$script_use_import" = x"true" ] ; then
            echo ' Example: Import:'
            echo
            echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -i "/var/tmp/import"'
            echo
        fi
        
        if [ x"$script_use_delete" = x"true" ] ; then
            echo ' Example: Delete:'
            echo
            echo ' ]# '$ScriptName' -u fooAdmin -p voodoo -P 4434 -m 192.168.1.1 -d fooville -s "/var/tmp/id.txt" -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export" -k "/var/tmp/delete"'
            echo
        fi
    else
        echo ' ]# '$ScriptName' -l "/var/tmp/script_dump"'
        echo
    
        if [ x"$script_use_export" = x"true" ] ; then
            echo ' Example: Export:'
            echo
            echo ' ]# '$ScriptName' -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export"'
            echo
        fi
    
        if [ x"$script_use_import" = x"true" ] ; then
            echo ' Example: Import:'
            echo
            echo ' ]# '$ScriptName' -l "/var/tmp/script_dump" -i "/var/tmp/import"'
            echo
        fi
        
        if [ x"$script_use_delete" = x"true" ] ; then
            echo ' Example: Delete:'
            echo
            echo ' ]# '$ScriptName' -l "/var/tmp/script_dump" -x "/var/tmp/script_dump/export" -k "/var/tmp/delete"'
            echo
        fi
    fi
    
    #              1111111111222222222233333333334444444444555555555566666666667777777777888888888899999999990
    #    01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

    echo
    return 1
}

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-03-2

# -------------------------------------------------------------------------------------------------
# END:  Common Help display proceedure
# -------------------------------------------------------------------------------------------------
# =================================================================================================

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------------------
# Process command line parameters and set appropriate values
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-09-21 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

if [ x"$APISCRIPTVERBOSE" = x"true" ] ; then
    # Verbose mode ON
    dumprawcliparms "$@"
fi

while [ -n "$1" ]; do
    # Copy so we can modify it (can't modify $1)
    OPT="$1"

    # testing
    #echo 'OPT = '$OPT
    #

    # Detect argument termination
    if [ x"$OPT" = x"--" ]; then
        # testing
        # echo "Argument termination"
        #
        
        shift
        for OPT ; do
            REMAINS="$REMAINS \"$OPT\""
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
            '-v' | --verbose )
                export APISCRIPTVERBOSE=true
                ;;
            --NOWAIT )
                CLIparm_NOWAIT=true
                export NOWAIT=true
                ;;
            # Handle immediate opts like this
            -r | --root )
                CLIparm_rootuser=true
                ;;
#           -f | --force )
#               FORCE=true
#               ;;
            --SO | --system-objects )
                CLIparm_NoSystemObjects=false
                ;;
            --NSO | --no-system-objects )
                CLIparm_NoSystemObjects=true
                ;;
            --CLEANUPWIP )
                CLIparm_CLEANUPWIP=true
                ;;
            --NODOMAINFOLDERS )
                CLIparm_NODOMAINFOLDERS=true
                ;;
            --CSVEXPORTADDIGNOREERR )
                CLIparm_CSVEXPORTADDIGNOREERR=true
                ;;
            # Handle --flag=value opts like this
            -u=* | --user=* )
                CLIparm_user="${OPT#*=}"
                #shift
                ;;
            -p=* | --password=* )
                CLIparm_password="${OPT#*=}"
                #shift
                ;;
            -P=* | --port=* )
                CLIparm_websslport="${OPT#*=}"
                #shift
                ;;
            -m=* | --management=* )
                CLIparm_mgmt="${OPT#*=}"
                #shift
                ;;
            -d=* | --domain=* )
                CLIparm_domain="${OPT#*=}"
                CLIparm_domain=${CLIparm_domain//\"}
                #shift
                ;;
            -s=* | --session-file=* )
                CLIparm_sessionidfile="${OPT#*=}"
                #shift
                ;;
            -l=* | --log-path=* )
                CLIparm_logpath="${OPT#*=}"
                #shift
                ;;
            -x=* | --export=* )
                CLIparm_exportpath="${OPT#*=}"
                #shift
                ;;
            -o=* | --output=* )
                CLIparm_outputpath="${OPT#*=}"
                #shift
                ;;
            -i=* | --import-path=* )
                CLIparm_importpath="${OPT#*=}"
                #shift
                ;;
            -k=* | --delete-path=* )
                CLIparm_deletepath="${OPT#*=}"
                #shift
                ;;
            -c=* | --csv=* )
                CLIparm_csvpath="${OPT#*=}"
                #shift
                ;;
            # and --flag value opts like this
            -u* | --user )
                CLIparm_user="$2"
                shift
                ;;
            -p* | --password )
                CLIparm_password="$2"
                shift
                ;;
            -P* | --port )
                CLIparm_websslport="$2"
                shift
                ;;
            -m* | --management )
                CLIparm_mgmt="$2"
                shift
                ;;
            -d* | --domain )
                CLIparm_domain="$2"
                CLIparm_domain=${CLIparm_domain//\"}
                shift
                ;;
            -s* | --session-file )
                CLIparm_sessionidfile="$2"
                shift
                ;;
            -l* | --log-path )
                CLIparm_logpath="$2"
                shift
                ;;
            -o* | --output )
                CLIparm_outputpath="$2"
                shift
                ;;
            -x* | --export )
                CLIparm_exportpath="$2"
                shift
                ;;
            -i* | --import-path )
                CLIparm_importpath="$2"
                shift
                ;;
            -k* | --delete-path )
                CLIparm_deletepath="$2"
                shift
                ;;
            -c* | --csv )
                CLIparm_csvpath="$2"
                shift
                ;;
            # Anything unknown is recorded for later
            * )
                REMAINS="$REMAINS \"$OPT\""
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
eval set -- $REMAINS

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-09-21

# MODIFIED 2018-05-03-2 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

export SHOWHELP=$SHOWHELP
export CLIparm_websslport=$CLIparm_websslport
export CLIparm_rootuser=$CLIparm_rootuser
export CLIparm_user=$CLIparm_user
export CLIparm_password=$CLIparm_password
export CLIparm_mgmt=$CLIparm_mgmt
export CLIparm_domain=$CLIparm_domain
export CLIparm_sessionidfile=$CLIparm_sessionidfile
export CLIparm_logpath=$CLIparm_logpath

export CLIparm_outputpath=$CLIparm_outputpath

export CLIparm_exportpath=$CLIparm_exportpath
export CLIparm_importpath=$CLIparm_importpath
export CLIparm_deletepath=$CLIparm_deletepath

export CLIparm_csvpath=$CLIparm_csvpath

export CLIparm_NoSystemObjects=`echo "$CLIparm_NoSystemObjects" | tr '[:upper:]' '[:lower:]'`

# ADDED 2018-05-03-2 -
export CLIparm_NOWAIT=`echo "$CLIparm_NOWAIT" | tr '[:upper:]' '[:lower:]'`
export CLIparm_CLEANUPWIP=`echo "$CLIparm_CLEANUPWIP" | tr '[:upper:]' '[:lower:]'`
export CLIparm_NODOMAINFOLDERS=`echo "$CLIparm_NODOMAINFOLDERS" | tr '[:upper:]' '[:lower:]'`
export CLIparm_CSVEXPORTADDIGNOREERR=`echo "$CLIparm_CSVEXPORTADDIGNOREERR" | tr '[:upper:]' '[:lower:]'`

export REMAINS=$REMAINS

dumpcliparmparseresults "$@"

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-03-2

# -------------------------------------------------------------------------------------------------
# Handle request for help (common) and exit
# -------------------------------------------------------------------------------------------------

# MODIFIED 2018-05-04 \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#

#
# Was help requested, if so show it and return
#
if [ x"$SHOWHELP" = x"true" ] ; then
    # Show Help
    doshowhelp "$@"
    return 255 
fi

#
# /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\ MODIFIED 2018-05-04

# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------

# =================================================================================================
# END:  Command Line Parameter Handling and Help
# =================================================================================================
# =================================================================================================


# =================================================================================================
# END:  
# =================================================================================================
# =================================================================================================


