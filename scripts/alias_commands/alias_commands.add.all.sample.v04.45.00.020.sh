# !! SAMPLE !!
#
# SCRIPT  Alias commands and varriables configuration for bash shell launch
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
ScriptDate=2020-11-20
ScriptVersion=04.45.00
ScriptRevision=020
TemplateVersion=04.45.00
TemplateLevel=006
SubScriptsLevel=010
SubScriptsVersion=04.45.00
#

#========================================================================================
#========================================================================================
# start of alias.commands.<action>.<scope>.sh
#========================================================================================
#========================================================================================


echo
echo 'Configuring User Environment...'
echo


#========================================================================================
# Setup standard environment export variables
#========================================================================================


# 2020-09-17
export ENVIRONMENTHELPFILE=${HOME}/environment_help_file.txt

rm ${ENVIRONMENTHELPFILE}
touch ${ENVIRONMENTHELPFILE}

echo >> ${ENVIRONMENTHELPFILE}
echo '===============================================================================' >> ${ENVIRONMENTHELPFILE}
echo '===============================================================================' >> ${ENVIRONMENTHELPFILE}
echo 'MyBasementCloud bash Environment, Scripts :  Version '${ScriptVersion}', Revision '${ScriptRevision}' from Date '${ScriptDate} >> ${ENVIRONMENTHELPFILE}
echo '===============================================================================' >> ${ENVIRONMENTHELPFILE}
echo >> ${ENVIRONMENTHELPFILE}

echo '===============================================================================' >> ${ENVIRONMENTHELPFILE}
echo 'User Environment Configuration Variables and Alias Commands' >> ${ENVIRONMENTHELPFILE}
echo '===============================================================================' >> ${ENVIRONMENTHELPFILE}
echo >> ${ENVIRONMENTHELPFILE}

tempENVHELPFILEvars=/var/tmp/environment_help_file.temp.variables.txt
tempENVHELPFILEalias=/var/tmp/environment_help_file.temp.alias.txt

echo '===============================================================================' > ${tempENVHELPFILEvars}
echo 'List Custom User variables set by alias_commands.add.all' >> ${tempENVHELPFILEvars}
echo '===============================================================================' >> ${tempENVHELPFILEvars}
echo >> ${tempENVHELPFILEvars}

echo >> ${tempENVHELPFILEalias}


#========================================================================================
# 2020-11-18

if [ -z ${SCRIPTVERBOSE} ] ; then 
    export SCRIPTVERBOSE=false
fi
if [ -z ${NOWAIT} ] ; then 
    export NOWAIT=false
fi
if [ -z ${NOSTART} ] ; then 
    export NOSTART=false
fi

echo 'variable :  SCRIPTVERBOSE               ='"${SCRIPTVERBOSE}" >> ${tempENVHELPFILEvars}
echo 'variable :  NOWAIT                      ='"${NOWAIT}" >> ${tempENVHELPFILEvars}
echo 'variable :  NOSTART                     ='"${NOSTART}" >> ${tempENVHELPFILEvars}
echo >> ${tempENVHELPFILEvars}

#========================================================================================
# 2019-09-28, 2020-05-30, 2020-09-30, 2020-11-18

export MYWORKFOLDER=/var/log/__customer

export MYWORKFOLDERSCRIPTS=${MYWORKFOLDER}/_scripts
export MYWORKFOLDERSCRIPTSB4CP=${MYWORKFOLDER}/_scripts/bash_4_Check_Point
export MYWORKFOLDERTOOLS=${MYWORKFOLDER}/_tools
export MYWORKFOLDERDOWNLOADS=${MYWORKFOLDER}/download
export MYWORKFOLDERUGEX=${MYWORKFOLDER}/upgrade_export
export MYWORKFOLDERUGEXSCRIPTS=${MYWORKFOLDER}/upgrade_export/scripts
export MYWORKFOLDERCHANGE=${MYWORKFOLDERUGEX}/Change_Log
export MYWORKFOLDERDUMP=${MYWORKFOLDERUGEX}/dump
export MYWORKFOLDERREFERENCE=${MYWORKFOLDERUGEX}/Reference

echo 'variable :  MYWORKFOLDER                ='"${MYWORKFOLDER}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYWORKFOLDERSCRIPTS         ='"${MYWORKFOLDERSCRIPTS}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYWORKFOLDERSCRIPTSB4CP     ='"${MYWORKFOLDERSCRIPTSB4CP}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYWORKFOLDERTOOLS           ='"${MYWORKFOLDERTOOLS}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYWORKFOLDERDOWNLOADS       ='"${MYWORKFOLDERDOWNLOADS}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYWORKFOLDERUGEX            ='"${MYWORKFOLDERUGEX}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYWORKFOLDERUGEXSCRIPTS     ='"${MYWORKFOLDERUGEXSCRIPTS}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYWORKFOLDERCHANGE          ='"${MYWORKFOLDERCHANGE}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYWORKFOLDERDUMP            ='"${MYWORKFOLDERDUMP}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYWORKFOLDERREFERENCE       ='"${MYWORKFOLDERREFERENCE}" >> ${tempENVHELPFILEvars}
echo >> ${tempENVHELPFILEvars}

#========================================================================================
# 2020-01-0

# points to where jq is installed
if [ -r ${CPDIR}/jq/jq ] ; then
    export JQ=${CPDIR}/jq/jq
elif [ -r ${CPDIR_PATH}/jq/jq ] ; then
    export JQ=${CPDIR_PATH}/jq/jq
elif [ -r ${MDS_CPDIR}/jq/jq ] ; then
    export JQ=${MDS_CPDIR}/jq/jq
else
    export JQ=
fi

