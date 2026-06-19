*** Settings ***
Resource                        ../resources/common.robot
Resource                        ../PageObjects/PageObjects_Account.robot
Resource                        ../PageObjects/PageObjects_HomePage.robot
Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***


Validate Home Page 
    # Author = Amol
    #TC=
    [Documentation]             Verify All HomePage Elemets
    [Tags]                      Smoke_Test
    Verify All HomePage Elemets