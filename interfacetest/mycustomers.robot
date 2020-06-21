*** Settings ***
Documentation    Suite description
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
#Search My Customers
#    Search My Customers    郭军红
#    [Teardown]  Close Browser

#More Info for My Customers
#    More Info for My Customers    郭军红

#My Customers Reservations
#    My Customers Reservations    郭军红

#My Customers Market Activity
#    My Customers Market Activity    郭军红

#My Customers Assets
#    My Customers Assets    郭军红
#    [Teardown]  Close Browser

#My Customers Detail Assets
#    My Customers Detail Assets    郭军红

Different Type Customes Have Different ID
    Different Type Customes Have Different ID

*** Keywords ***
Search My Customers
    [Arguments]    ${custname}
    Login by Browser                    hao.yao    1
    Go To My Customers
    Input My Customers Info    ${custname}
    Page Should Contain Element    //*[span='${custname}']
    ${num}    Get Text    //*[@class='pagination_container']/div/span
    Should Be Equal    ${num}    Total 1

More Info for My Customers
    [Arguments]    ${custname}
    Search My Customers    ${custname}
    Go To More Info    ${custname}
    Sleep    1
    Page Should Contain Element    //*[span='${custname}']
    Page Should Contain Element    //*[div='基本资料']
    [Teardown]  Close Browser

My Customers Reservations
    [Arguments]    ${custname}
    Search My Customers    ${custname}
    Click Element                       //*[@class='el-table__row']
    Wait Until Page Contains Element    //*[@id='tab-cust_reservationStatus_processing']
    Click Element                       //*[@id='tab-cust_reservationStatus_processing']
    Sleep    1
    Page Should Not Contain Element     //*[@class='reservation_container']
    Click Element                       //*[@id='tab-cust_reservationStatus_completed']
    Sleep    1
    Page Should Contain Element         //*[@class='reservation_container']
    Click Element                       //*[@id='tab-cust_reservationStatus_canceled']
    Sleep    1
    Page Should Not Contain Element     //*[@class='reservation_container']
    [Teardown]  Close Browser

My Customers Market Activity
    [Arguments]    ${custname}
    Search My Customers    ${custname}
    Click Element                       //*[@class='el-table__row']
    Wait Until Page Contains Element    //*[@id='tab-notBeginning']
    Click Element                       //*[@id='tab-notBeginning']
    Sleep    1
    Page Should Not Contain Element     //*[@class='activity_container']
    Click Element                       //*[@id='tab-haveInHand']
    Sleep    1
    Page Should Not Contain Element     //*[@class='activity_container']
    [Teardown]  Close Browser

My Customers Assets
    [Arguments]    ${custname}
    Search My Customers    ${custname}
    Click Element                       //*[@class='el-table__row']
    Wait Until Page Contains Element    //*[@id='tab-cust_realsharesType_continue']
    Click Element                       //*[@id='tab-cust_realsharesType_continue']
    Sleep    1
    Page Should Contain Element         //*[@class='asset_container']
    Click Element                       //*[@id='tab-cust_realsharesType_expired']
    Sleep    1
    Page Should Contain Element         //*[@class='asset_container']

My Customers Detail Assets
    [Arguments]    ${custname}
    Search My Customers    ${custname}
    Click Element                       //*[@class='el-table__row']
    Asset Detail
    [Teardown]  Close Browser

Different Type Customes Have Different ID
    Login by Browser                    hao.yao    1
    Go To My Customers
    Wait Until Page Contains Element    //*[@class='first_container']/div[3]/div/div/div/input
    Click Element                       //*[@class='first_container']/div[3]/div/div/div/input
    Wait Until Page Contains Element    //*[span='机构客户']
    Click Element                       //*[span='机构客户']
    Wait Until Page Contains Element    //*[@class='second_container']/div[1]/div[1]/div/div/div/input
    Click Element                       //*[@class='second_container']/div[1]/div[1]/div/div/div/input
    Wait Until Page Contains Element    //*[span='技术监督局代码']
    Page Should Contain Element         //*[span='营业执照']
    Page Should Contain Element         //*[span='行政机关']
    Page Should Contain Element         //*[span='社会团体']
    Page Should Contain Element         //*[span='军队']
    Wait Until Page Contains Element    //*[@class='first_container']/div[3]/div/div/div/input
    Click Element                       //*[@class='first_container']/div[3]/div/div/div/input
    Wait Until Page Contains Element    //*[span='个人客户']
    Click Element                       //*[span='个人客户']
    Wait Until Page Contains Element    //*[@class='second_container']/div[1]/div[1]/div/div/div/input
    Click Element                       //*[@class='second_container']/div[1]/div[1]/div/div/div/input
    Wait Until Page Contains Element    //*[span='身份证']
    Page Should Contain Element         //*[span='社保卡']
    Page Should Contain Element         //*[span='居住证']
    Page Should Contain Element         //*[span='中国护照']
    Page Should Contain Element         //*[span='军官证']
    [Teardown]  Close Browser