# points to where jq 1.6 is installed, which is not generally part of Gaia, even R80.40EA (2020-01-20)
export JQ16PATH=${MYWORKFOLDER}/_tools/JQ
export JQ16FILE=jq-linux64
export JQ16FQFN=$JQ16PATH/${JQ16FILE}
if [ -r ${JQ16FQFN} ] ; then
    # OK we have the easy-button alternative
    export JQ16=${JQ16FQFN}
else
    export JQ16=
fi

echo 'variable :  JQ                          ='"${JQ}" >> ${tempENVHELPFILEvars}
echo 'variable :  JQ16PATH                    ='"${JQ16PATH}" >> ${tempENVHELPFILEvars}
echo 'variable :  JQ16FILE                    ='"${JQ16FILE}" >> ${tempENVHELPFILEvars}
echo 'variable :  JQ16FQFN                    ='"${JQ16FQFN}" >> ${tempENVHELPFILEvars}
echo 'variable :  JQ16                        ='"${JQ16}" >> ${tempENVHELPFILEvars}
echo >> ${tempENVHELPFILEvars}


#========================================================================================
# Setup alias and other complex operations
#========================================================================================


#========================================================================================
# 2020-09-17
alias show_environment_help='echo;cat ${ENVIRONMENTHELPFILE};echo'

echo 'show_environment_help        :  Display help for environment variables and alias values set' >> ${tempENVHELPFILEalias}


#========================================================================================
# 2020-11-11

alias DTGDATE='date +%Y-%m-%d-%H%M%Z'
alias DTGSDATE='date +%Y-%m-%d-%H%M%S%Z'

alias DTGUTCDATE='date -u +%Y-%m-%d-%H%M%Z'
alias DTGUTCSDATE='date -u +%Y-%m-%d-%H%M%S%Z'

echo 'DTGDATE                      :  Generate Date Time Group with Year-Month-Day-Time-TimeZone YYYY-mm-dd-HHMMTZ3' >> ${tempENVHELPFILEalias}
echo 'DTGDATE                      :  Generate Date Time Group with Year-Month-Day-Time-TimeZone YYYY-mm-dd-HHMMSSTZ3' >> ${tempENVHELPFILEalias}
echo 'DTGUTCDATE                   :  Generate UTC based Date Time Group with Year-Month-Day-Time-TimeZone YYYY-mm-dd-HHMMTZ3' >> ${tempENVHELPFILEalias}
echo 'DTGUTCSDATE                  :  Generate UTC based Date Time Group with Year-Month-Day-Time-TimeZone YYYY-mm-dd-HHMMSSTZ3' >> ${tempENVHELPFILEalias}

alias timecheck='echo -e "Current Date-Time-Group : `DTGSDATE` \n"'
echo 'timecheck                    :  Show Current DTGS Date Time Group (YYYY-mm-dd-HHMMSSTZ3)' >> ${tempENVHELPFILEalias}


#========================================================================================
# ADDED 2020-11-11 -

alias HOSTNAMEDTG='echo ${HOSTNAME}.`DTGDATE`'
alias HOSTNAMEDTGS='echo ${HOSTNAME}.`DTGSDATE`'
alias HOSTNAMENOW='echo ${HOSTNAME}.`DTGSDATE`'

echo 'HOSTNAMEDTG                  :  Generate hostname . (dot) Date Time Group :  ${HOSTNAME}.YYYY-mm-dd-HHMMTZ3' >> ${tempENVHELPFILEalias}
echo 'HOSTNAMEDTGS                 :  Generate hostname . (dot) Date Time Group with Seconds :  ${HOSTNAME}.YYYY-mm-dd-HHMMSSTZ3' >> ${tempENVHELPFILEalias}
echo 'HOSTNAMENOW                  :  Generate hostname . (dot) Date Time Group with Seconds :  ${HOSTNAME}.YYYY-mm-dd-HHMMSSTZ3' >> ${tempENVHELPFILEalias}


#========================================================================================
# ADDED 2020-11-11 -

