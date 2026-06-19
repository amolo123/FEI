*** Settings ***
Resource                        ../../../resources/common.robot
Resource                        ../../../PageObjects/PageObjects_Account.robot
Resource                        ../../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../../PageObjects/ECC/PageObjects_ECC_InsuredInfo.robot
Resource                        ../../../PageObjects/ECC/PageObjects_ECC_SubmissionInit.robot
Resource                        ../../../PageObjects/ECC/PageObjects_ECC_SubmissionInfo.robot

Resource                        ../../../PageObjects/ECC/PageObjects_ECC_UnderwritingAnalysis.robot
Resource                        ../../../PageObjects/ECC/PageObjects_ECC_Compare&RateQuote.robot
Resource                        ../../../PageObjects/PageObjects_PolicyPage.robot
Resource                        ../../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers



*** Test Cases ***

Verify User able to Approve Carrier Refer, Internal Refer
    #Author = Amol Gaymukhe
    #TC=80636,80633,80638,80635,80639
    [Documentation]             Verify Refer
    [Tags]                      Regression_Test_ECC         Regression_Test
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
    #Add Excess Prior polic
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto                 Alliance          Excess_2024         Yes        1000000                 1000000        100    Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp        Alliance_pro      Excess_2021         No         1000000                 1000000        100    Apr 5, 2022    Apr 5, 2023
    Expand Subjectivities
    Subjectivities for CGL CPL PL and Excess
    ClickText                   Qualify Submission          anchor=Save
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              -------------On Compare and rate quote------------------

    Carrier Referral Or Internal Referral for ECC           Carrier Referral
    Sleep                       25s
    Check Referral Mail
    RefreshPage
    Approve the Referral
    Sleep                       15s
    #Check Approved Referral Mail
    Log To Console              -------------Carrier referral Approve Completed------------------

    Carrier Referral Or Internal Referral for ECC           Internal Referral
    Sleep                       25s
    Check Referral Mail
    Approve the Referral
    Sleep                       15s
    #Check Approved Referral Mail
    Log To Console              -------------Internal referral Approve Completed------------------

    Carrier Referral Or Internal Referral for ECC           Carrier Referral
    Sleep                       25s
    Check Referral Mail
    RefreshPage
    Approve With Modification
    Sleep                       30s
    #Check Approved Referral Mail
    Log To Console              -------------Approve with Modification Carrier referral Completed------------------

    Carrier Referral Or Internal Referral for ECC           Internal Referral
    Sleep                       25s
    Check Referral Mail
    Approve With Modification
    Sleep                       30s
    #Check Approved Referral Mail
    Log To Console              -------------Approve with Modification Internal referral Completed------------------

    Carrier Referral Or Internal Referral for ECC           Carrier Referral
    Sleep                       25s
    Check Referral Mail
    Reject the Referral
    Sleep                       15s
    #Check Reject Referral Mail
    Log To Console              -------------Reject Carrier referral Completed------------------

    Carrier Referral Or Internal Referral for ECC           Internal Referral
    Sleep                       25s
    Check Referral Mail
    Reject the Referral
    Sleep                       15s
    #Check Reject Referral Mail
    Log To Console              -------------Reject Internal referral Completed------------------
    Logout



