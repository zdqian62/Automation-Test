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
Broker Has KPI
    Broker Has KPI

*** Keywords ***
Broker Has KPI
    Login by Browser                    richard.qian    1
    Wait Until Page Contains Element    //*[span='KPI进度']
    [Teardown]    Close Browser

