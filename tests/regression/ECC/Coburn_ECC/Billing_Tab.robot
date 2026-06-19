*** Settings ***
Resource                        ../../../../PageObjects/Freberg_Common.robot
Resource                        ../../../../PageObjects/PageObjects_Account.robot
Resource                        ../../../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../../../PageObjects/ECC/PageObjects_ECC_InsuredInfo.robot
Resource                        ../../../../PageObjects/ECC/PageObjects_ECC_SubmissionInit.robot
Resource                        ../../../../PageObjects/ECC/PageObjects_ECC_SubmissionInfo.robot

Resource                        ../../../../PageObjects/ECC/PageObjects_ECC_UnderwritingAnalysis.robot
Resource                        ../../../../PageObjects/ECC/PageObjects_ECC_Compare&RateQuote.robot
Resource                        ../../../../PageObjects/PageObjects_PolicyPage.robot
Resource                        ../../../../PageObjects/ECC/Coburn/BillingRecord_Page.robot
Resource                        ../../../../resources/ReadPDF.robot
Resource                        ../../../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}

Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***
ECC Validate Biling Record Tab
    #Author = Rugveda
    #TC=
    [Documentation]             ECC Validate Biling Record Tab
    [Tags]                      ECC_Coburn                  FEI_Coburn
    Creating a new Account
    Enter data on Insured info Page for ECC
    Select broker Contact Source
    VerifyText                  Submission Name
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Save On Submission Info
    Go Back To Insured Info and come back to submission Info
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess

    Select Application Type
    Save On Submission Info
    Click Next To Underwriter Analysis
    VerifyText                  Total Premium Basis         anchor=General Info         timeout=60s
    TypeText                    *Total Premium Basis        30000
    # Add exposure
    Add Exposure                Above Ground Storage Tank Installation
    Add Exposure                Air Pollution Control Installation
    Add Exposure                All Professional Services
    Add Exposure                Air Pollution Control Design

    TypeText                    Above Ground Storage Tank Installation                  50
    TypeText                    Air Pollution Control Installation                      25
    TypeText                    All Professional Services                               25
    TypeText                    Air Pollution Control Design                            25
    ClickText                   Save
    Sleep                       5s
    Expand Subjectivities
    Update All Subjectivities
    ClickText                   Qualify Submission          anchor=ECC
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Log To Console              -------------On Compare and rate quote------------------
    Enter Retroactive date
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Get Details for Billing Record document validation
    Get data to Validate on Billing Record

    Open Billing Record         New business
    Verify Static fields On Billing Record Page
    Validate Dynamic feilds on Billing Record               ${PolicyNumber_BR}          ${QuoteNameBill}                      ${uniqueName}                   ${broker_contact}    Freberg    CALIFORNIA INS CO    ECC

    Navigate to policy Page from Billing record page

    Open Billing Record for Excess                          New business
    Verify Static fields On Billing Record Page
    Validate Dynamic feilds on Billing Record               ${EXPolicyNumber_BR}        ${QuoteNameBill}                      ${uniqueName}                   ${broker_contact}    Freberg    CALIFORNIA INS CO    ECC