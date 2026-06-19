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
STEIL Validate Billing Record Tab
    #Author = Rugveda
    #TC=117066,117069,117084
    [Documentation]             STEIL Validate Billing Record for New Business (NB) , Non Premium bearing Endosement and Premium bearing Endosement
    [Tags]                      STEIL_Coburn                FEI_Coburn
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
    Validated New Tank Picklist for AST                     Tank Test One               Location 1       2003                 AST                      111 - 550 Gallons    Fiberglass                 Fiberglass Coated Steel
    Validated New Tank Picklist for UST                     Tank Test One               Location 1       2004                 UST                      4001 - 15,000 Gallons                           STI-P3    Cathode Protected Steel
    Add Retroacive Date
    Select NAICS Code

    Expand Subjectivities
    #Update Subjectivity
    Update All Subjectivities

    #Add New Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003             AST                  111 - 550 Gallons        Fiberglass           Fiberglass Coated Steel

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
    Get Details for Billing Record document validation
    Get data to Validate on Billing Record

    Open Billing Record         New business
    Verify Static fields On Billing Record Page
    Validate Dynamic feilds on Billing Record               ${PolicyNumber_BR}          ${QuoteNameBill}                      ${uniqueName}            ${broker_contact}    Freberg                    CALIFORNIA INS CO    STEIL