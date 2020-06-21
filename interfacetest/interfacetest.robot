*** Settings ***
Library           RequestsLibrary
Library           RsaEncryption
Library           Collections
Library           ReadExcel
Library           MongoDBLibrary
Library           DateTime
Library           SeleniumLibrary
Library           CreateData
Library           String
Resource          resource.robot

*** Test Cases ***
#Valid Login by Interface
#    Login To Crm    hao.yao    1

#Valid Login Backend by Browser
#    Valid Login Backend by Browser  hao.yao   1

#Valid Login Sales by Browser
#    Valid Login Sales by Browser  richard.qian  1

#Search Activity by Browser
#    Search Activity by Browser    hao.yao    1    AUTOTEST-example
#    [Teardown]    Close Browser

#Add Activity by Browser Successfully
#    Add Activity by Browser Successfully

#Add Activity and Cancel by Browser
#    Add Activity and Cancel by Browser

#Add Activity With RLR by Browser
#    Add Activity With RLR by Browser

#Add Activity with ALA by Browser
#    Add Activity with ALA by Browser

#Edit Activity and Cancel by Browser
#    Edit Activity and Cancel by Browser

#Edit Activity and Save by Browser
#    Edit Activity and Save by Browser

#View Reservation Page by Browser
#    View Reservation Page by Browser

#Search Customer Name by Browser
#    Search Customer Name by Browser

#Agree Not Agree by Browser
#    Agree Not Agree by Browser

#Check in by Browser
#    Check in by Browser

#Search Reservation Info by Browser
#    Search Reservation Info by Browser

#Finished Activity Should Not Be Operated
#    Finished Activity Should Not Be Operated

#Add Arrived Customers by Browser
#    Add Arrived Customers by Browser

#Cancel and Edit Reservation by Browser
#    Cancel and Edit Reservation by Browser

#Broker Can See Same Scope
#    Broker Can See Same Scope

#Broker Can See All Country
#    Broker Can See All Country

#Broker Can Not See Different Scope
#    Broker Can Not See Different Scope

#Not Broker Can Not See Activity
#    Not Broker Can Not See Activity

#Web Can Not See App Activity
#    Web Can Not See App Activity

#Reservation Limit Can Not Surpass
#    Reservation Limit Can Not Surpass    hao.yao    1

Broker Can Not See Unpubished Activity
    Broker Can Not See Unpubished Activity

Broker Can Not See Not Reservable Activity
    Broker Can Not See Not Reservable Activity

#Add Activity
#    ${token}    Login To Crm  hao.yao    1
#    ${rslt}     Add Activity    ${token}

#Add Customer
#    ${token}    Login To Crm  hao.yao    1
#    ${rslt}     Add Customer    ${token}

#Cancel Reservation
#    ${token}    Login To Crm  hao.yao    1
#    ${rslt}     Cancel Reservation    ${token}

#Read excel
#    ${rslt}     Read Excel      addActivity.xlsx

*** Keywords ***
Login To Crm
    [Arguments]                        ${username}              ${password}
    Create Session                     crm                      https://interface.anxintrust.net/sit/crm
    ${resp}                            Get Request              crm    security/publicKey/${username}
    ${token}                           RsaEncryption.encryption  ${resp.json()}    ${password}
    ${json}                            To Json                  {"username":"${username}", "password":"${token}"}
    ${head}                            To Json                   {"Content-Type":"application/json"}
    ${head}                            Convert To Dictionary    ${head}
    ${info}                            Post Request             crm    login    ${json}    /   ${head}
    Dictionary Should Contain Value    ${info.json()}           SUC0001
    ${token}                           Convert To Dictionary     ${info.json()}
    [Return]                           ${token}

