from vzalarmrw import alarm_system
import pyangbind.lib.pybindJSON as pybindJSON

alarms  = alarm_system()
alarm = alarms.alarm_system.alarms.alarm.add("123232") 
alarm.state.layer="L1";
print (pybindJSON.dumps(alarms,mode="ietf"))
