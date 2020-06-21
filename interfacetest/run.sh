#!/usr/bin/env bash
#rm interfaceoutput/*.xml
#robot --timestampoutputs --log mylog.html --report NONE --outputdir interfaceoutput/ interfacetest.robot
#python output2db.py

#rm interfaceoutput/*.xml
#robot --timestampoutputs --log mylog.html --report NONE --outputdir interfaceoutput/ mycustomers.robot
#python output2db.py

#rm interfaceoutput/*.xml
#robot --timestampoutputs --log mylog.html --report NONE --outputdir interfaceoutput/ worklog.robot
#python output2db.py

#rm interfaceoutput/*.xml
#robot --timestampoutputs --log mylog.html --report NONE --outputdir interfaceoutput/ sales.robot
#python output2db.py

#rm interfaceoutput/*.xml
#robot --timestampoutputs --log mylog.html --report NONE --outputdir interfaceoutput/ reportcenter.robot
#python output2db.py

rm interfaceoutput/*.xml
robot --timestampoutputs --log mylog.html --report NONE --outputdir interfaceoutput/ deputesale.robot
python output2db.py

#rm interfaceoutput/*.xml
#robot --timestampoutputs --log mylog.html --report NONE --outputdir interfaceoutput/ homepage.robot
#python output2db.py
