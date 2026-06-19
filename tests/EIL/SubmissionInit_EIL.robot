*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource                        ../../PageObjects/Freberg_Common.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***
Verify the field on Submission Init Form and Cancel for EIL
    # Author = Vighanesh Surve
    #TC=94431,94430
    [Documentation]             field on Submission INIT for EIL
    [Tags]                      Smoke_Test_EIL              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for EIL
    Validate Submission Init on Submission info page for EIL
    Verify Date
    Select broker Contact Source
    Sleep                       10s
    VerifyText                  Submission Name
    Logout