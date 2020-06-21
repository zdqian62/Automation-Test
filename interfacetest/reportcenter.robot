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
#Go To Report Center
#    Go To Report Center
#    [Teardown]  Close Browser

#Reservation Info abulate Statistics
#    Reservation Info abulate Statistics

#Contract End Report
#    Contract End Report

#Buy Again Report
#    Buy Again Report

#Customer Manager KPI Manage Report
#    Customer Manager KPI Manage Report

#Customer Manager Customer Distribute Analysis Manage Report
#    Customer Manager Customer Distribute Analysis Manage Report

#Customer Retained Analysis Manage Report
#    Customer Retained Analysis Manage Report

#Customer Manager KPI Report
#    Customer Manager KPI Report

#Customer Manager Customer Distribute Analysis Report
#    Customer Manager Customer Distribute Analysis Report

#Customer Retained Analysis Report
#    Customer Retained Analysis Report

#Deputesale Analysis Report
#    Deputesale Analysis Report

#Brokers Only Have Analysis Report
#    Brokers Only Have Analysis Report

Managers Have Analysis Report And Basic Report
    Managers Have Analysis Report And Basic Report

*** Keywords ***
Go To Report Center
    Login by Browser                    hao.yao    1
    Wait Until Page Contains Element    //*[span='报表中心']
    Click Element                       //*[span='报表中心']
    Wait Until Page Contains Element    //*[div='基础报表']

Reservation Info abulate Statistics
    Go To Report Center
    Click Element                       //*[div='预约信息汇总统计']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='预约信息汇总统计']
    [Teardown]  Close Browser

Contract End Report
    Go To Report Center
    Click Element                       //*[div='预计合同到期']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='预计合同到期']
    [Teardown]  Close Browser

Buy Again Report
    Go To Report Center
    Click Element                       //*[div='到期再购买信息']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='到期再购买信息']
    [Teardown]  Close Browser

Customer Manager KPI Manage Report
    Go To Report Center
    Click Element                       //*[div='客户经理KPI汇总表-管理报表']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='客户经理KPI汇总表-管理报表']
    [Teardown]  Close Browser

Customer Manager Customer Distribute Analysis Manage Report
    Go To Report Center
    Click Element                       //*[div='客户经理客户分布分析-管理报表']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='客户经理客户分布分析-管理报表']
    [Teardown]  Close Browser

Customer Retained Analysis Manage Report
    Go To Report Center
    Click Element                       //*[div='客户留存分析-管理报表']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='客户留存分析-管理报表']
    [Teardown]  Close Browser

Customer Manager KPI Report
    Go To Report Center
    Click Element                       //*[div='客户经理KPI汇总表']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='客户经理KPI汇总表']
    [Teardown]  Close Browser

Customer Manager Customer Distribute Analysis Report
    Go To Report Center
    Click Element                       //*[div='客户经理客户分布分析']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='客户经理客户分布分析']
    [Teardown]  Close Browser

Customer Retained Analysis Report
    Go To Report Center
    Click Element                       //*[div='客户留存分析']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='客户留存分析']
    [Teardown]  Close Browser

Deputesale Analysis Report
    Go To Report Center
    Click Element                       //*[div='代销统计报表']
    Sleep  1
    Wait Until Page Contains Element    //*[@class='el-breadcrumb__inner'][span='代销统计报表']
    [Teardown]  Close Browser

Brokers Only Have Analysis Report
    Login by Browser                    richard.qian    1
    Wait Until Page Contains Element    //*[span='报表中心']
    Click Element                       //*[span='报表中心']
    Wait Until Page Contains Element    //*[div='分析报表']
    Page Should Not Contain Element     //*[div='基础报表']
    [Teardown]  Close Browser

Managers Have Analysis Report And Basic Report
    Login by Browser                    hao.yao    1
    Wait Until Page Contains Element    //*[span='报表中心']
    Click Element                       //*[span='报表中心']
    Wait Until Page Contains Element    //*[div='分析报表']
    Page Should Contain Element     //*[div='基础报表']
    [Teardown]  Close Browser


