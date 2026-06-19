*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_InsuredInfo.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_SubmissionInit.robot
Resource                        ../../PageObjects/Freberg_Common.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***
Verify the field on Submission Init Form for PPL
    # Author = Vighanesh Surve
    #TC= 94431, 94430
    [Documentation]             field on Submission INIT for PPL
    [Tags]                      Smoke_Test_PPL    Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for PPL
    Validate Submission Init on Submission info page for PPL
    Verify Date
    Select broker Contact Source
    Sleep                       10s
    VerifyText                  Submission Name
    Logout