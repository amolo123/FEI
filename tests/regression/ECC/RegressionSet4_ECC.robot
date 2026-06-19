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
Generate Excess Quote Proposal Binder and Policy
    #Author = Amol Gaymukhe
    #TC=Reg-69003,Reg-69014,Reg-75939
    [Documentation]             Clone Edit Retroacive finalize button and all elements
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
    Generate Primary or Excess Document                     Generate Excess
    Click On Bind

    ClickText                   Add On Policies             anchor=Related
    #ClickText                  P-02                        anchor=Policy Name
    ClickText                   P-                          anchor=Policy Name
    Generate Document on Policy                             Binder
    Generate Document on Policy                             Policy
    Logout


Create a Broker Account
    #Author = Amol Gaymukhe
    #TC=Reg-69071
    [Documentation]             Clone Edit Retroacive finalize button and all elements
    [Tags]                      Regression_Test_ECC         Regression_Test
    Home
    ClickText                   Accounts
    VerifyText                  Recently Viewed             anchor=span                 timeout=40s
    ClickElement                //div[text()\="New"]

    UseModal                    On
    VerifyText                  New Account
    ClickText                   Broker
    Log To Console              Broker Clicked
    ClickText                   Next                        anchor=span                 timeout=20s

    Create a Broker
    Logout



Renewal for ECC
    #Author = Amol Gaymukhe
    #TC=Reg-69047
    [Documentation]             Create a renewal flow
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
    Verify Renewal Status
    Logout

Verify Creation of OCP Submission
    #Author = Akshay Verma
    #TC=Reg-104984
    [Documentation]             Verify Creation of OCP Submission
    [Tags]                      Regression_Test_ECC         Regression_Test
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
    Subjectivities for CGL CPL PL
    ClickText                   Qualify Submission          anchor=ECC
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              -------------On Compare and rate quote------------------
    Enter Retroactive date
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Add Policy                  OCP
    ClickText                   Confirm
    Enter OCP Data              Yes
    ClickText                   Confirm
    VerifyText                  Create And Compare Quotes
    ClickText                   Underwriting Analysis
    Expand Subjectivities
    Subjectivities for OCP
    ClickText                   Save
    ClickText                   Compare & Rate Quotes
    Click on Bind for OCP/RRP


Verify Creation of RRP Submission
    #Author = Akshay Verma
    #TC=Reg-104985
    [Documentation]             Verify Creation of RRP Submission
    [Tags]                      Regression_Test_ECC         Regression_Test
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
    Subjectivities for CGL CPL PL
    ClickText                   Qualify Submission          anchor=ECC
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              -------------On Compare and rate quote------------------
    Enter Retroactive date
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Add Policy                  RRP
    ClickText                   Confirm
    Enter RRP Data              Yes
    ClickText                   Confirm
    VerifyText                  Create And Compare Quotes
    ClickText                   Underwriting Analysis
    Expand Subjectivities
    Subjectivities for RRP
    ClickText                   Save
    ClickText                   Compare & Rate Quotes
    Click on Bind for OCP/RRP
