*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_InsuredInfo.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_SubmissionInit.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_SubmissionInfo.robot

Resource                        ../../PageObjects/ECC/PageObjects_ECC_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_Compare&RateQuote.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify able to validate Endorsements
    #Author = Amol Gaymukhe
    #TC=97776
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Smoke_Test_ECC    Smoke_Test
    # Log To Console            -----Endorsement check Skipped(Pass)--------
    Creating a new Account
    Enter data on Insured info Page for ECC
    Select broker Contact Source
    ClickText                   Next                        anchor=Cancel
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
    Save On Submission Info
    Click Next To Underwriter Analysis

    #Validate NEXT Underwriter Analysis Info Elements for ECC
    VerifyText                  Total Premium Basis         anchor=General Info
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
    #Add Excess Prior polic
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto     Alliance       Excess_2024       Yes        1000000               1000000        100    Apr 5, 2023    Apr 5, 2024
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp           Alliance_pro      Excess_2021       No             1000000        1000000    100    Apr 5, 2022    Apr 5, 2023
    # Qualify Submission
    ClickText                   Qualify Submission          anchor=ECC
    VerifyText                  Success                     anchor=Update records successfully!         timeout=45s
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Click On Endorsement
    # Verify All Endorsements                               ECC_EN
    # Verify Default Endorsements for ECC                   ECC_VA
    Verify already added Endorsements for ECC
    Add Endorsement             ECC-515-0712                Water Intrusion Roofing Operations Exclusion
    # Add Endorsement           CG 00 67 03 05              Exclusion - Violation of Statutes that Govern E-Mails, Fax, Phone Calls
    Logout