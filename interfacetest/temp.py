# -*- coding: UTF-8 -*-
import time, datetime
import json
import requests
import random

activityType = 'activity_type_theme'
scope = 'WealthManagementCenter_allcountry'
launchSystem = 'activity_launchSystem_crm'

current_time = str(datetime.datetime.now())[0:19]
reservationStartTime = str(datetime.datetime.now() - datetime.timedelta(hours=50))[0:19]
reservationEndTime = str(datetime.datetime.now() - datetime.timedelta(hours=30))[0:19]
activityStartTime = str(datetime.datetime.now() - datetime.timedelta(hours=20))[0:19]
activityEndTime = str(datetime.datetime.now() + datetime.timedelta(hours=30))[0:19]

data = {}
data['activityName'] = 'autoNo-' + current_time
data['activityNotice'] = 'For Robotframework Test'
data['introduction'] = 'For Robotframework Test'
data['activityType'] = activityType
data['address'] = '广东路'
data['url'] = 'crm.anxintrust.net'
data['scope'] = scope
data['reservationStartTimeText'] = reservationStartTime
data['reservationEndTimeText'] = reservationEndTime
data['activityStartTimeText'] = activityStartTime
data['activityEndTimeText'] = activityEndTime
data['condition'] = 'activity_conditions_conditions1'
data['canSurpass'] = '1'
data['targetCustType'] = 'activity_target_customer'
data['attendeeUpperLimit'] = '100'
data['singleCustreservationUpperLimit'] = '3'
data['allowAuthorize'] = '1'
data['allowAuthorizeInstCustNumber'] = '1'
data['allowAuthorizeIndiCustNumber'] = '1'
data['canFinancialManagerReservation'] = '1'
data['launchSystem'] = launchSystem
data['requireReview'] = '1'
data['publishStatus'] = 'activity_publishStatus_published'
data['allowwithrelatives'] = '1'

jsondata = json.dumps(data)
print str(jsondata)

