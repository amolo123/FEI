*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_InsuredInfo.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInit.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInfo.robot

Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_Compare&RateQuote.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify able to validate Endorsements For STEIL
    #Author = Amol Gaymukhe
    #TC=
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Smoke_Test_STEIL            Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Select Application Type
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >

    VerifyText                  Retroactive Date            timeout=10s
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >
    Validated New Tank Picklist for AST                     Tank Test One               Location 1     2003                     AST           111 - 550 Gallons          Fiberglass    Fiberglass Coated Steel
    Validated New Tank Picklist for UST                     Tank Test One               Location 1     2004                     UST           4001 - 15,000 Gallons      STI-P3    Cathode Protected Steel

    Add Retroacive Date
    Select NAICS Code

    # #Add New Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003    AST    111 - 550 Gallons        Fiberglass    Fiberglass Coated Steel

    # #Qualify
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Click On Endorsement

    Verify Default Endorsements for STEIL                   STEIL_VA
    Verify already added Endorsements for STEIL

    Add Endorsement             UST-003-0712                Additional Insured
    Add Endorsement             UST-006-0712                Additional Scheduled Location(s)
    Add Endorsement             UST-007-0513                Additional Scheduled Storage Tanks
    Logout
