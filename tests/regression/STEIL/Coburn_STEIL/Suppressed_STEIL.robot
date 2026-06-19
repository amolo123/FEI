*** Settings ***
Resource                        ../../../../resources/common.robot
Resource                        ../../../../PageObjects/PageObjects_Account.robot
Resource                        ../../../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../../../PageObjects/STEIL/PageObjects_STEIL_InsuredInfo.robot
Resource                        ../../../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInit.robot
Resource                        ../../../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInfo.robot

Resource                        ../../../../PageObjects/STEIL/PageObjects_STEIL_UnderwritingAnalysis.robot
Resource                        ../../../../PageObjects/STEIL/PageObjects_STEIL_Compare&RateQuote.robot
Resource                        ../../../../PageObjects/PageObjects_PolicyPage.robot
Resource                        ../../../../PageObjects/ECC/Coburn/BillingRecord_Page.robot
Resource                        ../../../../resources/ReadPDF.robot
Resource                        ../../../../PageObjects/PageObject_Compare&Rate_Common.robot



Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***
STEIL Validate Billing Record for Suppressed billing 
    #Author = Akshay
    #TC=117087
    [Documentation]             STEIL Validate Billing Record for Suppressed billing
    [Tags]                      STEIL_Coburn                FEI_Coburn
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact with no billing Agency
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
    Log To Console              ----On Compare and rate quote-----

    Enter Quote Option
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Sleep                       10s
    Log To Console              -----On Policy Page-----
    Get Details for Billing Record document validation
    Open Billing Record         New Business
    Download Suppressed Invoice                             Sup_Reason=Missing Billing Agency details