Add Activity
    [Arguments]                        ${token}
    ${data}                            To Json                  ${ACTINFO}
    ${head}                            String To Dictionary     {"Content-Type":"application/json", "Authorization":"${token['object']['token']}"}
    ${resp}                            Put Request              crm    activity/addActivity    ${data}    ${head}
    Dictionary Should Contain Value    ${resp.json()}           SUC0001
    ${data}                            To Json                  ${ACTSEARCH}
    ${resp}                            Post Request             crm    activity/getListFromBackend    ${data}    /    ${head}
    Dictionary Should Contain Value    ${resp.json()['object']['list'][0]}           ${ACTNAME}
    [Return]                           SUC0001

Add Customer
    [Arguments]                        ${token}
    ${data}                            To Json                  ${CUSTINFO}
    ${head}                            String To Dictionary     {"Content-Type":"application/json", "Authorization":"${token['object']['token']}"}
    ${resp}                            Put Request              crm    activity/addCustomers    ${data}    ${head}
    Dictionary Should Contain Key      ${resp.json()}           message
    ${data}                            To Json                  ${CUSTSEARCH}
    ${resp}                            Post Request             crm    activity/getCustomerDetailList    ${data}    /    ${head}
    Dictionary Should Contain Value    ${resp.json()['object']['list'][0]}           ${CUSTNO}
    [Return]                           SUC0001

Cancel Reservation
    [Arguments]                        ${token}
    ${data}                            To Json                  ${RESERNO}
    ${head}                            String To Dictionary     {"Content-Type":"application/json", "Authorization":"${token['object']['token']}"}
    ${resp}                            Post Request             crm    activity/cancelReservation    ${data}    /    ${head}
    Dictionary Should Contain Key      ${resp.json()}           message
    ${data}                            To Json                  ${RESESEARCH}
    ${resp}                            Post Request             crm    activity/getCustomerDetailList    ${data}    /    ${head}
    Dictionary Should Contain Value    ${resp.json()['object']['list'][1]}           ${CANCEL}
    [Return]                           SUC0001

Valid Login Backend by Browser
    [Arguments]                        ${username}              ${password}
    Login by Browser                   ${username}              ${password}
    User Permission Is Backend
    [Teardown]    Close Browser

Valid Login Sales by Browser
    [Arguments]                        ${username}              ${password}
    Login by Browser                   ${username}              ${password}
    User Permission Is Sales
    [Teardown]    Close Browser

Search Activity by Browser
    [Arguments]                        ${username}              ${password}    ${activity}
    Open Browser To Login Page
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Go To Activity Manager
    Wait Until Page Contains Element    //*[label='活动名称']
    Input Text                          //*[@placeholder='请输入活动名称']    ${activity}
    #Click Element                       //*[@placeholder='请选择']
    #Click Element                       //*[span='已发布']
    Click Element                       //*[span='查 询']
    #${resp}                             Get Activity Info from Backend    ${username}              ${password}    ${activity}
    ${new}                              Get Text    //*[@class='el-table__body']/tbody/tr/td[1]/div
    Should Be Equal                     ${activity}    ${new}

Add Activity by Browser Successfully
    Login by Browser                    hao.yao    1
    Add New Activity
    [Teardown]    Close Browser

Add Activity and Cancel by Browser
    Login by Browser                    hao.yao    1
    Add Info and Cancel
    [Teardown]    Close Browser

Add Activity with RLR by Browser
    Login by Browser                    hao.yao    1
    Reservation End LT Reservation Start
    [Teardown]    Close Browser

Add Activity with ALA by Browser
    Login by Browser                    hao.yao    1
    Activity End LT Activity Start
    [Teardown]    Close Browser

Add Activity with ALR by Browser
    Login by Browser                    hao.yao    1
    Activity Start LT Reservation End
    [Teardown]    Close Browser

Edit Activity and Cancel by Browser
    Login by Browser                    hao.yao    1
    Edit Activity and Cancel
    [Teardown]    Close Browser

Edit Activity and Save by Browser
    Login by Browser                    hao.yao    1
    Edit Activity and Save
    [Teardown]    Close Browser

