from openconfig_system import openconfig_system
import pyangbind.lib.pybindJSON as pybindJSON
import json

oc_system  = openconfig_system()

oc_system.system.config.hostname = 'CN6508P-7169'
system = getattr(oc_system,'system')
config = getattr(system,'config')
setattr(oc_system,'system.config.hostname','RAMAN')
#alarm = oc_system.system.alarms.alarm.add("123232")
#alarm.state.severity  = 'MINOR'
#alarm.state.resource  = 'ETTP-1-3-3'
#alarm.state.text  = 'T-UAS-PCS'
#alarm.state.time_created  = 723423232 
#alarm.state.type_id  = 'EQPT' 
#alarm.state.alarm_ref_id  = '010000000000-0000-0000' 
#alarm.state.type  = 'ALARM' 
#alarm.state.CardType  = 'PTS MRO I/F|| 2xSFP+/14xSFP' 
#alarm.state.AID  = 'ETTP' 
#alarm.state.direction  = 'RCV' 
#alarm.state.location  = 'NEND' 
#alarm.state.ServiceEffect  = 'NON_SERVICE_AFFECTION' 

print (pybindJSON.dumps(oc_system))

