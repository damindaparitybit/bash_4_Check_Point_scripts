#!/bin/bash
#
# SCRIPT execute operation to fix Gaia webUI logon problem for Chrome and FireFox
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
ScriptDate=2020-12-22
ScriptVersion=05.02.00
ScriptRevision=000
TemplateVersion=05.02.00
TemplateLevel=006
SubScriptsLevel=NA
SubScriptsVersion=NA
#

export BASHScriptVersion=v${ScriptVersion}
export BASHScriptTemplateVersion=v${TemplateVersion}

export BASHScriptVersionX=v${ScriptVersion//./x}
export BASHScriptTemplateVersionX=v${TemplateVersion//./x}

export BASHScriptTemplateLevel=${TemplateLevel}.v${TemplateVersion}

export BASHSubScriptsVersion=v${SubScriptsVersion}
export BASHSubScriptTemplateVersion=v${TemplateVersion}
export BASHExpectedSubScriptsVersion=${SubScriptsLevel}.v${SubScriptsVersion}

export BASHSubScriptsVersionX=v${SubScriptsVersion//./x}
export BASHSubScriptTemplateVersionX=v${TemplateVersion//./x}
export BASHExpectedSubScriptsVersionX=${SubScriptsLevel}.v${SubScriptsVersion//./x}

export BASHScriptFileNameRoot=fix_gaia_webui_login_dot_js_generic
export BASHScriptShortName=fix_gaia_webui_login_dot_js_generic.v${ScriptVersion}
export BASHScriptnohupName=${BASHScriptShortName}
export BASHScriptDescription="Execute operation to fix Gaia webUI logon problem for Chrome and FireFox"

#export BASHScriptName=${BASHScriptFileNameRoot}.${TemplateLevel}.v${ScriptVersion}
export BASHScriptName=${BASHScriptFileNameRoot}

export BASHScriptHelpFileName=${BASHScriptFileNameRoot}.help
export BASHScriptHelpFilePath=help.v${ScriptVersion}
export BASHScriptHelpFile=${BASHScriptHelpFilePath}/${BASHScriptHelpFileName}

# _api_subscripts|_hostsetupscripts|_hostupdatescripts|_scripting_tools|_subscripts|_template|Common|Config|GAIA|GW|[GW.CORE]|Health_Check|MDM|MGMT|Patch_Hotfix|Session_Cleanup|SmartEvent|SMS|[SMS.CORE]|SMS.migrate_backup|UserConfig|[UserConfig.CORE_G2.NPM]
export BASHScriptsFolder=Patch_Hotfix

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

export DATEUTC=`date -u +%Y-%m-%d-%H%M%Z`
export DATEUTCDTG=`date -u +%Y-%m-%d-%H%M%Z`
export DATEUTCDTGS=`date -u +%Y-%m-%d-%H%M%S%Z`
export DATEUTCYMD=`date -u +%Y-%m-%d`


# -------------------------------------------------------------------------------------------------
# Other variable configuration
# -------------------------------------------------------------------------------------------------


# WAITTIME in seconds for read -t commands
export WAITTIME=60

export outputpathroot=/var/tmp/Change_Log
export outputpathbase=${outputpathroot}/${DATEDTGS}


# -------------------------------------------------------------------------------------------------
# Start Script
# -------------------------------------------------------------------------------------------------


# UPDATED 2020-09-17 -
# -------------------------------------------------------------------------------------------------
# Announce Script, this should also be the first log entry!
# -------------------------------------------------------------------------------------------------

echo
echo ${BASHScriptDescription}', script version '${ScriptVersion}', revision '${ScriptRevision}' from '${ScriptDate}
echo


# -------------------------------------------------------------------------------------------------
# -------------------------------------------------------------------------------------------------


if [ ! -r ${outputpathroot} ] 
then
    mkdir -pv ${outputpathroot}
fi
if [ ! -r ${outputpathbase} ] 
then
    mkdir -pv ${outputpathbase}
fi

sed -i.bak '/form.isValid/s/$/\nform.el.dom.action=formAction;\n/' /web/htdocs2/login/login.js
cp /web/htdocs2/login/login.js* ${outputpathbase}


echo 'Created folder :  '${outputpathbase}
echo
ls -al ${outputpathbase}
echo


# -------------------------------------------------------------------------------------------------
# End of script
# -------------------------------------------------------------------------------------------------


if [ -r nul ] ; then
    rm nul
fi

if [ -r None ] ; then
    rm None
fi

echo
echo 'Script Completed, exiting...';echo