#Generate Check Point release version
CPRELEASEVERSION ()
{
    get_platform_release=`${MDS_FWDIR}/Python/bin/python ${MDS_FWDIR}/scripts/get_platform.py -f json | ${JQ} '. | .release'`
    platform_release=${get_platform_release//\"/}
    get_platform_release_version=`echo ${get_platform_release//\"/} | cut -d " " -f 4`
    platform_release_version=${get_platform_release_version//\"/}
    echo ${platform_release_version}
}

echo 'CPRELEASEVERSION             :  Generate Check Point release version' >> ${tempENVHELPFILEalias}

alias CPVERSIONNOW='echo `CPRELEASEVERSION`.${HOSTNAME}.`DTGSDATE`'
alias CPVERSIONHOSTNOW='echo `CPRELEASEVERSION`.${HOSTNAME}.`DTGSDATE`'
alias HOSTCPVERSIONNOW='echo ${HOSTNAME}.`CPRELEASEVERSION`.`DTGSDATE`'

echo 'CPVERSIONNOW                 :  Generate Check Point release version . (dot) Date Time Group :  release_version.YYYY-mm-dd-HHMMTZ3' >> ${tempENVHELPFILEalias}
echo 'CPVERSIONHOSTNOW             :  Generate Check Point release version . (dot) hostname . (dot) Date Time Group with Seconds :  release_version.${HOSTNAME}.YYYY-mm-dd-HHMMSSTZ3' >> ${tempENVHELPFILEalias}
echo 'HOSTCPVERSIONNOW             :  Generate hostname . (dot) Check Point release version . (dot) Date Time Group with Seconds :  ${HOSTNAME}.release_version.YYYY-mm-dd-HHMMSSTZ3' >> ${tempENVHELPFILEalias}


#========================================================================================
# Updated 2020-09-17
#alias list='ls -alh'
alias list='ls -alh --color=auto --group-directories-first'
echo 'list                         :  display folder content -- '`alias list` >> ${tempENVHELPFILEalias}


#========================================================================================
# 2020-09-17
alias gocustomer='cd ${MYWORKFOLDER};echo Current path = `pwd`;echo'
alias gougex='cd ${MYWORKFOLDER}/upgrade_export;echo Current path = `pwd`;echo'
alias gochangelog='cd "${MYWORKFOLDERCHANGE}";echo Current path = `pwd`;echo'
alias godump='cd "${MYWORKFOLDERDUMP}";echo Current path = `pwd`;echo'
alias godownload='cd "${MYWORKFOLDERDOWNLOADS}";echo Current path = `pwd`;echo'
alias goscripts='cd "${MYWORKFOLDERSCRIPTS}";echo Current path = `pwd`;echo'
alias gob4cp='cd "${MYWORKFOLDERSCRIPTSB4CP}";echo Current path = `pwd`;echo'
alias gob4CP='gob4cp'

echo 'gocustomer                   :  Go to customer work folder '${MYWORKFOLDER} >> ${tempENVHELPFILEalias}
echo 'gougex                       :  Go to upgrade export folder '${MYWORKFOLDER}/upgrade_export >> ${tempENVHELPFILEalias}
echo 'gochangelog                  :  Go to Change Log folder '${MYWORKFOLDERCHANGE} >> ${tempENVHELPFILEalias}
echo 'godump                       :  Go to dump folder '${MYWORKFOLDERDUMP} >> ${tempENVHELPFILEalias}
echo 'godownload                   :  Go to download folder '${MYWORKFOLDERDOWNLOADS} >> ${tempENVHELPFILEalias}
echo 'goscripts                    :  Go to scripts folder '${MYWORKFOLDERSCRIPTS} >> ${tempENVHELPFILEalias}
echo 'gob4cp                       :  Go to bash 4 Check Point folder '${MYWORKFOLDERSCRIPTSB4CP} >> ${tempENVHELPFILEalias}
echo 'gob4CP                       :  Go to bash 4 Check Point folder '${MYWORKFOLDERSCRIPTSB4CP} >> ${tempENVHELPFILEalias}

#========================================================================================
# 2020-09-17
if [ -r ${MYWORKFOLDER}/cli_api_ops ] ; then
    alias goapi='cd ${MYWORKFOLDER}/cli_api_ops;echo Current path = `pwd`;echo'
    alias goapiexport='cd ${MYWORKFOLDER}/cli_api_ops/export_import;echo Current path = `pwd`;echo'
    echo 'goapi                        :  Go to api work folder '${MYWORKFOLDER}/cli_api_ops >> ${tempENVHELPFILEalias}
    echo 'goapiexport                  :  Go to api export folder '${MYWORKFOLDER}/cli_api_ops/export_import >> ${tempENVHELPFILEalias}
fi
if [ -r ${MYWORKFOLDER}/cli_api_ops.wip ] ; then
    alias goapiwip='cd ${MYWORKFOLDER}/cli_api_ops.wip;echo Current path = `pwd`;echo'
    alias goapiwipexport='cd ${MYWORKFOLDER}/cli_api_ops.wip/export_import.wip;echo Current path = `pwd`;echo'
    echo 'goapiwip                     :  Go to api development work folder '${MYWORKFOLDER}/cli_api_ops.wip >> ${tempENVHELPFILEalias}
    echo 'goapiwipexport               :  Go to api development export folder '${MYWORKFOLDER}/cli_api_ops.wip/export_import.wip >> ${tempENVHELPFILEalias}
fi

#========================================================================================
# 2020-09-17
if [ -r ${MYWORKFOLDER}/devops ] ; then
    alias godevops='cd ${MYWORKFOLDER}/devops;echo Current path = `pwd`;echo'
    alias godevopsexport='cd ${MYWORKFOLDER}/devops/export_import;echo Current path = `pwd`;echo'
    echo 'godevops                     :  Go to api devops folder '${MYWORKFOLDER}/devops >> ${tempENVHELPFILEalias}
    echo 'godevopsexport               :  Go to api devops export folder '${MYWORKFOLDER}/devops/export_import >> ${tempENVHELPFILEalias}
fi
if [ -r ${MYWORKFOLDER}/devops.dev ] ; then
    alias godevopsdev='cd ${MYWORKFOLDER}/devops.dev;echo Current path = `pwd`;echo'
    alias godevopsdevexport='cd ${MYWORKFOLDER}/devops.dev/export_import.wip;echo Current path = `pwd`;echo'
    echo 'godevopsdev                  :  Go to api devops development folder '${MYWORKFOLDER}/devops.dev >> ${tempENVHELPFILEalias}
    echo 'godevopsdevexport            :  Go to api devops development export folder '${MYWORKFOLDER}/devops.dev/export_import.wip >> ${tempENVHELPFILEalias}
fi

#========================================================================================
# 2020-09-17

alias makedumpnow='DTGSNOW=`DTGSDATE`;mkdir -pv "${MYWORKFOLDERDUMP}/$DTGSNOW";list "${MYWORKFOLDERDUMP}/";echo;echo "New dump folder = ${MYWORKFOLDERDUMP}/$DTGSNOW";echo Current path = `pwd`;echo'
alias godumpnow='DTGSNOW=`DTGSDATE`;mkdir -pv "${MYWORKFOLDERDUMP}/$DTGSNOW";list "${MYWORKFOLDERDUMP}/";echo;cd "${MYWORKFOLDERDUMP}/$DTGSNOW";echo;echo Current path = `pwd`;echo'
alias makedumpdtg='DTGNOW=`DTGDATE`;mkdir -pv "${MYWORKFOLDERDUMP}/$DTGNOW";list "${MYWORKFOLDERDUMP}/";echo;echo "New dump folder = ${MYWORKFOLDERDUMP}/$DTGNOW";echo Current path = `pwd`;echo'
alias godumpdtg='DTGNOW=`DTGDATE`;mkdir -pv "${MYWORKFOLDERDUMP}/$DTGNOW";list "${MYWORKFOLDERDUMP}/";echo;cd "${MYWORKFOLDERDUMP}/$DTGNOW";echo;echo Current path = `pwd`;echo'

echo 'makedumpnow                  :  Create a dump folder with current Date Time Group (DTGS) and show that folder' >> ${tempENVHELPFILEalias}
echo 'godumpnow                    :  Create a dump folder with current Date Time Group (DTGS) and change to that folder' >> ${tempENVHELPFILEalias}
echo 'makedumpdtg                  :  Create a dump folder with current Date Time Group (DTG) and show that folder' >> ${tempENVHELPFILEalias}
echo 'godumpdtg                    :  Create a dump folder with current Date Time Group (DTG) and change to that folder' >> ${tempENVHELPFILEalias}

alias makechangelognow='DTGSNOW=`DTGSDATE`;mkdir -pv "${MYWORKFOLDERCHANGE}/$DTGSNOW";list "${MYWORKFOLDERCHANGE}/";echo;echo Current path = `pwd`;echo'
alias gochangelognow='DTGSNOW=`DTGSDATE`;mkdir -pv "${MYWORKFOLDERCHANGE}/$DTGSNOW";list "${MYWORKFOLDERCHANGE}/";echo;cd "${MYWORKFOLDERCHANGE}/$DTGSNOW";echo;echo Current path = `pwd`;echo'
alias makechangelogdtg='DTGNOW=`DTGDATE`;mkdir -pv "${MYWORKFOLDERCHANGE}/$DTGNOW";list "${MYWORKFOLDERCHANGE}/";echo;echo Current path = `pwd`;echo'
alias gochangelogdtg='DTGNOW=`DTGDATE`;mkdir -pv "${MYWORKFOLDERCHANGE}/$DTGNOW";list "${MYWORKFOLDERCHANGE}/";echo;cd "${MYWORKFOLDERCHANGE}/$DTGNOW";echo;echo Current path = `pwd`;echo'

echo 'makechangelognow             :  Create a Change Log folder with current Date Time Group (DTGS) and show that folder' >> ${tempENVHELPFILEalias}
echo 'gochangelognow               :  Create a Change Log folder with current Date Time Group (DTGS) and change to that folder' >> ${tempENVHELPFILEalias}
echo 'makechangelogdtg             :  Create a Change Log folder with current Date Time Group (DTG) and show that folder' >> ${tempENVHELPFILEalias}
echo 'gochangelogdtg               :  Create a Change Log folder with current Date Time Group (DTG) and change to that folder' >> ${tempENVHELPFILEalias}

#========================================================================================
# 2020-09-17

alias versionsdump='echo;echo;uname -a;echo;echo;clish -c "show version all";echo;echo;clish -c "show installer status";echo;echo;cpinfo -y all;echo;echo'
echo 'versionsdump                 :  Dump current version information for linux, clish, and cpinfo ' >> ${tempENVHELPFILEalias}

#alias configdump='echo;gougex;pwd;echo;echo;./config_capture;echo;echo;./healthdump;echo;echo'
alias configdump='echo;config_capture;echo;healthdump;echo'
echo 'configdump                   :  Execute configuration dump (config_capture) and health status check (healthdump)' >> ${tempENVHELPFILEalias}

#alias braindump='echo;gougex;pwd;echo;echo;./config_capture;echo;echo;./healthdump;echo;echo;./interface_info;echo;echo;./check_point_service_status_check;echo;echo'
alias braindump='echo;config_capture;echo;healthdump;echo;interface_info;echo;check_point_service_status_check;echo'
echo 'braindump                    :  Execute complete configuration and status dump (config_capture, healthdump, interface_info, check_point_service_status_check) ' >> ${tempENVHELPFILEalias}

alias checkFTW='echo; echo "Check if FTW completed!  TRUE if .wizard_accepted found"; echo; ls -alh /etc/.wizard_accepted; echo; tail -n 10 /var/log/ftw_install.log; echo'
echo 'checkFTW                     :  Display status of First Time Wizard (FTW) completion or operation' >> ${tempENVHELPFILEalias}

#========================================================================================
# 2020-09-17, 2020-11-11

if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/watch_accel_stats ] ; then
    # GW related aliases
    
    alias dumpzdebugnow='filesuffix=`HOSTCPVERSIONNOW`; targefolder=${MYWORKFOLDERDUMP}/`DTGSDATE` ; mkdir -pv "$targefolder";list "$targefolder/";echo;cd "$targefolder";echo;echo Current path = `pwd`;echo;fw ctl zdebug drop | tee -a zdebug_drop.$filesuffix.txt'
    echo 'dumpzdebugnow                :  Gateway : generate zdebug drop dump to new dump folder with current Date Time Group (DTGS)' >> ${tempENVHELPFILEalias}
fi


#========================================================================================
# 2020-09-17

export MYWORKFOLDERCCC=${MYWORKFOLDER}/_scripts/ccc
echo 'variable :  MYWORKFOLDERCCC             ='"$MYWORKFOLDERCCC" >> ${tempENVHELPFILEvars}

alias installccc="mkdir $MYWORKFOLDERCCC; curl_cli -k https://dannyjung.de/ccc | zcat > $MYWORKFOLDERCCC/ccc && chmod +x $MYWORKFOLDERCCC/ccc; alias ccc='$MYWORKFOLDERCCC/ccc'"
echo 'installccc                   :  Install ccc utility by Danny Jung and put in folder '"$MYWORKFOLDERCCC" >> ${tempENVHELPFILEalias}

if [ -r $MYWORKFOLDERCCC/ccc ] ; then
    # ccc related aliases
    
    alias ccc='$MYWORKFOLDERCCC/ccc'
    echo 'ccc                          :  Execute ccc utility by Danny Jung folder '"$MYWORKFOLDERCCC" >> ${tempENVHELPFILEalias}
    
fi

#========================================================================================
#========================================================================================
# 2020-09-17 Updated

#
# This section expects definition of the following external variables.  These are usually part of the user profile setup in the ${HOME} folder
#  MYTFTPSERVER     default TFTP/FTP server to use for TFTP/FTP operations, usually set to one of the following
#  MYTFTPSERVER1    first TFTP/FTP server to use for TFTP/FTP operations
#  MYTFTPSERVER2    second TFTP/FTP server to use for TFTP/FTP operations
#  MYTFTPSERVER3    third TFTP/FTP server to use for TFTP/FTP operations
#
#  MYTFTPSERVER* values are assumed to be an IPv4 Address (0.0.0.0 to 255.255.255.255) that represents a valid TFTP/FTP target host.
#  Setting one of the MYTFTPSERVER* to blank ignores that host.  Future scripts may include checks to see if the host actually has a reachable TFTP/FTP server
#

export MYTFTPSERVER1=192.168.1.1
export MYTFTPSERVER2=192.168.1.2
export MYTFTPSERVER3=
export MYTFTPSERVER=${MYTFTPSERVER1}
export MYTFTPFOLDER=/__gaia

echo 'variable :  MYTFTPSERVER1               ='"${MYTFTPSERVER1}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYTFTPSERVER2               ='"${MYTFTPSERVER2}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYTFTPSERVER3               ='"${MYTFTPSERVER3}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYTFTPSERVER                ='"${MYTFTPSERVER}" >> ${tempENVHELPFILEvars}
echo 'variable :  MYTFTPFOLDER                ='"${MYTFTPFOLDER}" >> ${tempENVHELPFILEvars}
echo >> ${tempENVHELPFILEvars}

alias show_mytftpservers='echo -e "MYTFTPSERVERs: \n MYTFTPSERVER  = ${MYTFTPSERVER} \n MYTFTPSERVER1 = ${MYTFTPSERVER1} \n MYTFTPSERVER2 = ${MYTFTPSERVER2} \n MYTFTPSERVER3 = ${MYTFTPSERVER3}" ;echo'
echo 'show_mytftpservers           :  Show current settings for the TFTP servers defined by MYTFTPSERVERx ' >> ${tempENVHELPFILEalias}

alias getupdatescripts='gougex;pwd;tftp -v -m binary ${MYTFTPSERVER} -c get $MYTFTPFOLDER/updatescripts.sh;echo;chmod 775 updatescripts.sh;echo;ls -alh updatescripts.sh'
echo 'getupdatescripts             :  Get the current update script from the primary TFTP server' >> ${tempENVHELPFILEalias}

alias updatelatestscripts='getupdatescripts ; . ./updatescripts.sh ; . ./alias_commands_update_all_users'
echo 'updatelatestscripts          :  Update to the latest scripts on the TFTP server' >> ${tempENVHELPFILEalias}

alias getsetuphostscript='cd /var/log;pwd;tftp -v -m binary ${MYTFTPSERVER} -c get $MYTFTPFOLDER/setuphost.sh;echo;chmod 775 setuphost.sh;echo;ls -alh setuphost.sh'
echo 'getsetuphostscript           :  Get the current host setup script from the primary TFTP server' >> ${tempENVHELPFILEalias}

# 2020-01-03
# Clear legacy value if set
alias getupdatetoolsscript 2>nul >nul ; if [ $? -eq 0 ] ; then echo 'alias getupdatetoolsscript SET!  REMOVING!'; unalias getupdatetoolsscript; fi ; echo

alias gettoolsupdatescript='gougex;pwd;tftp -v -m binary ${MYTFTPSERVER} -c get $MYTFTPFOLDER/update_tools.sh;echo;chmod 775 update_tools.sh;echo;ls -alh update_tools.sh'
echo 'gettoolsupdatescript         :  Get the current tools setup script from the primary TFTP server' >> ${tempENVHELPFILEalias}


#========================================================================================
#========================================================================================
# 2020-09-17 Updated

export MYSMCFOLDER=/__smcias

echo 'variable :  MYSMCFOLDER                 ='"$MYSMCFOLDER" >> ${tempENVHELPFILEvars}
echo >> ${tempENVHELPFILEvars}

alias getfixsmcscript='cd /var/log;pwd;tftp -v -m binary ${MYTFTPSERVER} -c get $MYSMCFOLDER/fix_smcias_interfaces.sh;echo;chmod 775 fix_smcias_interfaces.sh;echo;ls -alh fix_smcias_interfaces.sh'
echo 'getfixsmcscript              :  Get script to fix SMC IAS Server interfaces from the primary TFTP server' >> ${tempENVHELPFILEalias}


#========================================================================================
#========================================================================================
# 2020-09-17 Updated

alias generate_script_links='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/generate_script_links'
alias remove_script_links='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/remove_script_links'
alias reset_script_links='cd ${MYWORKFOLDERUGEX};remove_script_links;echo;generate_script_links;echo;list'
echo 'generate_script_links        :  Generate links and references to current scripts' >> ${tempENVHELPFILEalias}
echo 'remove_script_links          :  Remove links and references to current scripts' >> ${tempENVHELPFILEalias}
echo 'reset_script_links           :  Remove and Regenerate links and references to current scripts' >> ${tempENVHELPFILEalias}

alias gaia_version_type='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/gaia_version_type'
echo 'gaia_version_type            :  Display and document current Gaia version and installation type' >> ${tempENVHELPFILEalias}

alias do_script_nohup='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/do_script_nohup'
echo 'do_script_nohup              :  Execute script in passed parameters via nohup' >> ${tempENVHELPFILEalias}

alias config_capture='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/config_capture'
alias interface_info='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/interface_info'
echo 'config_capture               :  Execute capture and documentation of key configuration elements' >> ${tempENVHELPFILEalias}
echo 'interface_info               :  Execute capture and documentation of interface information' >> ${tempENVHELPFILEalias}

if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/EPM_config_check ] ; then
    alias EPM_config_check='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/EPM_config_check'
    echo 'EPM_config_check             :  Execute Configuration Capture for Endpoint Management Server' >> ${tempENVHELPFILEalias}
