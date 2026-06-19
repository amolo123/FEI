*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_InsuredInfo.robot
Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***

Verify Save Button and Next Submission Info Functionality on Insured Info Page - PPL
    # Author = Vighanesh Surve
    #TC=94427
    [Documentation]             Feild on Insured Info for PPL
    [Tags]                      Smoke_Test_PPL    Smoke_Test

    Creating a new Account
    Validate field on Insured Info page for PPL
    Logout