View Reservation Page by Browser
    Login by Browser                    hao.yao    1
    Go to Reservation Example
    [Teardown]    Close Browser

Search Customer Name by Browser
    Login by Browser                    hao.yao    1
    Go to Reservation Example
    Search Customer Name
    [Teardown]    Close Browser

Agree Not Agree by Browser
    Not Start Activity with Customers
    Login by Browser                    hao.yao    1
    Go To Activity Manager
    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[2]
    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[2]
    Wait Until Page Contains Element    //*[span='同意']
    Click Element                       //*[@class='el-table__body']/tbody/tr[1]/td[8]/div/button[1]/span
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[1]/span
    Click Element                       //*[@class='el-message-box__btns']/button[1]/span
    Wait Until Page Contains Element    //*[span='同意']
    Click Element                       //*[@class='el-table__body']/tbody/tr[1]/td[8]/div/button[1]/span
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[2]/span
    Click Element                       //*[@class='el-message-box__btns']/button[2]/span
    Wait Until Page Contains Element    //*[span='同意']
    Click Element                       //*[@class='el-table__body']/tbody/tr[2]/td[8]/div/button[2]/span
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[1]/span
    Click Element                       //*[@class='el-message-box__btns']/button[1]/span
    Wait Until Page Contains Element    //*[span='同意']
    Click Element                       //*[@class='el-table__body']/tbody/tr[2]/td[8]/div/button[2]/span
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[2]/span
    Click Element                       //*[@class='el-message-box__btns']/button[2]/span
    [Teardown]    Close Browser

Check in by Browser
    Started Activity with Customers
    Login by Browser                    hao.yao    1
    Go To Activity Manager
    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[2]
    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[2]
    Wait Until Page Contains Element    //*[span='同意']
    Click Element                       //*[@class='el-table__body']/tbody/tr[1]/td[8]/div/button[1]/span
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[2]/span
    Click Element                       //*[@class='el-message-box__btns']/button[2]/span
    Wait Until Page Contains Element    //*[span='同意']
    Click Element                       //*[@class='el-table__body']/tbody/tr[1]/td[8]/div/button[3]/span
    Wait Until Page Contains Element    //*[span='保存']
    Click Element                       //*[span='取消']
    Wait Until Page Contains Element    //*[span='同意']
    Click Element                       //*[@class='el-table__body']/tbody/tr[1]/td[8]/div/button[3]/span
    Wait Until Page Contains Element    //*[span='保存']
    Click Element                       //*[span='保存']
    [Teardown]    Close Browser

Search Reservation Info by Browser
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Search Reservation Info
    Click Element                       //*[@id='tab-Finished']
    Wait Until Page Contains Element    //*[a='测试测试']
    Page Should Contain Element         //*[a='测试测试']
    [Teardown]    Close Browser

Finished Activity Should Not Be Operated
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Search Reservation Info
    Click Element                       //*[@id='tab-Finished']
    Wait Until Page Contains Element    //*[a='测试测试']
    Click Element                       //*[@id='pane-Finished']/div/div/div/div/div/div/a
    Wait Until Page Contains Element    //*[span='取消预约']
    Element Should Be Disabled          //*[span='取消预约']
    Element Should Be Disabled          //*[span='修改报名']
    Element Should Be Disabled          //*[span='签到']
    [Teardown]    Close Browser

Add Arrived Customers by Browser
    Started Activity with Customers
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Wait Until Page Contains Element    //*[@id='tab-haveInHand']
    Click Element                       //*[@id='tab-haveInHand']
    Wait Until Page Contains Element    //*[@id='pane-haveInHand']/div/div/div[1]/div/div/div/a
    Click Element                       //*[@id='pane-haveInHand']/div/div/div[1]/div/div/div/a
    Wait Until Page Contains Element    //*[span='添加实际到场人']
    Click Element                       //*[span='添加实际到场人']
    Wait Until Page Contains Element    //*[@class='external_button']/button/span
    Click Element                       //*[@class='external_button']/button/span
    Wait Until Page Contains Element    //*[@placeholder='请输入客户姓名']
    Input Text                          //*[@placeholder='请输入客户姓名']    董凤成
    Click Element                       //*[@placeholder='请输入客户姓名']/parent::div/div/button
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr/td/div/label/span/span
    Click Element                       //*[@class='el-table__body']/tbody/tr/td/div/label/span/span
    Click Element                       //*[span='确定']
    Wait Until Page Contains Element    //*[span='保存']
    Click Element                       //*[span='保存']
    [Teardown]    Close Browser