fi

if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/update_gaia_rest_api ] ; then
    alias update_gaia_rest_api='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/update_gaia_rest_api'
    alias update_gaia_dynamic_cli='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/update_gaia_dynamic_cli'
    echo 'update_gaia_rest_api         :  Execute update script for Gaia REST API' >> ${tempENVHELPFILEalias}
    echo 'update_gaia_dynamic_cli      :  Execute update script for Gaia (clish) Dynamic CLI' >> ${tempENVHELPFILEalias}
fi

if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/watch_accel_stats ] ; then
    # GW scripts set
    alias enable_rad_admin_stats_and_cpview='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/enable_rad_admin_stats_and_cpview'
    alias vpn_client_operational_info='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/vpn_client_operational_info'
    alias watch_accel_stats='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/watch_accel_stats'
    echo -e 'enable_rad_admin_stats_and_cpview :'"\n"'                             ::  Launch cpview with rad_admin stats enabled' >> ${tempENVHELPFILEalias}
    echo 'vpn_client_operational_info  :  Display status of VPN Clients connected to the gateway' >> ${tempENVHELPFILEalias}
    echo 'watch_accel_stats            :  Display (watch) status of firewall SecureXL Accelleration' >> ${tempENVHELPFILEalias}
    if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/watch_cluster_status ] ; then
        alias watch_cluster_status='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/watch_cluster_status'
        alias show_cluster_info='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/show_cluster_info'
        echo 'watch_cluster_status         :  Display (watch) current ClusterXL information' >> ${tempENVHELPFILEalias}
        echo 'show_cluster_info            :  Display and document current ClusterXL information' >> ${tempENVHELPFILEalias}
    fi
