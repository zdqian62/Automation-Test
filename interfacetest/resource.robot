*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${ACTINFO}     {"activityName":"autotest-activity-20180628","activityNotice":"Meeting","introduction":"Introduce","activityType":"activity","address":"activity_type_publicbenefit","url":"www.anxin.com","scope":"Shanghai11","reservationStartTimeText":"2018-05-01 14:30:24","reservationEndTimeText":"2018-06-03 14:30:24","activityStartTimeText":"2018-06-28 14:30:24","activityEndTimeText":"2018-06-29 14:30:24","condition":"where a=1","canSurpass":"1","targetCustType":"1","attendeeUpperLimit":"9","singleCustreservationUpperLimit":"3","allowAuthorize":"1","allowAuthorizeInstCustNumber":"13","allowAuthorizeIndiCustNumber":"14","canFinancialManagerReservation":"1","launchSystem":"activity_launchsystem_crm","requireReview":"1","publishStatus":"activity_status_published","allowwithrelatives":"1","inusestatus":"activity_inusestatus_inuse"}
${ACTSEARCH}   {"activityName":"autotest-activity-20180628","publicStatus":"","pageNumber":"0","pageSize":"10"}
${ACTNAME}     autotest-activity-20180628
${CUSTINFO}    [{"custName":"Tony","attendeeRelationShip":"activity_attendeeRelationship_own","industry":" fdf","attendeePhone":"13501234567","activityNo":"ACTIVITY0000000403","custNo":"000006716525","isMainAttendee":"1","attendee":"34134","memo":"fasffdasfd"}]
${CUSTSEARCH}  {"activityNo":"ACTIVITY0000000403"}
${CUSTNO}      000006716525
${RESERNO}     {"reservationNo":"RESERVATE0000001334"}
${RESESEARCH}  {"activityNo":"ACTIVITY0000000497", "reservationNo":"RESERVATE0000001334"}
${CANCEL}      预约取消
${SERVER}         crm.anxintrust.net/sit/#/login
${BROWSER}        Chrome
${DELAY}          0.2 seconds
${VALID USER}     hao.yao
${VALID PASSWORD}    1
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    https://crm.anxintrust.net/sit/#/index/index

*** Keywords ***
String To Dictionary
    [Arguments]  ${string}
    ${json}      To Json                    ${string}
    ${dict}      Convert To Dictionary      ${json}
    [Return]     ${dict}

Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}


Go To Login Page
    Go To    ${LOGIN URL}

Input Username
    [Arguments]    ${username}
    Wait Until Page Contains Element    //*[@name='username']
    Input Text    //*[@name='username']    ${username}

Input Password
    [Arguments]    ${password}
    Wait Until Page Contains Element    //*[@name='password']
    Input Text    //*[@name='password']    ${password}

Submit Credentials
    Click Button    //*[@class='el-form-item__content']/button

Add New Activity
    Go To Activity Manager
    Wait Until Page Contains Element    //*[@class='icon_container']
    Click Element                       //*[@class='icon_container']
    Add Necessary Activity Info
    Click Element                       //*[@class='activity_dialog']/div/button[span='保存']

Add Necessary Activity Info
    Input Text                          //*[@class='container_left']/div[1]/div/div/input       ${ACTNAME}
    Click Element                       //*[@class='container_left']/div[4]/div/div/div/input
    Wait Until Element Is Visible       //*[@class='el-select-dropdown__item'][span='公益活动']
    Click Element                       //*[@class='el-select-dropdown__item'][span='公益活动']
    Input Text                          //*[@class='container_left']/div[5]/div/div/textarea    Shanghai
    Click Element                       //*[@class='container_left']/div[7]/div/div/div/input
    Click Element                       //*[@class='el-select-dropdown__item'][span='全国']
    Click Element                       //*[@class='container_right']/div[3]/div/div/div/input
    Click Element                       //*[@class='el-select-dropdown__item'][span='事实客户']

Add Info and Cancel
    Go To Activity Manager
    Wait Until Page Contains Element    //*[@class='icon_container']
    Click Element                       //*[@class='icon_container']
    Add Necessary Activity Info
    Click Element                       //*[span='取消']

