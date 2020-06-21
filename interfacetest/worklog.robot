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
#Go To Sales Week Plan
#    Go To Sales Week Plan
#    [Teardown]  Close Browser

#Go To Daily Work Plan
#    Go To Daily Work Plan
#    [Teardown]  Close Browser

#Search For Sales Week
#    Search For Sales Week

#Add New Week Plan
#    Add New Week Plan Whole Process

#Search For Daily Work Plan
#    Search For Daily Work Plan


#Add New Daily Work Plan Whole Process
#    Add New Daily Work Plan Whole Process

#Can Not See Others Week Plans
#    Can Not See Others Week Plans

#Can Not See Others Daily Work Plan
#    Can Not See Others Daily Work Plan

Daily Work Plan Required Fields
    Daily Work Plan Required Fields

*** Keywords ***
Go To Sales Week Plan
    Login by Browser                    richard.qian    1
    Wait Until Page Contains Element    //*[span='工作日志']
    Click Element                       //*[span='工作日志']
    Wait Until Page Contains Element    //*[span='销售周计划']
    Click Element                       //*[span='销售周计划']
    Wait Until Page Contains Element    //*[label='销售周期']

Go To Daily Work Plan
    Login by Browser                    richard.qian    1
    Wait Until Page Contains Element    //*[span='工作日志']
    Click Element                       //*[span='工作日志']
    Wait Until Page Contains Element    //*[span='工作日报']
    Click Element                       //*[span='工作日报']
    Wait Until Page Contains Element    //*[label='日期']

Search For Sales Week
    Go To Sales Week Plan
    Click Element                       //*[@placeholder='请选择']
    Sleep    2
    @{ElementList}    Get WebElements    //*[@class='el-scrollbar']/div/ul/li[1]/span
    ${ElementListLen}    Get Element Count    //*[@class='el-scrollbar']/div/ul/li[1]/span
    ${week}    Get Text                 @{ElementList}[2]
    Click Element                       @{ElementList}[2]
    ${rslt}    Get Text                 //*[@class='data-title']/div
    Should Contain    ${rslt}    ${week}
    [Teardown]  Close Browser

Add New Week Plan Whole Process
    Go To Sales Week Plan
    Add New Week Plan
    Add Exist Week Plan
    Edit Week Plan
    Delete Week Plan
    [Teardown]  Close Browser

Search For Daily Work Plan
    Go To Daily Work Plan
    Click Element                       //*[@class='form_container']/form/div[1]/div/div/input
    Wait Until Page Contains Element    //*[@class='el-picker-panel__content']
    ${date}    Get Text                 //*[@class='el-picker-panel__content']/table/tbody/tr[4]/td[5]
    Click Element                       //*[@class='el-picker-panel__content']/table/tbody/tr[4]/td[5]
    ${rslt}    Get Text                 //*[@class='data-title']/div
    Should Contain    ${rslt}    ${date}
    [Teardown]  Close Browser

Add New Daily Work Plan Whole Process
    Go To Daily Work Plan
    Add New Daily Work Plan
    Edit Daily Work Plan
    Delete Daily Work Plan
    [Teardown]  Close Browser

Can Not See Others Week Plans
    Go To Sales Week Plan
    Add New Week Plan
    Close Browser
    Login by Browser                    hao.yao    1
    Wait Until Page Contains Element    //*[span='工作日志']
    Click Element                       //*[span='工作日志']
    Wait Until Page Contains Element    //*[span='销售周计划']
    Click Element                       //*[span='销售周计划']
    Wait Until Page Contains Element    //*[label='销售周期']
    Sleep    2
    Page Should Not Contain Element     //*[div='徐一华']
    Close Browser
    Go To Sales Week Plan
    Delete Week Plan
    [Teardown]  Close Browser

Can Not See Others Daily Work Plan
    Go To Daily Work Plan
    Add New Daily Work Plan
    Close Browser
    Login by Browser                    hao.yao    1
    Wait Until Page Contains Element    //*[span='工作日志']
    Click Element                       //*[span='工作日志']
    Wait Until Page Contains Element    //*[span='工作日报']
    Click Element                       //*[span='工作日报']
    Wait Until Page Contains Element    //*[label='日期']
    Sleep    2
    Page Should Not Contain Element     //*[div='徐一华']
    Close Browser
    Go To Daily Work Plan
    Delete Daily Work Plan
    [Teardown]  Close Browser

Daily Work Plan Required Fields
    Go To Daily Work Plan
    Click Element                       //*[@class='add_btn']/button
    Wait Until Page Contains Element    //*[span='保存']
    Click Element                       //*[span='保存']
    Sleep  1
    @{ElementList}    Get WebElements    //*[@class='el-form-item__error']
    ${ElementListLen}    Get Element Count    //*[@class='el-form-item__error']
    Element Should Contain              @{ElementList}[0]    请输入客户名称
    Element Should Contain              @{ElementList}[1]    请选择沟通类型
    Element Should Contain              @{ElementList}[2]    请选择沟通方式
    Element Should Contain              @{ElementList}[3]    请选择沟通结果
    Element Should Contain              @{ElementList}[4]    请输入沟通内容
    Click Element                       //*[@class='el-dialog__body']/div/form/div[2]/div/div/div/input
    Wait Until Page Contains Element    //*[span='产品推介']
    Click Element                       //*[span='产品推介']
    Click Element                       //*[span='保存']
    Sleep  1
    @{ElementList}    Get WebElements    //*[@class='el-form-item__error']
    ${ElementListLen}    Get Element Count    //*[@class='el-form-item__error']
    Element Should Contain              @{ElementList}[0]    请输入客户名称
    Element Should Contain              @{ElementList}[1]    请选择沟通方式
    Element Should Contain              @{ElementList}[2]    请选择沟通结果
    Element Should Contain              @{ElementList}[3]    请选择产品名称
    Element Should Contain              @{ElementList}[4]    请输入沟通内容
    Click Element                       //*[@class='el-dialog__body']/div/form/div[4]/div/div/div/input
    Wait Until Page Contains Element    //*[span='成功']
    Click Element                       //*[span='成功']
    Click Element                       //*[span='保存']
    Sleep  1
    @{ElementList}    Get WebElements    //*[@class='el-form-item__error']
    ${ElementListLen}    Get Element Count    //*[@class='el-form-item__error']
    Element Should Contain              @{ElementList}[0]    请输入客户名称
    Element Should Contain              @{ElementList}[1]    请选择沟通方式
    Element Should Contain              @{ElementList}[2]    请选择产品名称
    Element Should Contain              @{ElementList}[3]    请选择预计签约时间
    Element Should Contain              @{ElementList}[4]    请输入金额
    Element Should Contain              @{ElementList}[5]    请输入沟通内容
    Click Element                       //*[@class='el-dialog__body']/div/form/div[4]/div/div/div/input
    Wait Until Page Contains Element    //*[span='失败']
    Click Element                       //*[span='失败']
    Click Element                       //*[span='保存']
    Sleep  1
    @{ElementList}    Get WebElements    //*[@class='el-form-item__error']
    ${ElementListLen}    Get Element Count    //*[@class='el-form-item__error']
    Element Should Contain              @{ElementList}[0]    请输入客户名称
    Element Should Contain              @{ElementList}[1]    请选择沟通方式
    Element Should Contain              @{ElementList}[2]    请选择产品名称
    Element Should Contain              @{ElementList}[3]    请输入沟通内容
    Element Should Contain              @{ElementList}[4]    请输入失败原因
    [Teardown]  Close Browser