fi

alias healthcheck='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/healthcheck'
alias healthdump='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/healthdump'
alias check_point_service_status_check='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/check_point_service_status_check'
echo 'healthcheck                  :  Execute Check Point Healthcheck script' >> ${tempENVHELPFILEalias}
echo 'healthdump                   :  Execute Check Point Healthcheck script and place results in healtchecks folder' >> ${tempENVHELPFILEalias}
echo -e 'check_point_service_status_check :'"\n"'                             ::  Check and document status of access to Check Point Internet resource locations' >> ${tempENVHELPFILEalias}

if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/report_mdsstat ] ; then
    alias report_mdsstat='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/report_mdsstat'
    alias watch_mdsstat='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/watch_mdsstat'
    alias show_all_domains_in_array='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/show_all_domains_in_array'
    alias show_sessions_all_domains='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/show_sessions_all_domains'
    echo 'report_mdsstat               :  Display and document status of MDSM server and domains' >> ${tempENVHELPFILEalias}
    echo 'watch_mdsstat                :  Display (watch) status of MDSM server and domains' >> ${tempENVHELPFILEalias}
    echo 'show_all_domains_in_array    :  Display list of currently defined MDSM Domains on this MDS ' >> ${tempENVHELPFILEalias}
    echo 'show_sessions_all_domains    :  Display sessions for all currently defined MDSM Domains on this MDS ' >> ${tempENVHELPFILEalias}