Reservation End LT Reservation Start
    Go To Activity Manager
    Wait Until Page Contains Element    //*[@class='icon_container']
    Click Element                       //*[@class='icon_container']
    Add Necessary Activity Info
    Click Element                       //*[@class='container_left']/div[8]/div/div/span[1]/i
    Wait Until Page Contains Element    //*[@aria-label='Next Month']
    Click Element                       //*[@aria-label='Next Month']
    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
    Click Element                       //*[@class='activity_dialog']/div/button[span='保存']
    Wait Until Page Contains Element   //*[@role='alert']
    Page Should Contain Element        //*[@role='alert']

Activity End LT Activity Start
    Go To Activity Manager
    Wait Until Page Contains Element    //*[@class='icon_container']
    Click Element                       //*[@class='icon_container']
    Add Necessary Activity Info
    Click Element                       //*[@class='container_left']/div[10]/div/div/span[1]/i
    Wait Until Page Contains Element    //*[@aria-label='Next Month']
    Click Element                       //*[@aria-label='Next Month']
    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
    Click Element                       //*[@class='activity_dialog']/div/button[span='保存']
    Wait Until Page Contains Element    //*[@role='alert']
    Page Should Contain Element         //*[@role='alert']

Activity Start LT Reservation End
    Go To Activity Manager
    Wait Until Page Contains Element    //*[@class='icon_container']
    Click Element                       //*[@class='icon_container']
    Add Necessary Activity Info
    Click Element                       //*[@class='container_left']/div[9]/div/div/span[1]/i
    Wait Until Page Contains Element    //*[@aria-label='Next Month']
    Click Element                       //*[@aria-label='Next Month']
    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
    Click Element                       //*[@class='activity_dialog']/div/button[span='保存']
    Wait Until Page Contains Element    //*[@role='alert']
    Page Should Contain Element         //*[@role='alert']

Edit Activity and Cancel
    Go To Activity Manager
    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Wait Until Page Contains Element    //*[span='取消']
    Click Element                       //*[span='取消']

Edit Activity and Save
    Go To Activity Manager
    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
    Wait Until Page Contains Element    //*[span='取消']
    Click Element                       //*[span='保存']

User Permission Is Backend
    Wait Until Page Contains Element   //*[span='工作日志']
    Page Should Contain Element        //*[span='后台管理']

User Permission Is Sales
    Wait Until Page Contains Element   //*[span='工作日志']
    Page Should Not Contain Element    //*[span='后台管理']

Read Excel
    [Arguments]                        ${filename}
    ${resp}                            ReadExcel.readinterface  ${filename}
    [Return]                           SUC0001

Save Into Mongodb
    [Arguments]                        ${testname}    ${rslt}
    Connect To Mongodb                 localhost    27017
    ${date}                            Get Current Date
    Save MongoDB Records               interfacetest    ${testname}    {"time":"${date}", "result":"${rslt}"}
    Disconnect From Mongodb

Go To Activity Manager
    Wait Until Page Contains Element    //*[span='后台管理']
    Click Element                       //*[span='后台管理']
    Wait Until Page Contains Element    //*[span='市场活动管理']
    Click Element                       //*[span='市场活动管理']

Get Activity Info from Backend
    [Arguments]                        ${username}              ${password}    ${activity}
    ${token}    Log In To Crm                      ${username}              ${password}
    ${head}                            String To Dictionary     {"Content-Type":"application/json", "Authorization":"${token['object']['token']}"}
    ${data}                            To Json                  {"activityName":"${activity}","publicStatus":"","pageNumber":"0","pageSize":"10"}
    ${resp}                            Post Request             crm    activity/getListFromBackend    ${data}    /    ${head}
    [Return]                           ${resp}

Login by Browser
    [Arguments]                        ${username}    ${password}
    Open Browser To Login Page
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials

Go to Reservation Example
    Go To Activity Manager
    Wait Until Page Contains Element    //*[label='活动名称']
    Input Text                          //*[@placeholder='请输入活动名称']    测试测试
    Click Element                       //*[span='查 询']
    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[2]
    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[2]
    Wait Until Page Contains Element    //*[@class='activity_name'][span='测试测试']

Search Customer Name
    Wait Until Page Contains Element    //*[@placeholder='请输入客户姓名']
    Input Text                          //*[@placeholder='请输入客户姓名']    徐冬
    Click Element                       //*[span='查 询']
    Wait Until Page Contains Element    //*[div='徐冬']
    Page Should Contain Element         //*[div='徐冬']
    Page Should Contain Element         //*[div='王欢']
    Page Should Contain Element         //*[div=' 140']