Cancel and Edit Reservation by Browser
    Not Start Activity with Customers
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Wait Until Page Contains Element    //*[@id='tab-canSignUp']
    Click Element                       //*[@id='tab-canSignUp']
    Wait Until Page Contains Element    //*[@id='pane-canSignUp']/div/div/div[1]/div/div/div/a
    Click Element                       //*[@id='pane-canSignUp']/div/div/div[1]/div/div/div/a
    Wait Until Page Contains Element    //*[span='我要报名']
    Click Element                       //*[span='我要报名']
    Wait Until Page Contains Element    //*[@class='external_button']/button/span
    Click Element                       //*[@class='external_button']/button/span
    Wait Until Page Contains Element    //*[@placeholder='请输入客户姓名']
    Input Text                          //*[@placeholder='请输入客户姓名']    董凤成
    Click Element                       //*[@placeholder='请输入客户姓名']/parent::div/div/button
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr/td/div/label/span/span
    Click Element                       //*[@class='el-table__body']/tbody/tr/td/div/label/span/span
    Click Element                       //*[span='确定']
    Wait Until Page Contains Element    //*[span='保存']
    Click Element                       //*[span='保存']
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr[1]/td[7]/div/button[2]/span
    Click Element                       //*[@class='el-table__body']/tbody/tr[1]/td[7]/div/button[2]/span
    Wait Until Page Contains Element    //*[span='保存']
    Click Element                       //*[span='保存']
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr[1]/td[7]/div/button[1]/span
    Click Element                       //*[@class='el-table__body']/tbody/tr[1]/td[7]/div/button[1]/span
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[2]
    Click Element                       //*[@class='el-message-box__btns']/button[2]
    [Teardown]    Close Browser

Broker Can See Same Scope
    Search Activity by Browser                    hao.yao    1    Robot_Scope_Test
    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Click Element                       //*[@class='container_left']/div[7]/div/div/div/input
    Click Element                       //*[@class='el-select-dropdown__item'][span='黄浦网点']
    Wait Until Page Contains Element    //*[span='取消']
    Click Element                       //*[span='保存']
    Close Browser
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Wait Until Page Contains Element    //*[@placeholder='请输入市场活动关键字']
    Input Text                          //*[@placeholder='请输入市场活动关键字']    Robot_Scope_Test
    Click Element                       //*[span='查 询']
    Click Element                       //*[@id='tab-Finished']
    Wait Until Page Contains Element    //*[a='Robot_Scope_Test']
    Page Should Contain Element         //*[a='Robot_Scope_Test']
    [Teardown]    Close Browser

Broker Can See All Country
    Search Activity by Browser                    hao.yao    1    Robot_Scope_Test
    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Click Element                       //*[@class='container_left']/div[7]/div/div/div/input
    Click Element                       //*[@class='el-select-dropdown__item'][span='全国']
    Wait Until Page Contains Element    //*[span='取消']
    Click Element                       //*[span='保存']
    Close Browser
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Wait Until Page Contains Element    //*[@placeholder='请输入市场活动关键字']
    Input Text                          //*[@placeholder='请输入市场活动关键字']    Robot_Scope_Test
    Click Element                       //*[span='查 询']
    Click Element                       //*[@id='tab-Finished']
    Wait Until Page Contains Element    //*[a='Robot_Scope_Test']
    Page Should Contain Element         //*[a='Robot_Scope_Test']
    [Teardown]    Close Browser

