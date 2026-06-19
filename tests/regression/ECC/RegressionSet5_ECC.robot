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

Verify Multiple forms Amendment and renewing the policy for ECC
    #Author = Amol Gaymukhe
    #TC=120374
    [Documentation]             Multiple forms Amendment and renewing the policy for ECC
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto     Alliance       Excess_2024       Yes        1000000               1000000        100    Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp           Alliance_pro      Excess_2021       No             1000000        1000000    100    Apr 5, 2022    Apr 5, 2023
    # Qualify Submission
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
    Change Policy               Amendment
    Select Amendment Input
    ClickText                   Compare & Rate Quotes
    Sleep                       20s
    VerifyText                  Create And Compare Quotes
    Select Endorsements after Amendment and Additional Premium with arg                 Governmental Entity Endorsement
    Click on Rate Quote after amendment
    Sleep                       30s
    Click on Finalize Quote after amendment
    Click On Bind after amendment
    Log To Console              ------Amendment with flat premium is successfull------
    Change Policy               Amendment
    Select Amendment Input
    ClickText                   Compare & Rate Quotes
    Sleep                       20s
    VerifyText                  Create And Compare Quotes
    Select Endorsements after Amendment and Additional Premium with arg                 Material Change Endorsement
    Click on Rate Quote after amendment
    Sleep                       30s
    Click on Finalize Quote after amendment
    Click On Bind after amendment
    Log To Console              ------Amendment with flat premium is successfull------
    ClickText                   Renewal
    VerifyText                  Renewal Opportunity is created successfully!            timeout=120s

Verify ECC Renewal Clone
    #Author = Amol Gaymukhe
    #TC=120374
    [Documentation]             Verify ECC renewal
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
    Save Coverage Products and broker name On Submission Page
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto     Alliance       Excess_2024       Yes        1000000               1000000        100    Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp           Alliance_pro      Excess_2021       No             1000000        1000000    100    Apr 5, 2022    Apr 5, 2023
    # Qualify Submission
    Expand Subjectivities
    Subjectivities for CGL CPL PL and Excess
    ClickText                        Save                        anchor=Qualify Submission
    Save Total Premium Basis On Underwriting Analysis Page 
    Save Exposures On Underwriting Analysis Page with Arg                12 
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
    Get Coverage Product and Broker Contact On Renewal
    Compare Submission Info data 
    ClickText                   Underwriting Analysis
    RefreshPage
    Get Save Total Premium Basis On Renewal
    Get Exposures On Underwriting Analysis Page On Renewal with Arg       12
    Compare Undewritting analysis data