Not Start Activity with Customers
    ${token}    Login To Crm  hao.yao    1
    ${data}                            CreateData.activity_notstart   activity_type_theme   WealthManagementCenter_allcountry    activity_launchSystem_crm
    ${name}                            CreateData.getactname    ${data}
    ${data}                            To Json                  ${data}
    ${head}                            String To Dictionary     {"Content-Type":"application/json", "Authorization":"${token['object']['token']}"}
    ${resp}                            Put Request              crm    activity/addActivity    ${data}    ${head}
    ${cust1}                           CreateData.customer1
    ${cust2}                           CreateData.customer2
    ${resp}                            Put Request              crm    activity/addCustomers    ${cust1}   ${head}
    ${resp}                            Put Request              crm    activity/addCustomers    ${cust2}   ${head}
#    Search Activity by Browser                    hao.yao    1    Robot_Audit_Test
#    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
#    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
#    Click Element                       //*[@class='container_left']/div[8]/div/div/span[1]/i
#    Wait Until Page Contains Element    //*[@aria-label='Previous Month']
#    Click Element                       //*[@aria-label='Previous Month']
#    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
#    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
#    Click Element                       //*[@class='container_left']/div[9]/div/div/span[1]/i
#    Wait Until Page Contains Element    //*[@aria-label='Next Month']
#    Click Element                       //*[@aria-label='Next Month']
#    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
#    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
#    Click Element                       //*[@class='container_left']/div[10]/div/div/span[1]/i
#    Wait Until Page Contains Element    //*[@aria-label='Next Month']
#    Click Element                       //*[@aria-label='Next Month']
#    Wait Until Page Contains Element    //*[@aria-label='Next Month']
#    Click Element                       //*[@aria-label='Next Month']
#    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
#    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
#    Click Element                       //*[@class='container_left']/div[11]/div/div/span[1]/i
#    Wait Until Page Contains Element    //*[@aria-label='Next Month']
#    Click Element                       //*[@aria-label='Next Month']
#    Wait Until Page Contains Element    //*[@aria-label='Next Month']
#    Click Element                       //*[@aria-label='Next Month']
#    Wait Until Page Contains Element    //*[@aria-label='Next Month']
#    Click Element                       //*[@aria-label='Next Month']
#    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
#    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
#    Wait Until Page Contains Element    //*[span='取消']
#    Click Element                       //*[span='保存']
#    Close Browser

Started Activity with Customers
    ${token}    Login To Crm  hao.yao    1
    ${data}                            CreateData.activity_started    activity_type_theme   WealthManagementCenter_allcountry    activity_launchSystem_crm
    ${name}                            CreateData.getactname    ${data}
    ${data}                            To Json                  ${data}
    ${head}                            String To Dictionary     {"Content-Type":"application/json", "Authorization":"${token['object']['token']}"}
    ${resp}                            Put Request              crm    activity/addActivity    ${data}    ${head}
    ${cust1}                           CreateData.customer1
    ${resp}                            Put Request              crm    activity/addCustomers    ${cust1}   ${head}
#    Search Activity by Browser                    hao.yao    1    Robot_Audit_Test
#    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
#    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[8]/div/button[1]
#    Click Element                       //*[@class='container_left']/div[8]/div/div/span[1]/i
#    Wait Until Page Contains Element    //*[@aria-label='Previous Month']
#    Click Element                       //*[@aria-label='Previous Month']
#    Wait Until Page Contains Element    //*[@aria-label='Previous Month']
#    Click Element                       //*[@aria-label='Previous Month']
#    Wait Until Page Contains Element    //*[@aria-label='Previous Month']
#    Click Element                       //*[@aria-label='Previous Month']
#    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
#    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
#    Click Element                       //*[@class='container_left']/div[9]/div/div/span[1]/i
#    Wait Until Page Contains Element    //*[@aria-label='Previous Month']
#    Click Element                       //*[@aria-label='Previous Month']
#    Wait Until Page Contains Element    //*[@aria-label='Previous Month']
#    Click Element                       //*[@aria-label='Previous Month']
#    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
#    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
#    Click Element                       //*[@class='container_left']/div[10]/div/div/span[1]/i
#    Wait Until Page Contains Element    //*[@aria-label='Previous Month']
#    Click Element                       //*[@aria-label='Previous Month']
#    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
#    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
#    Click Element                       //*[@class='container_left']/div[11]/div/div/span[1]/i
#    Wait Until Page Contains Element    //*[@aria-label='Next Month']
#    Click Element                       //*[@aria-label='Next Month']
#    Click Element                       //*[@class='el-date-table']/tbody/tr[4]/td[4]/div/span
#    Click Element                       //*[@class='el-picker-panel__footer']/button[2]
#    Wait Until Page Contains Element    //*[span='取消']
#    Click Element                       //*[span='保存']
#    Close Browser