fi

alias identify_self_referencing_symbolic_link_files='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/identify_self_referencing_symbolic_link_files'
#alias Lite_identify_self_referencing_symbolic_link_files='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/Lite.identify_self_referencing_symbolic_link_files'
alias check_status_of_scheduled_ips_updates_on_management='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/check_status_of_scheduled_ips_updates_on_management'
echo -e 'identify_self_referencing_symbolic_link_files :'"\n"'                             ::  Identify and if set, remove self referencing symbolic link files in target folder' >> ${tempENVHELPFILEalias}
#echo -e 'Lite_identify_self_referencing_symbolic_link_files :'"\n"'                             ::  Identify and if set, remove self referencing symbolic link files in target folder' >> ${tempENVHELPFILEalias}
echo -e 'check_status_of_scheduled_ips_updates_on_management :'"\n"'                             ::  Check and document the status of IPS updates process' >> ${tempENVHELPFILEalias}

if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/remove_zerolocks_sessions ] ; then
    alias remove_zerolocks_sessions='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/remove_zerolocks_sessions'
    alias remove_zerolocks_web_api_sessions='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/remove_zerolocks_web_api_sessions'
    alias show_zerolocks_sessions='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/show_zerolocks_sessions'
    alias show_zerolocks_web_api_sessions='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/show_zerolocks_web_api_sessions'
    echo 'remove_zerolocks_sessions    :  Remove management sessions with Zero locks' >> ${tempENVHELPFILEalias}
    echo -e 'remove_zerolocks_web_api_sessions :'"\n"'                             ::  Remove management sessions with Zero locks for the web_api user' >> ${tempENVHELPFILEalias}
    echo 'show_zerolocks_sessions      :  Show management sessions with Zero locks' >> ${tempENVHELPFILEalias}
    echo -e 'show_zerolocks_web_api_sessions :'"\n"'                             ::  Show management sessions with Zero locks for the web_api user' >> ${tempENVHELPFILEalias}
fi

if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/remove_zerolocks_sessions ] ; then
    # Means we have api potential
    alias apiversions='apiwebport=`clish -c "show web ssl-port" | cut -d " " -f 2`;echo "API web port = $apiwebport";echo;echo "API Versions:";mgmt_cli -r true --port $apiwebport show-api-versions -f json'
    echo 'apiversions                  :  Display current management API version' >> ${tempENVHELPFILEalias}
fi

