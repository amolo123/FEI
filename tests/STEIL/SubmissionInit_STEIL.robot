*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInit.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_InsuredInfo.robot
Resource                        ../../PageObjects/Freberg_Common.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***
Verify the field on Submission Init Form for STEIL
    # Author = Vighanesh Surve
    #TC=94431,94430
    [Documentation]             field on Submission INIT for STEIL
    [Tags]                      Smoke_Test_STEIL            Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Validate Submission Init on Submission info page for STEIL
    Verify Date
    Select broker Contact Source
    Sleep                       10s
    VerifyText                  Submission Name
    Logout

Verify the field on Submission Init Form and press cancel
    # Author = Vighanesh Surve
    #TC=94431
    [Documentation]             field on Submission_init for ECC
    [Tags]                      Smoke_Test_STEIL            Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for STEIL
    Validate Submission Init on Submission info page for STEIL
    Verify Date
    Select broker Contact Source
    ClickText                   Cancel
    Logout

    # Verify the field on Submission Init Form and press Next
    #                           # Author = Vighanesh Surve
    #                           #TC=94430
    #                           [Documentation]             field on Submission_init for ECC
    #                           [Tags]                      Submission_init_ECC-Cancel

    #                           Creating a new Account
    #                           Enter data on Insured info Page for STEIL
    #                           Validate Submission Init on Submission info page for STEIL
    #                           Verify Date
    #                           Select broker Contact Source
    #                           ClickText                   Next                        anchor=Cancel
    #                           VerifyText                  Submission Name