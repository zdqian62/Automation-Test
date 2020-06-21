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
#Go To Sales Manager
#    Go To Sales Manager
#    [Teardown]  Close Browser

#Search For Sales Project In Manager
#    Search For Sales Project In Manager
#    [Teardown]  Close Browser

#Sales Project On List
#    Sales Project On List

#Sales Project Off List
#    Sales Project Off List

#Sales Project Off List And Hot
#    Sales Project Off List And Hot

#Sales Project Off List And Not Hot
#    Sales Project Off List And Not Hot

#Sales Project On List And Not Hot
#    Sales Project On List And Not Hot

#Sales Project On List And Hot
#    Sales Project On List And Hot

#Go To Sales Product
#    Go To Sales Product
#    [Teardown]  Close Browser

#Search For Sales Project In Product
#    Search For Sales Project In Product
#    [Teardown]  Close Browser

#Two Ways To Share
#    Two Ways To Share

#Get Detail Info In Product
#    Get Detail Info In Product

Get Detail Info In Manager
    Get Detail Info In Manager

#Search Backend By Conditions
#    Search Backend By Conditions

*** Keywords ***
Go To Sales Manager
    Login by Browser                    hao.yao    1
    Wait Until Page Contains Element    //*[span='后台管理']
    Click Element                       //*[span='后台管理']
    Wait Until Page Contains Element    //*[span='营销管理']
    Click Element                       //*[span='营销管理']
    Wait Until Page Contains Element    //*[label='项目名称：']

Search For Sales Project In Manager
    Go To Sales Manager
    Input Text                          //*[@placeholder='请输入内容']    富文本测试
    Sleep  2
    Click Element                       //*[span='查 询']
    Sleep  2
    ${name}    Get Text                 //*[@class='el-table__body']/tbody/tr[1]/td[2]/div
    Should Be Equal    ${name}          富文本测试

Sales Project On List
    Search For Sales Project In Manager
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Run Keyword If    '${status}'=='上架'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Sleep   2
    Run Keyword If    '${status}'=='上架'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    Click Element                       //*[span='营销产品']
    Sleep  2
    Wait Until Page Contains Element    //*[span='查 询']
    Input Text                          //*[@placeholder='请输入内容']    富文本测试
    Wait Until Page Contains Element    //*[span='查 询']
    Sleep   2
    Click Element                       //*[span='查 询']
    Wait Until Page Contains Element    //*[@class='project-info'][span='富文本测试']
    [Teardown]  Close Browser

Sales Project Off List
    Search For Sales Project In Manager
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Run Keyword If    '${status}'=='取消上架'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Sleep   2
    Run Keyword If    '${status}'=='取消上架'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    Click Element                       //*[span='营销产品']
    Sleep  2
    Wait Until Page Contains Element    //*[span='查 询']
    Input Text                          //*[@placeholder='请输入内容']    富文本测试
    Wait Until Page Contains Element    //*[span='查 询']
    Sleep   2
    Click Element                       //*[span='查 询']
    Sleep   2
    Page Should Not Contain Element     //*[@class='project-info'][span='富文本测试']
    [Teardown]  Close Browser

Sales Project On List And Hot
    Search For Sales Project In Manager
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[2]/span
    Run Keyword If    '${status}'=='热销'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[2]/span
    Sleep   2
    Run Keyword If    '${status}'=='热销'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Run Keyword If    '${status}'=='上架'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Sleep   2
    Run Keyword If    '${status}'=='上架'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    Click Element                       //*[span='首页']
    Wait Until Page Contains Element    //*[span='富文本测试']
    [Teardown]  Close Browser

Sales Project Off List And Hot
    Search For Sales Project In Manager
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[2]/span
    Run Keyword If    '${status}'=='热销'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[2]/span
    Sleep   2
    Run Keyword If    '${status}'=='热销'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Run Keyword If    '${status}'=='取消上架'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Sleep   2
    Run Keyword If    '${status}'=='取消上架'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    Click Element                       //*[span='首页']
    Sleep   2
    Page Should Not Contain Element     //*[span='富文本测试']
    [Teardown]  Close Browser

Sales Project Off List And Not Hot
    Search For Sales Project In Manager
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[2]/span
    Run Keyword If    '${status}'=='取消热销'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[2]/span
    Sleep   2
    Run Keyword If    '${status}'=='取消热销'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Run Keyword If    '${status}'=='取消上架'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Sleep   2
    Run Keyword If    '${status}'=='取消上架'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    Click Element                       //*[span='首页']
    Sleep   2
    Page Should Not Contain Element     //*[span='富文本测试']
    [Teardown]  Close Browser