if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/SmartEvent_backup ] ; then
    alias SmartEvent_backup='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/SmartEvent_backup'
    #alias SmartEvent_restore='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/SmartEvent_restore'
    alias Reset_SmartLog_Indexing='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/Reset_SmartLog_Indexing'
    #alias SmartEvent_NUKE_Index_and_Logs='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/SmartEvent_NUKE_Index_and_Logs'
    echo 'SmartEvent_backup            :  Backup SmartEvent Indexing and Log files' >> ${tempENVHELPFILEalias}
    #echo 'SmartEvent_restore           :  Backup SmartEvent Indexing and Log files' >> ${tempENVHELPFILEalias}
    echo 'Reset_SmartLog_Indexing      :  Reset SmartLog Indexing back the number of days provided in parameter' >> ${tempENVHELPFILEalias}
    #echo -e 'SmartEvent_NUKE_Index_and_Logs :'"\n"'                             ::  Annihilate SmartEvent Indexes and Logs' >> ${tempENVHELPFILEalias}
fi

if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/LogExporter_Backup_R8X ] ; then
    alias LogExporter_Backup_R8X='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/LogExporter_Backup_R8X'
    echo 'LogExporter_Backup_R8X       :  Backup Log Exporter configuration for R8X based systems (SMS, MDSM)' >> ${tempENVHELPFILEalias}
fi

alias report_cpwd_admin_list='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/report_cpwd_admin_list'
alias report_admin_status='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/report_cpwd_admin_list'
alias watch_cpwd_admin_list='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/watch_cpwd_admin_list'
alias admin_status='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/watch_cpwd_admin_list'
echo 'report_cpwd_admin_list       :  Report management services status' >> ${tempENVHELPFILEalias}
echo 'report_admin_status          :  Report management services status' >> ${tempENVHELPFILEalias}
echo 'watch_cpwd_admin_list        :  Display watch of management services status' >> ${tempENVHELPFILEalias}
echo 'admin_status                 : Display watch of management services status' >> ${tempENVHELPFILEalias}
if [ -r ${MYWORKFOLDERSCRIPTSB4CP}/restart_mgmt ] ; then
    alias restart_mgmt='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/restart_mgmt'
    echo 'restart_mgmt                 :  Execute and document a restart of management services' >> ${tempENVHELPFILEalias}
fi

alias alias_commands_add_user='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/alias_commands_add_user'
alias alias_commands_add_all_users='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/alias_commands_add_all_users'
alias alias_commands_update_user='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/alias_commands_update_user'
alias alias_commands_update_all_users='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/alias_commands_update_all_users'
echo 'alias_commands_add_user      : Add alias commands to current user' >> ${tempENVHELPFILEalias}
echo 'alias_commands_add_all_users :  Add alias commands to all user' >> ${tempENVHELPFILEalias}
echo 'alias_commands_update_user   :  Update alias commands to current user' >> ${tempENVHELPFILEalias}
echo -e 'alias_commands_update_all_users :'"\n"'                             ::  Update alias commands to current user' >> ${tempENVHELPFILEalias}

#alias alias_commands_CORE_G2_NPM_add_user='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/alias_commands_CORE_G2_NPM_add_user'
#alias alias_commands_CORE_G2_NPM_add_all_users='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/alias_commands_CORE_G2_NPM_add_all_users'
#alias alias_commands_CORE_G2_NPM_update_user='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/alias_commands_CORE_G2_NPM_update_user'
#alias alias_commands_CORE_G2_NPM_update_all_users='cd ${MYWORKFOLDERUGEX};${MYWORKFOLDERSCRIPTSB4CP}/alias_commands_CORE_G2_NPM_update_all_users'
#echo -e 'alias_commands_CORE_G2_NPM_add_user :'"\n"'                             ::  Add alias commands for CORE_G2_NPM to current user' >> ${tempENVHELPFILEalias}
#echo -e 'alias_commands_CORE_G2_NPM_add_all_users :'"\n"'                             ::  Add alias commands for CORE_G2_NPM to all user' >> ${tempENVHELPFILEalias}
#echo -e 'alias_commands_CORE_G2_NPM_update_user :'"\n"'                             ::  Update alias commands for CORE_G2_NPM to current user' >> ${tempENVHELPFILEalias}
#echo -e 'alias_commands_CORE_G2_NPM_update_all_users  :'"\n"'                             ::  Update alias commands for CORE_G2_NPM to current user' >> ${tempENVHELPFILEalias}


#========================================================================================
#========================================================================================
# 2020-09-30, 2020-11-11
#

# Add function to save the help output from a command to a file in the Upgrade Export Reference Folder
#

echo 'help2reference <command>     :  Document help for <command> to Reference folder' >> ${tempENVHELPFILEalias}

help2reference () 
{ 
    referencefile="${MYWORKFOLDERREFERENCE}/help.$1.`HOSTCPVERSIONNOW`.txt"
    echo > $referencefile
    echo 'referencefile = '$referencefile | tee -a -i $referencefile
    echo 'Command = '"$@" --help | tee -a -i $referencefile
    echo | tee -a -i $referencefile
    "$@" --help >> $referencefile 2>> $referencefile
    echo | tee -a -i $referencefile
    list $referencefile
    echo
}


#========================================================================================
#========================================================================================
# 2020-09-30, 2020-11-11, 2020-11-18
#

# Add function to save the help output from a command to a file in the Upgrade Export Reference Folder
#

echo 'docset2reference             :  Document set output to Reference folder' >> ${tempENVHELPFILEalias}

docset2reference () 
{ 
    referencefile="${MYWORKFOLDERREFERENCE}/help.set.`HOSTCPVERSIONNOW`.txt"
    echo 'Document set output to Reference folder file:  '$referencefile
    echo
    set > $referencefile
    echo
    list $referencefile
    echo
}


# 2020-11-18
# Add function to save the help output from a command to a file in a NOW Upgrade Export dump Folder
#

