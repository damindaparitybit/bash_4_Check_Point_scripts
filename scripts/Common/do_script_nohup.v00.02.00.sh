#!/bin/bash
#
# SCRIPT Execute named script in CLI parameter with NOHUP and rest of CLI parameters
#
# (C) 2016-2018 Eric James Beasley, @mybasementcloud, https://github.com/mybasementcloud/bash_4_Check_Point_scripts
#
ScriptTemplateLevel=001
ScriptVersion=00.02.00
ScriptDate=2019-01-14
#

export BASHScriptVersion=v00x02x00
export BASHScriptTemplateLevel=$ScriptTemplateLevel
export BASHScriptName="do_script_nohup.v$ScriptVersion"
export BASHScriptShortName="do_script_nohup"
export BASHScriptDescription="Execute named script in CLI parameter with NOHUP and rest of CLI parameters"

# -------------------------------------------------------------------------------------------------
# Date variable configuration
# -------------------------------------------------------------------------------------------------

export DATE=`date +%Y-%m-%d-%H%M%Z`
export DATEDTG=`date +%Y-%m-%d-%H%M%Z`
export DATEDTGS=`date +%Y-%m-%d-%H%M%S%Z`
export DATEYMD=`date +%Y-%m-%d`

WAITTIME=20

echo
echo $BASHScriptDescription', script version '$ScriptVersion' from '$ScriptDate
echo

if [ -x $1 ]; then
    export script2nohup=$1
    export script2nohupstdoutlog=$script2nohup.nuhup.stdout.$DATEDTGS.txt
    export script2nohupstderrlog=$script2nohup.nuhup.stderr.$DATEDTGS.txt

    touch $script2nohupstdoutlog
    touch $script2nohupstderrlog

    echo >> $script2nohupstdoutlog
    echo $BASHScriptDescription', script version '$ScriptVersion' from '$ScriptDate >> $script2nohupstdoutlog
    echo >> $script2nohupstdoutlog
   
    echo 'Execute script : '$script2nohup' with NOHUP, all paramters' | tee -a -i $script2nohupstdoutlog
    echo '  and dump stdout to log file : '$script2nohupstdoutlog | tee -a -i $script2nohupstdoutlog
    echo '  and dump stderr to log file : '$script2nohupstderrlog | tee -a -i $script2nohupstdoutlog
    echo | tee -a -i $script2nohupstdoutlog

    cat $script2nohupstdoutlog >> $script2nohupstderrlog

    #nohup $script2nohup >> $script2nohupstdoutlog 2>> $script2nohupstderrlog
    nohup "$@" >> $script2nohupstdoutlog 2>> $script2nohupstderrlog &
else
    echo 'Script file : '$1' either does not exist or is not executable!'
    echo 'Exiting!!!!!'
    echo
fi 

echo