Broker Can Not See Different Scope
    Search Activity by Browser                    hao.yao    1    Robot_Scope_Test
    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Click Element                       //*[@class='container_left']/div[7]/div/div/div/input
    Click Element                       //*[@class='el-select-dropdown__item'][span='天山网点']
    Wait Until Page Contains Element    //*[span='取消']
    Click Element                       //*[span='保存']
    Close Browser
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Wait Until Page Contains Element    //*[@placeholder='请输入市场活动关键字']
    Input Text                          //*[@placeholder='请输入市场活动关键字']    Robot_Scope_Test
    Click Element                       //*[span='查 询']
    Click Element                       //*[@id='tab-Finished']
    Page Should Not Contain Element     //*[a='Robot_Scope_Test']
    [Teardown]    Close Browser

Not Broker Can Not See Activity
    Login by Browser                    hao.yao    1
    Go To Market Activity
    Search Reservation Info
    Click Element                       //*[@id='tab-Finished']
    Sleep    2
    Page Should Not Contain Element     //*[a='测试测试']
    [Teardown]    Close Browser

Web Can Not See App Activity
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Wait Until Page Contains Element    //*[@placeholder='请输入市场活动关键字']
    Input Text                          //*[@placeholder='请输入市场活动关键字']    Robot_App_Test
    Click Element                       //*[span='查 询']
    Click Element                       //*[@id='tab-Finished']
    Page Should Not Contain Element     //*[a='Robot_App_Test']
    [Teardown]    Close Browser

Reservation Limit Can Not Surpass
    [Arguments]                        ${username}              ${password}
    Create Session                     crm                      https://interface.anxintrust.net/sit/crm
    ${resp}                            Get Request              crm    security/publicKey/${username}
    ${token}                           RsaEncryption.encryption  ${resp.json()}    ${password}
    ${json}                            To Json                  {"username":"${username}", "password":"${token}"}
    ${head}                            To Json                   {"Content-Type":"application/json"}
    ${head}                            Convert To Dictionary    ${head}
    ${info}                            Post Request             crm    login    ${json}    /   ${head}
    Dictionary Should Contain Value    ${info.json()}           SUC0001
    ${token}                           Convert To Dictionary     ${info.json()}

    ${data}                            To Json                  [{"attendeeRelationShip": "activity_attendeeRelationship_own", "attendee": "Test", "industry": "Test", "custNo": "000006716521", "custName": "Test", "attendeePhone": "13888888888", "activityNo": "ACTIVITY0000000925", "memo": "Test", "isMainAttendee": "1"}]
    ${head}                            String To Dictionary     {"Content-Type":"application/json", "Authorization":"${token['object']['token']}"}
    ${resp}                            Put Request              crm    activity/addCustomers    ${data}    ${head}
    Dictionary Should Contain Key      ${resp.json()['message']}           市场活动报名新增：活动人数上限1,当前报名成功和预约中的人数为1

Broker Can Not See Unpubished Activity
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Wait Until Page Contains Element    //*[@placeholder='请输入市场活动关键字']
    Input Text                          //*[@placeholder='请输入市场活动关键字']    Robot_Unpublish_Test
    Click Element                       //*[span='查 询']
    Click Element                       //*[@id='tab-Finished']
    Page Should Not Contain Element     //*[a='Robot_Unpublish_Test']
    [Teardown]    Close Browser

Broker Can Not See Not Reservable Activity
    Login by Browser                    richard.qian    1
    Go To Market Activity
    Wait Until Page Contains Element    //*[@placeholder='请输入市场活动关键字']
    Input Text                          //*[@placeholder='请输入市场活动关键字']    Robot_BrokerR_Test
    Click Element                       //*[span='查 询']
    Click Element                       //*[@id='tab-Finished']
    Page Should Not Contain Element     //*[a='Robot_BrokerR_Test']
    [Teardown]    Close Browser