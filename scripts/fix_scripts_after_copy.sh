#!/bin/bash
#
# SCRIPT Fix Scripts After Copy
#
# (C) 2017-2018 Eric James Beasley
#
ScriptVersion=00.01.00
ScriptDate=2018-05-25
#

export BASHScriptVersion=v00x01x00

# =============================================================================
# =============================================================================
# 
# =============================================================================

dos2unix *.sh
dos2unix Common/*.sh
dos2unix Config/*.sh
dos2unix GW/*.sh
dos2unix Health_Check/*.sh
dos2unix MDM/*.sh
dos2unix Patch_HotFix/*.sh
dos2unix SMS/*.sh
dos2unix Session_Cleanup/*.sh
dos2unix UserConfig/*.sh

# =============================================================================
# =============================================================================
# 
# =============================================================================

# =============================================================================
# =============================================================================
