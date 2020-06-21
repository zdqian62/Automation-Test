*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library

*** Variables ***
${SERVER}         crm.anxintrust.net/sit/#/login
${BROWSER}        Chrome
${DELAY}          0.3
${VALID USER}     hao.yao
${VALID PASSWORD}    1
${LOGIN URL}      http://${SERVER}/
${WELCOME URL}    https://crm.anxintrust.net/sit/#/index/index
${ERROR URL}      http://${SERVER}/error.html
${ACTNAME}        autotest_activity_20180626


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}


Go To Login Page
    Go To    ${LOGIN URL}

Input Username
    [Arguments]    ${username}
    Input Text    //*[@name='username']    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    //*[@name='password']    ${password}

Submit Credentials
    Click Button    //*[@class='el-form-item__content']/button

Add New Activity
    Wait Until Page Contains Element    //*[@class='menu-wrapper']/li[1]/div/span
    Click Element                       //*[@class='menu-wrapper']/li[1]/div/span
    Wait Until Page Contains Element    //*[@class='menu-wrapper']/li[1]/ul/a[2]/li/span
    Click Element                       //*[@class='menu-wrapper']/li[1]/ul/a[2]/li/span
    Wait Until Page Contains Element    //*[@class='icon_container']
    Click Element                       //*[@class='icon_container']
    Input Text                          //*[@class='container_left']/div[1]/div/div/input       ${ACTNAME}
    Click Element                       //*[@class='container_left']/div[4]/div/div/div/input
    Wait Until Element Is Visible       //*[@class='el-select-dropdown__item'][span='公益活动']
    Click Element                       //*[@class='el-select-dropdown__item'][span='公益活动']
    Input Text                          //*[@class='container_left']/div[5]/div/div/textarea    Shanghai
    Click Element                       //*[@class='container_left']/div[7]/div/div/div/input
    Click Element                       //*[@class='el-select-dropdown__item'][span='全国']
    Click Element                       //*[@class='container_right']/div[3]/div/div/div/input
    Click Element                       //*[@class='el-select-dropdown__item'][span='事实客户']
    Click Element                       //*[@class='activity_dialog']/div/button[span='保存']



