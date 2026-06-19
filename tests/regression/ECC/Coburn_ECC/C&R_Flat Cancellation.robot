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
ECC Validate Billing Record for Cancel & Replace, Flat Cancellation
    #Author = Akshay
    #TC=116894,117063,116897
    [Documentation]             ECC Validate Billing Record for Cancel & Replace, Flat Cancellation
    [Tags]                      ECC_Coburn                  FEI_Coburn
    Creating a new Account
    Enter data on Insured info Page for ECC
    Select broker Contact Source
    VerifyText                  Submission Name
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Save On Submission Info
    Go Back To Insured Info and come back to submission Info
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Select Application Type
    Save On Submission Info
    Click Next To Underwriter Analysis

    VerifyText                  Total Premium Basis         anchor=General Info         timeout=60s
    TypeText                    *Total Premium Basis        30000
    # Add exposure
    Sleep                       35s
    Add Exposure                Above Ground Storage Tank Installation
    Add Exposure                Air Pollution Control Installation
    Add Exposure                All Professional Services
    Add Exposure                Air Pollution Control Design

    TypeText                    Above Ground Storage Tank Installation                  50
    TypeText                    Air Pollution Control Installation                      25
    TypeText                    All Professional Services                               25
    TypeText                    Air Pollution Control Design                            25
    ClickText                   Save
    Expand Subjectivities
    Subjectivities for CGL CPL PL
    ClickText                   Qualify Submission          anchor=ECC
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Log To Console              -------------On Compare and rate quote------------------
    Enter Retroactive date
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Sleep                       15s
    ${currPolicyPage_url}=      Get URL
    Change Policy               Cancel & Replace
    Select Cancel & Replace Input
    Sleep                       10s
    # ClickText                 Related                     anchor=Emails
    # ClickElement              (//lightning-primitive-cell-factory[@data-label\='Submission Name'])[1]
    Go To                       ${currPolicyPage_url}
    ClickText                   Related                     anchor=Emails
    ClickElement                //th[@data-label\='Submission Name']/lightning-primitive-cell-factory
    Rate Correction Quote
    Click on Finalize Quote after Cancel and Replace
    Click On Bind After Cancel and Replace
    Get Details for Billing Record document validation
    Open Billing Record         New Business
    Download Invoice
    Move to outputdir
    Verify Content on billing record PDF                    New Business                ${uniqueName}
    Empty Directory command
    Log To Console              ---- Flat Cancellation ---
    Navigate to policy Page from Billing record page
    Change Policy               Flat Cancellation
    Select Flat Cancellation Input
    Open Billing Record         Flat Cancellation
    Download Invoice
    Move to outputdir
    Verify Content on billing record PDF                    Flat Cancellation           ${uniqueName}
    Empty Directory command
    Log To Console              ------ On Policy Page -------
    