*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_InsuredInfo.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_SubmissionInit.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_SubmissionInfo.robot

Resource                        ../../PageObjects/ECC/PageObjects_ECC_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_Compare&RateQuote.robot
Resource                        ../../PageObjects/PageObjects_PolicyPage.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot

Library                         ../../libraries/MailLib.py                              ${tenant_id}         ${client_id_mail}        ${client_secret_mail}

Library                         ../../libraries/graph.py
Resource                        ../../resources/graph.resource

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Send Email Functionality For ECC 
    #Author = Amol Gaymukhe
    #TC=
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Smoke_Test_ECC              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for ECC
    Select broker Contact Source
    VerifyText                  Submission Name
    Change Underwriter and CSR
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto          Alliance                 Excess_2024         Yes        1000000               1000000        100    Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp                          Alliance_pro        Excess_2021       No             1000000        1000000    100    Apr 5, 2022    Apr 5, 2023
    ClickText                   Qualify Submission          anchor=ECC
    VerifyText                  Success                     anchor=Update records successfully!              timeout=45s
    VerifyText                  Create And Compare Quotes                               timeout=30s
    Enter Retroactive date
    Click on Rate Quote
    Click on Finalize Quote
    Sleep                       10s
    Send Mail On Submission Page                            90 Day Clearance
    Send Mail On Submission Page                            Endorsement Email
    Send Mail On Submission Page                            FEI Quote Declaration Email Template
    Send Mail On Submission Page                            Indication Email
    Send Mail On Submission Page                            Policy Email
    Send Mail On Submission Page                            Quote Email
    Send Mail On Submission Page                            Second Sub notification
    Send Mail On Submission Page                            SOA Email
    Logout


Send Email Functionality On Policy For ECC 
    #Author = Amol Gaymukhe
    #TC=69023,69027,69031
    [Documentation]             Verify New Business-ECC with TRIA Yes
    [Tags]                      Regression                  ECC_Flat_Cancel             Regression-ECC       69023                    69027    69031
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto          Alliance                 Excess_2024         Yes        1000000               1000000        100    Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp                          Alliance_pro        Excess_2021       No             1000000        1000000    100    Apr 5, 2022    Apr 5, 2023
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
    Send Mail On Policy Page    90 Day Clearance
    Send Mail On Policy Page    Binder Email
    Send Mail On Policy Page    Endorsement Email
    Send Mail On Policy Page    FEI Quote Declaration Email Template
    Send Mail On Policy Page    Indication Email
    Send Mail On Policy Page    Policy Email
    Send Mail On Policy Page    Quote Email
    Send Mail On Policy Page    Second Sub notification
    Send Mail On Policy Page    SOA Email