Go To Market Activity
    Wait Until Page Contains Element    //*[span='市场活动']
    Click Element                       //*[span='市场活动']

Search Reservation Info
    Wait Until Page Contains Element    //*[@placeholder='请输入市场活动关键字']
    Input Text                          //*[@placeholder='请输入市场活动关键字']    测试测试
    Click Element                       //*[span='查 询']

Go To My Customers
    Wait Until Page Contains Element    //*[span='我的客户']
    Click Element                       //*[span='我的客户']

Input My Customers Info
    [Arguments]    ${custname}
    Wait Until Page Contains Element    //*[@class='first_container']/div[1]/div/div/input
    Input Text                          //*[@class='first_container']/div[1]/div/div/input    ${custname}
    Click Element                       //*[span='查 询']
    Wait Until Page Contains Element    //*[span='${custname}']

Go To More Info
    [Arguments]    ${custname}
    Click Element                       //*[@class='el-table__row']
    Wait Until Page Contains Element    //*[span='更多资料']
    Click Element                       //*[span='更多资料']
    Wait Until Page Contains Element    //*[@class='top_container']

Asset Detail
    Wait Until Page Contains Element    //*[@id='pane-cust_realsharesType_continue']/div/div[1]/div[2]/button
    Click Element                       //*[@id='pane-cust_realsharesType_continue']/div/div[1]/div[2]/button
    Wait Until Page Contains Element    //*[@id='tab-certificate']
    Click Element                       //*[@id='tab-certificate']
    Page Should Contain Element         //*[@id='pane-certificate']
    Click Element                       //*[@id='tab-contract']
    Page Should Contain Element         //*[@id='pane-contract']
    Click Element                       //*[@class='main']/div[6]/div//div[3]/table/tbody/tr[1]/td[1]/div/div/i
    Page Should Contain Element         //*[@class='allocation_table_expand']
    Click Element                       //*[@class='main']/div[6]/div//div[3]/table/tbody/tr[1]/td[1]/div/div/i
    Page Should Not Contain Element     //*[@class='allocation_table_expand']
    Click Element                       //*[@class='main']/div[8]/div//div[3]/table/tbody/tr[1]/td[1]/div/div/i
    Page Should Contain Element         //*[@class='allocation_table_expand']
    Click Element                       //*[@class='main']/div[8]/div//div[3]/table/tbody/tr[1]/td[1]/div/div/i
    Page Should Not Contain Element     //*[@class='allocation_table_expand']

Add New Week Plan
    Sleep    2
    Click Element                       //*[@class='add_btn']/button
    Wait Until Page Contains Element    //*[span='保存']
    Input Text    //*[@class='el-dialog__body']/div[2]/form/div[1]/div/div/div/input    新农村建设发展基金集合信托计划
    Wait Until Page Contains Element    //*[contains(@id,'el-autocomplete')]
    Sleep    2
    @{ElementList}    Get WebElements    //*[contains(@id,'el-autocomplete')]
    ${ElementListLen}    Get Element Count    //*[contains(@id,'el-autocomplete')]
    Click Element    @{ElementList}[2]
    Input Text    //*[@class='el-dialog__body']/div[2]/form/div[2]/div/div/div/input    徐一华
    Wait Until Page Contains Element    //*[@class='el-scrollbar']/div/ul/li
    Wait Until Page Contains Element    //*[contains(@id,'el-autocomplete')]
    Sleep    2
    @{ElementList}    Get WebElements    //*[contains(@id,'el-autocomplete')]
    ${ElementListLen}    Get Element Count    //*[contains(@id,'el-autocomplete')]
    Click Element    @{ElementList}[2]
    Input Text    //*[@class='el-dialog__body']/div[2]/form/div[3]/div/div/input    100
    Click Element    //*[span='保存']

Add Exist Week Plan
    Add New Week Plan
    Wait Until Page Contains Element    //*[@role='alert']
    Page Should Contain Element         //*[@role='alert']
    Click Element    //*[span='取消']

