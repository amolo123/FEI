*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_InsuredInfo.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInit.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInfo.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify the field on Submission Info for STEIL 
    # Author = Vighanesh Surve
    #TC=
    [Documentation]             field on Submission_Info for STEIL
    [Tags]                      Smoke_Test_STEIL            Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Validate Submission Info Elements for STEIL
    Validate NEXT Underwriter Analysis Info Elements for STEIL
    Logout

    # Verify Save button on Submission Info
    #                           # Author = Vighanesh Surve
    #                           #TC=
    #                           [Documentation]             Save Button on Submission_Info for STEIL
    #                           [Tags]                      Submission_Info_STEIL
    #                           Creating a new Account
    #                           Enter data on Insured info Page for STEIL
    #                           Validate Submission Init on Submission info page for STEIL
    #                           Select broker Contact Source
    #                           ClickText                   Next                        anchor=Cancel
    #                           VerifyText                  Submission Name
    #                           Validate Save Info Elements for STEIL

    # Verify NEXT Underwriter Analysis button on Submission Info
    #                           # Author = Vighanesh Surve
    #                           #TC=
    #                           [Documentation]             Save Button on Submission_Info for STEIL
    #                           [Tags]                      Submission_Info_STEIL
    #                           Creating a new Account
    #                           Enter data on Insured info Page for STEIL
    #                           Validate Submission Init on Submission info page for STEIL
    #                           Select broker Contact Source
    #                           ClickText                   Next                        anchor=Cancel
    #                           VerifyText                  Submission Name
    #                           Validate NEXT Underwriter Analysis Info Elements for STEIL
    #                           VerifyText                  Retroactive Date            timeout=10s
    #                           LogScreenshot

Verify Decline and Reopen button on Submission Info
    # Author = Vighanesh Surve
    #TC=
    [Documentation]             Save Button on Submission_Info for STEIL
    [Tags]                      Smoke_Test_STEIL            Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Validate Save Info Elements for STEIL
    Verify Decline and Reopen
    Verify Close and Reopen
    Logout

    # Verify Close and Reopen button on Submission Info
    #                           # Author = Vighanesh Surve
    #                           #TC=
    #                           [Documentation]             Save Button on Submission_Info for STEIL
    #                           [Tags]                      Submission_Info_STEIL
    #                           Creating a new Account
    #                           Enter data on Insured info Page for STEIL
    #                           Validate Submission Init on Submission info page for STEIL
    #                           Select broker Contact Source
    #                           ClickText                   Next                        anchor=Cancel
    #                           VerifyText                  Submission Name
    #                           Validate Save Info Elements for STEIL
    #                           Verify Close and Reopen
