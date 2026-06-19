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
Excess Validate Billing Record for EXS_Renewal
    #Author = Akshay
    #TC=117096
    [Documentation]             Excess Validate Billing Record for EXS_Renewal
    [Tags]                      EXCESS_Coburn                  FEI_Coburn
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto     Alliance       Excess_2024       Yes        1000000               1000000        100    Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp           Alliance_pro      Excess_2021       No             1000000        1000000    100    Apr 5, 2022    Apr 5, 2023
    Expand Subjectivities
    Subjectivities for CGL CPL PL and Excess
    ClickText                   Qualify Submission          anchor=ECC
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Log To Console              -------------On Compare and rate quote------------------
    Enter Retroactive date
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Click On renewal
    ClickText                   Application Type
    ClickText                   FEI Renewal Application
    ClickText                   Save
    ClickText                   Underwriting Analysis
    Expand Subjectivities
    Update All Subjectivities
    ClickText                   Compare & Rate Quote
    Log To Console              -----On Compare and rate Screen----
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    ClickText                   Add On Policies             anchor=Related
    ClickText                   P-                          anchor=Policy Name
    Get Details for Billing Record document validation
    Open Billing Record         Renewal
    Download Invoice
    Move to outputdir
    Verify Content on billing record PDF                    Renewal                     ${uniqueName}
    Empty Directory command