Sales Project On List And Not Hot
    Search For Sales Project In Manager
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[2]/span
    Run Keyword If    '${status}'=='取消热销'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[2]/span
    Sleep   2
    Run Keyword If    '${status}'=='取消热销'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    ${status}    Get Text               //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Run Keyword If    '${status}'=='上架'     Click Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[1]/span
    Sleep   2
    Run Keyword If    '${status}'=='上架'     Click Element    //*[@class='el-message-box']/div[3]/button[2]
    Click Element                       //*[span='首页']
    Sleep   2
    Page Should Not Contain Element     //*[span='富文本测试']
    [Teardown]  Close Browser

Go To Sales Product
    Login by Browser                    hao.yao    1
    Wait Until Page Contains Element    //*[span='营销产品']
    Click Element                       //*[span='营销产品']
    Wait Until Page Contains Element    //*[span='查 询']

Search For Sales Project In Product
    Go To Sales Product
    Input Text                          //*[@placeholder='请输入内容']    富文本测试
    Sleep  2
    Click Element                       //*[span='查 询']
    Wait Until Page Contains Element    //*[@class='project-info'][span='富文本测试']

Two Ways To Share
    Search For Sales Project In Product
    Wait Until Page Contains Element    //*[span='一键分享']
    Click Element                       //*[span='一键分享']
    Wait Until Page Contains Element    //*[@title='本文二维码，手机扫一扫，精彩随身带!']
    Close Browser
    Search For Sales Project In Product
    Wait Until Page Contains Element    //*[span='分享']
    Click Element                       //*[span='分享']
    Wait Until Page Contains Element    //*[@title='本文二维码，手机扫一扫，精彩随身带!']
    [Teardown]  Close Browser

Get Detail Info In Product
    Search For Sales Project In Product
    Click Element                       //*[@class='detail-btn-div']/button/span
    Wait Until Page Contains Element    //*[span='一、信托计划要素']
    [Teardown]  Close Browser

Get Detail Info In Manager
    Search For Sales Project In Manager
    Wait Until Page Contains Element    //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[4]/span
    Click Element                       //*[@class='el-table__fixed-right']/div[2]/table/tbody/tr[1]/td[10]/div/button[4]/span
    Wait Until Page Contains Element    //*[span='信托计划要素']
    [Teardown]  Close Browser

Search Backend By Conditions
    Go To Sales Manager
    Wait Until Page Contains Element    //*[@class='sales_manager']/div[1]/div[1]/form/div[1]/div[5]/div/div/div/input
    Click Element                       //*[@class='sales_manager']/div[1]/div[1]/form/div[1]/div[5]/div/div/div/input
    Wait Until Page Contains Element    //*[span='是']
    @{ElementList}    Get WebElements    //*[span='是']
    ${ElementListLen}    Get Element Count    //*[span='是']
    Click Element    @{ElementList}[2]
    Wait Until Page Contains Element    //*[span='查 询']
    Click Element                       //*[span='查 询']
    Page Should Not Contain Element     //*[span='上架']

    Wait Until Page Contains Element    //*[@class='sales_manager']/div[1]/div[1]/form/div[1]/div[6]/div/div/div/input
    Click Element                       //*[@class='sales_manager']/div[1]/div[1]/form/div[1]/div[6]/div/div/div/input
    Wait Until Page Contains Element    //*[span='是']
    @{ElementList}    Get WebElements    //*[span='是']
    ${ElementListLen}    Get Element Count    //*[span='是']
    Click Element    @{ElementList}[2]
    Wait Until Page Contains Element    //*[span='查 询']
    Click Element                       //*[span='查 询']
    Page Should Not Contain Element     //*[span='热销']

    Wait Until Page Contains Element    //*[@class='sales_manager']/div[1]/div[1]/form/div[1]/div[7]/div/div/div/input
    Click Element                       //*[@class='sales_manager']/div[1]/div[1]/form/div[1]/div[7]/div/div/div/input
    Wait Until Page Contains Element    //*[span='是']
    @{ElementList}    Get WebElements    //*[span='是']
    ${ElementListLen}    Get Element Count    //*[span='是']
    Click Element    @{ElementList}[2]
    Wait Until Page Contains Element    //*[span='查 询']
    Click Element                       //*[span='查 询']
    Page Should Not Contain Element     //*[span='官网显示']
    [Teardown]  Close Browser








