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
Library           OperatingSystem
Resource          resource.robot

*** Test Cases ***
#Go To Deputesale Manage
#    Go To Deputesale Manage
#    [Teardown]  Close Browser

#Download Template
#    Download Template

#Upload File And Delete
#    Upload File And Delete

Everyone Can See The Files
    Everyone Can See The Files

*** Keywords ***
Go To Deputesale Manage
    Login by Browser                    hao.yao    1
    Wait Until Page Contains Element    //*[span='代销管理']
    Click Element                       //*[span='代销管理']
    Wait Until Page Contains Element    //*[span='客户筛查']
    Click Element                       //*[span='客户筛查']
    Wait Until Page Contains Element    //*[a='代销管理']

Download Template
    Go To Deputesale Manage
    Wait Until Page Contains Element    //*[span='下载模版']
    Click Element                       //*[span='下载模版']
    Sleep  3
    File Should Exist                   /Users/zhengdongqian/Downloads/客户筛查模版.xls
    Remove File                         /Users/zhengdongqian/Downloads/客户筛查模版.xls
    [Teardown]  Close Browser

Upload File And Delete
    Go To Deputesale Manage
    Wait Until Page Contains Element    //*[span='下载模版']
    Click Element                       //*[span='下载模版']
    Sleep  3
    File Should Exist                   /Users/zhengdongqian/Downloads/客户筛查模版.xls
    Choose File                         //*[@type='file']    /Users/zhengdongqian/Downloads/客户筛查模版.xls
    Remove File                         /Users/zhengdongqian/Downloads/客户筛查模版.xls
    Wait Until Page Contains Element    //*[span='刷新']
    Click Element                       //*[span='刷新']
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr[1]/td[3]/div/div/button[2]/span
    Click Element                       //*[@class='el-table__body']/tbody/tr[1]/td[3]/div/div/button[2]/span
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[2]/span
    Click Element                       //*[@class='el-message-box__btns']/button[2]/span
    [Teardown]  Close Browser

Everyone Can See The Files
    Go To Deputesale Manage
    Wait Until Page Contains Element    //*[span='下载模版']
    Click Element                       //*[span='下载模版']
    Sleep  3
    File Should Exist                   /Users/zhengdongqian/Downloads/客户筛查模版.xls
    Choose File                         //*[@type='file']    /Users/zhengdongqian/Downloads/客户筛查模版.xls
    Remove File                         /Users/zhengdongqian/Downloads/客户筛查模版.xls
    Wait Until Page Contains Element    //*[span='刷新']
    Click Element                       //*[span='刷新']
    ${code}      Get Text               //*[@class='el-table__body']/tbody/tr[1]/td[1]/div
    Close Browser
    Login by Browser                    richard.qian    1
    Wait Until Page Contains Element    //*[span='代销管理']
    Click Element                       //*[span='代销管理']
    Wait Until Page Contains Element    //*[span='客户筛查']
    Click Element                       //*[span='客户筛查']
    Wait Until Page Contains Element    //*[a='代销管理']
    Page Should Contain Element         //*[div='${code}']
    Wait Until Page Contains Element    //*[@class='el-table__body']/tbody/tr[1]/td[3]/div/div/button[2]/span
    Click Element                       //*[@class='el-table__body']/tbody/tr[1]/td[3]/div/div/button[2]/span
    Wait Until Page Contains Element    //*[@class='el-message-box__btns']/button[2]/span
    Click Element                       //*[@class='el-message-box__btns']/button[2]/span
    [Teardown]  Close Browser

