# bash_4_Check_Point_scripts
Collection of bash scripts for use on Check Point Gaia systems

mybasementcloud operational implemented working Gaia and bash script examples

NOTE:  !!!!! TO USE THESE SCRIPTS DO NOT PLACE IN /home/<user> FOLDER !!!!

These scripts are currently in deployment in the mybasementcloud environment and used to operate, document, and administer the mybasementcloud Check Point systems.

Specific examples and operation for:
- _template - templates for bash scripts, may include some canned plumbing
- Common - general use scripts
- Config - Configuration capture for Gaia (might work on SPLAT and Linux, not tested on those)
- GW - Gateway systems
- Health_Check - System Health Check Script as provided in sk121447, including example of how to collect the generated files into a dump file location
- MDM - Multi-Domain Management Server systems
- Patch_HotFix - scripts that fix things
- Session_Cleanup - Example of how to execute a session clean-up script to remove dead, zerolock sessions that might accumulate in API enabled R8X management systems, now includes MDM example.
- SmartEvent - SmartEvent related scripts for common operations, e.g. backup SmartEvent index and database files
- SMS - Security Management Server systems
- UserConfig - User configuration actions for bash CLI operations, like adding standard alias entries, etc.  Must be run by the specific user to execute configuration, which is available at next logon.

NOTES:
- Session_Cleanup 
  For MDM operations include "-d <MDM_Domain>" and any other specific command extensions to mgmt_cli which is run with "-r true".  So if you need to specify the management server web ssl-port add "--port <port>".
  Examples:  
    mdm_show_zerolocks_sessions.v00.03.00.sh --port 4434 -d "Global"
    mdm_show_zerolocks_sessions.v00.03.00.sh --port 4434 -d "System Data"

- Moved to new working folder /var/log/__customer/ from /var/ ; this is to hedge against los of files and information due to upgrade, like CPUSE operation for R80.20.M1 (and later)


Reference Check Point Secure Knowledge (SK) articles:
sk121447 (https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk121447)
