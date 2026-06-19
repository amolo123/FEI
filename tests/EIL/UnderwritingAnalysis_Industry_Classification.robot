*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot

Resource                        ../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot
Resource                        ../../resources/Upload_CSV_file.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify the Industry_Classification on Underwriter Ananysis for EIL 
    # Author = Vighanesh Surve
    #TC=97983
    [Documentation]             Industry_Classification on Underwriter Ananysis for EIL
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Log                        skip for now              
    # Creating a new Account
    # Enter data on Insured info Page for EIL
    # Select broker Contact Source
    # Sleep                       10s
    # Change Underwriter and CSR
    # ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    # Sleep                       10s
    # VerifyText                  EIL Retro Date
    # ClickText                   Submission Info
    # sleep                       5s
    # ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    # Check Industry Classifications                          Utilities
    # Check Industry Classifications                          Other
    # Check Industry Classifications                          Agriculture
    # Check Industry Classifications                          Transportation
    # Check Industry Classifications                          Information
    # Check Industry Classifications                          Finance
    # Check Industry Classifications                          Real
    # Check Industry Classifications                          Professional
    # Check Industry Classifications                          Healthcare
    # Check Industry Classifications                          Arts
    # Check Industry Classifications                          Accommodation
    # Check Industry Classifications                          Public
    # Check Industry Classifications                          Wholesale
    # Check Industry Classifications                          Retail

Verify the Industry_Classification on Underwriter Ananysis for EIL for Manufacturing
    # Author = Vighanesh Surve
    #TC=97983
    [Documentation]             Industry_Classification on Underwriter Ananysis for EIL for Manufacturing
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Log                        skip for now 
    # Creating a new Account
    # Enter data on Insured info Page for EIL
    # Validate Submission Init on Submission info page for EIL
    # Select broker Contact Source
    # Sleep                       10s
    # Change Underwriter and CSR
    # VerifyText                  Submission Name
    # ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    # Sleep                       10s
    # VerifyText                  EIL Retro Date
    # ClickText                   Submission Info
    # sleep                       5s
    # ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    # Check Industry Classifications                          Manufacturing