Edit Week Plan
    Sleep    2
    @{ElementList}    Get WebElements    //*[@class='el-table__body']/tbody/tr[1]/td[4]/div/button[1]/span
    ${ElementListLen}    Get Element Count    //*[@class='el-table__body']/tbody/tr[1]/td[4]/div/button[1]/span
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr[1]/td[4]/div/button[1]/span
    Click Element    @{ElementList}[1]
    Wait Until Page Contains Element    //*[span='保存']
    Input Text    //*[@class='el-dialog__body']/div[2]/form/div[3]/div/div/input    200
    Click Element    //*[span='保存']
    Page Should Contain Element    //*[div='￥200']

Delete Week Plan
    Sleep    2
    @{ElementList}    Get WebElements    //*[@class='el-table__body']/tbody/tr[1]/td[4]/div/button[2]/span
    ${ElementListLen}    Get Element Count    //*[@class='el-table__body']/tbody/tr[1]/td[4]/div/button[2]/span
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr[1]/td[4]/div/button[2]/span
    Click Element    @{ElementList}[1]
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[2]/span
    Click Element    //*[@class='el-message-box__btns']/button[2]/span
    Sleep   2
    Page Should Not Contain Element    //*[div='￥200']

Add New Daily Work Plan
    Click Element                       //*[@class='add_btn']/button
    Wait Until Page Contains Element    //*[span='保存']
    Input Text    //*[@class='el-dialog__body']/div/form/div[1]/div/div/div/input    徐一华
    Sleep    2
    @{ElementList}    Get WebElements    //*[contains(@id,'el-autocomplete')]
    ${ElementListLen}    Get Element Count    //*[contains(@id,'el-autocomplete')]
    Click Element    @{ElementList}[2]
    Click Element                       //*[@class='el-dialog__body']/div/form/div[2]/div/div/div/input
    Wait Until Page Contains Element    //*[span='产品推介']
    Click Element                       //*[span='产品推介']
    Click Element                       //*[@class='el-dialog__body']/div/form/div[3]/div/div/div/input
    Wait Until Page Contains Element    //*[span='面谈']
    Click Element                       //*[span='面谈']
    Click Element                       //*[span='电话']
    Click Element                       //*[@class='el-dialog__body']/div/form/div[4]/div/div/div/input
    Wait Until Page Contains Element    //*[span='成功']
    Click Element                       //*[span='成功']
    Input Text    //*[@class='el-dialog__body']/div/form/div[5]/div/div/div/input    新农村建设发展基金集合信托计划
    Sleep    2
    @{ElementList}    Get WebElements    //*[contains(@id,'el-autocomplete')]
    ${ElementListLen}    Get Element Count    //*[contains(@id,'el-autocomplete')]
    Click Element    @{ElementList}[2]
    Click Element                       //*[@class='el-dialog__body']/div/form/div[6]/div/div/span/i
    Wait Until Page Contains Element    //*[@class='el-picker-panel__content']
    Click Element                       //*[@class='el-picker-panel__content']/table/tbody/tr[4]/td[5]
    Input Text                          //*[@class='el-dialog__body']/div/form/div[7]/div/div/input    100
    Input Text                          //*[@class='el-dialog__body']/div/form/div[10]/div/div/textarea    Robot Test
    Click Element                       //*[span='保存']

Edit Daily Work Plan
    Sleep    2
    @{ElementList}    Get WebElements    //*[@class='el-table__body']/tbody/tr[1]/td[9]/div/button[1]/span
    ${ElementListLen}    Get Element Count    //*[@class='el-table__body']/tbody/tr[1]/td[9]/div/button[1]/span
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr[1]/td[9]/div/button[1]/span
    Click Element    @{ElementList}[1]
    Wait Until Page Contains Element    //*[span='保存']
    Input Text    //*[@class='el-dialog__body']/div/form/div[7]/div/div/input    200
    Click Element    //*[span='保存']

Delete Daily Work Plan
    Sleep    2
    @{ElementList}    Get WebElements    //*[@class='el-table__body']/tbody/tr[1]/td[9]/div/button[2]/span
    ${ElementListLen}    Get Element Count    //*[@class='el-table__body']/tbody/tr[1]/td[9]/div/button[2]/span
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr[1]/td[9]/div/button[2]/span
    Click Element    @{ElementList}[1]
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[2]/span
    Click Element    //*[@class='el-message-box__btns']/button[2]/span











