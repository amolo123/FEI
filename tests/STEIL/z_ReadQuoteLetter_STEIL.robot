*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_InsuredInfo.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInit.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInfo.robot

Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_Compare&RateQuote.robot
Resource                        ../../resources/ReadPDF.robot
Resource                        ../../PageObjects/STEIL/PageObjects_PDFRead_STEIL.robot
Resource                        ../../PageObjects/PageObjects_PolicyPage.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_Compare&RateQuote.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***
Read Quote Letter Policy Document and Binder For STEIL
    #Author = Amol Gaymukhe
    #TC=69052
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

    Expand Subjectivities
    #Update Subjectivity
    Update All Subjectivities

    #Add New Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003    AST    111 - 550 Gallons        Fiberglass    Fiberglass Coated Steel

    #Qualify
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Enter Quote Option
    Click on Rate Quote
    Sleep                       5s
    Get Quote Letter Dynamic Document EIL
    Click on Finalize Quote
    Sleep                       15s
    RefreshPage
    Generate Primary or Excess Document                     Generate Primary
    Get WORD document and attach it to log
    Read Doc Quote Letter Static Document STEIL
    Read Doc Quote Letter Dynamic Document STEIL
    Click On Bind
    Sleep                       30s
    Get Policy No
    Generate Document on Policy                             Policy
    Sleep                       15s
    Click On Policy and Download
    Sleep                       20s
    Get WORD document and attach it to log
    Read Policy Letter Static Document STEIL
    Read Policy Letter Dynamic Document STEIL
    Back
    Generate Document on Policy                             Binder
    Sleep                       15s
    Click On Binder and Download
    Sleep                       20s
    Get WORD document and attach it to log
    Read Binder Letter Static Document STEIL
    Read Binder Letter Dynamic Document STEIL
    Logout