echo 'docset2dumpnow               :  Document set output to dump folder with DTG NOW' >> ${tempENVHELPFILEalias}

docset2dumpnow () 
{ 
    DTGSNOW=`DTGSDATE`
    dumpnowfolder=${MYWORKFOLDERDUMP}/$DTGSNOW
    mkdir -pv "${dumpnowfolder}"
    referencefile="${dumpnowfolder}/current.set.`HOSTCPVERSIONNOW`.txt"
    echo 'Document set output to dump folder with DTG NOW :  '$referencefile
    echo
    set > $referencefile
    echo
    list "${dumpnowfolder}/"
    echo
}


#========================================================================================
#========================================================================================
# 2020-11-20
#

# Add function to show status of CPUSE and upgrade tools
#

echo 'CPUSE_status                 :  Show status of CPUSE and upgrade tools' >> ${tempENVHELPFILEalias}

CPUSE_status () 
{ 
    echo
    echo 'Show status of CPUSE and upgrade tools'
    echo
    echo 'Try to get Upgrade Tools version: '
    cpprod_util CPPROD_GetValue CPupgrade-tools-${gaiaversion} BuildNumber 1
    echo
    echo 'Document clish Installer status and packages: '
    clish -i -c "show installer status all"
    echo
    clish -i -c "show installer packages all"
    echo
    echo 'Document da_cli installer status and packages: '
    da_cli da_status
    echo
    da_cli get_version
    echo
    da_cli edit_configuration operation=show_config
    echo
    da_cli upgrade_tools_update_status
    echo
    da_cli packages_info status=all
    echo
}


#========================================================================================
#========================================================================================
# 2020-05-30
#

# Add function to show the variables exported (set) in this script
#

echo '_list_custom_user_vars       :  List all custom variables' >> ${tempENVHELPFILEalias}

_list_custom_user_vars () 
{ 
    echo
    echo '==============================================================================='
    echo 'List Custom User variables set by alias_commands.add.all'
    echo '==============================================================================='
    echo
    
    echo 'variable :  SCRIPTVERBOSE               ='"${SCRIPTVERBOSE}"
    echo 'variable :  NOWAIT                      ='"${NOWAIT}"
    echo 'variable :  NOSTART                     ='"${NOSTART}"
    
    echo 'variable :  MYWORKFOLDER                ='"${MYWORKFOLDER}"
    echo 'variable :  MYWORKFOLDERSCRIPTS         ='"${MYWORKFOLDERSCRIPTS}"
    echo 'variable :  MYWORKFOLDERSCRIPTSB4CP     ='"${MYWORKFOLDERSCRIPTSB4CP}"
    echo 'variable :  MYWORKFOLDERTOOLS           ='"${MYWORKFOLDERTOOLS}"
    echo 'variable :  MYWORKFOLDERDOWNLOADS       ='"${MYWORKFOLDERDOWNLOADS}"
    echo 'variable :  MYWORKFOLDERUGEX            ='"${MYWORKFOLDERUGEX}"
    echo 'variable :  MYWORKFOLDERUGEXSCRIPTS     ='"${MYWORKFOLDERUGEXSCRIPTS}"
    echo 'variable :  MYWORKFOLDERCHANGE          ='"${MYWORKFOLDERCHANGE}"
    echo 'variable :  MYWORKFOLDERDUMP            ='"${MYWORKFOLDERDUMP}"s
    echo 'variable :  MYWORKFOLDERREFERENCE       ='"${MYWORKFOLDERREFERENCE}"
    echo
    
    echo 'variable :  JQ                          ='"${JQ}"
    echo 'variable :  JQ16PATH                    ='"${JQ16PATH}"
    echo 'variable :  JQ16FILE                    ='"${JQ16FILE}"
    echo 'variable :  JQ16FQFN                    ='"${JQ16FQFN}"
    echo 'variable :  JQ16                        ='"${JQ16}"
    echo
    
    echo 'variable :  MYTFTPSERVER1               ='"${MYTFTPSERVER1}"
    echo 'variable :  MYTFTPSERVER2               ='"${MYTFTPSERVER2}"
    echo 'variable :  MYTFTPSERVER3               ='"${MYTFTPSERVER3}"
    echo 'variable :  MYTFTPSERVER                ='"${MYTFTPSERVER}"
    echo 'variable :  MYTFTPFOLDER                ='"${MYTFTPFOLDER}"
    echo
    
    echo 'variable :  MYSMCFOLDER                 ='"$MYSMCFOLDER"
    echo
    
    echo '==============================================================================='
    echo '==============================================================================='
    echo
    
}


#========================================================================================
# Build environment help file
#========================================================================================

cat ${tempENVHELPFILEvars} >> ${ENVIRONMENTHELPFILE}
rm -f ${tempENVHELPFILEvars}
tempENVHELPFILEvars=

cat ${tempENVHELPFILEalias} >> ${ENVIRONMENTHELPFILE}
rm -f ${tempENVHELPFILEalias}
tempENVHELPFILEalias=

echo >> ${ENVIRONMENTHELPFILE}
echo '===============================================================================' >> ${ENVIRONMENTHELPFILE}
echo 'MyBasementCloud bash Environment, Scripts :  Version '${ScriptVersion}', Revision '${ScriptRevision}' from Date '${ScriptDate} >> ${ENVIRONMENTHELPFILE}
echo '===============================================================================' >> ${ENVIRONMENTHELPFILE}
echo '===============================================================================' >> ${ENVIRONMENTHELPFILE}
echo >> ${ENVIRONMENTHELPFILE}

list ${ENVIRONMENTHELPFILE}

echo
echo 'Configuration of User Environment completed!'
echo 'Display help regarding configured variables and aliases with command :  show_environment_help'
echo

#========================================================================================
#========================================================================================
# End of alias.commands.<action>.<scope>.sh
#========================================================================================
#========================================================================================

