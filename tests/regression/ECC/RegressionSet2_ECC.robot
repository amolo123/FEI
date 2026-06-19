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
Midterm Cancellation, Reinstatement, Flat Cancellation for ECC
    #Author = Amol Gaymukhe
    #TC=69023,69027,69031
    [Documentation]             Verify New Business-ECC with TRIA Yes
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto                 Alliance                    Excess_2024       Yes        1000000    1000000                 100            Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp        Alliance_pro                Excess_2021       No         1000000    1000000                 100            Apr 5, 2022    Apr 5, 2023
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
    Change Policy               Midterm Cancellation
    Select Midterm Cancellation Input
    Change Policy               Reinstatement
    Select Reinstatment Input
    Change Policy               Flat Cancellation
    Select Flat Cancellation Input
    ClickText                   Related                     anchor=Add On Policies
    VerifyAll                   Midterm Cancellation, Reinstatement, Flat Cancellation
    Logout


Flat Cancellation for ECC
    #Author = Amol Gaymukhe
    #TC=69023,69027,69031
    [Documentation]             Verify New Business-ECC with TRIA Yes
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto                 Alliance                    Excess_2024       Yes        1000000    1000000                 100            Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp        Alliance_pro                Excess_2021       No         1000000    1000000                 100            Apr 5, 2022    Apr 5, 2023
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

    Change Policy               Flat Cancellation
    Select Flat Cancellation Input
    ClickText                   Related                     anchor=Add On Policies
    VerifyText                  Flat Cancellation
    Logout

Extension For ECC
    #Author = Amol Gaymukhe
    #TC=69039
    [Documentation]             Verify New Business-ECC with TRIA Yes
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto                 Alliance                    Excess_2024       Yes        1000000    1000000                 100            Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp        Alliance_pro                Excess_2021       No         1000000    1000000                 100            Apr 5, 2022    Apr 5, 2023
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

    Change Policy               Extension
    Select Extension Input
    ClickText                   Related                     anchor=Add On Policies
    VerifyText                  Extension
    Logout

Cancel and Replace On ECC
    #Author = Amol Gaymukhe
    #TC=69035
    [Documentation]             Verify New Business-ECC with TRIA Yes
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
    Go To                       ${currPolicyPage_url}
    ClickText                   Related                     anchor=Emails
    ClickElement                //th[@data-label\='Submission Name']/lightning-primitive-cell-factory
    Rate Correction Quote
    Click on Finalize Quote after Cancel and Replace
    Click On Bind After Cancel and Replace
    ClickText                   Related                     anchor=Emails
    VerifyText                  Cancelled                   anchor=Status
    VerifyText                  Correction                  anchor=Status
    VerifyText                  Bound                       anchor=Status
    Logout



Generate-ECC-Binder, Policy & SOA
    #Author = Amol Gaymukhe
    #TC=69009
    [Documentation]             Verify New Business-ECC with TRIA Yes
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto                 Alliance                    Excess_2024       Yes        1000000    1000000                 100            Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp        Alliance_pro                Excess_2021       No         1000000    1000000                 100            Apr 5, 2022    Apr 5, 2023
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
    Generate Document on Policy                             Binder
    Sleep                       15s
    Generate Document on Policy                             Amendment
    Sleep                       15s
    Generate Document on Policy                             Policy
    Logout

Amendment-with Endorsement not having additional Premium and having flat premium for ECC    
    #Author = Amol Gaymukhe
    #TC=69019,69015,69054
    [Documentation]             Verify New Business-ECC with TRIA Yes
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto                 Alliance                    Excess_2024       Yes        1000000    1000000                 100            Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp        Alliance_pro                Excess_2021       No         1000000    1000000                 100            Apr 5, 2022    Apr 5, 2023
    # Qualify Submission
    #Complete All Subjectivities
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

    Log To Console              ----Initiating Amendment---
    Change Policy               Amendment
    Select Amendment Input
    ClickText                   Compare & Rate Quotes
    Sleep                       20s
    VerifyText                  Create And Compare Quotes                               timeout=35s
    Select Endorsements after Amendment
    Enter Data In Flat Premium
    Click on Rate Quote after amendment
    Sleep                       10s
    Click on Finalize Quote after amendment
    Click On Bind after amendment
    Log To Console              ------Amendment with flat premium is successfull------

    Change Policy               Amendment
    Select Amendment Input
    ClickText                   Compare & Rate Quotes
    Sleep                       20s
    VerifyText                  Create And Compare Quotes                               timeout=35s
    Select Endorsements after Amendment and Additional Premium
    Select Endorsements after Amendment and Free Form Endorsement
    Click on Rate Quote after amendment
    Sleep                       10s
    Click on Finalize Quote after amendment
    Click On Bind after amendment
    Log To Console              ------Amendment with Additional premium is successfull------
    Logout



ADD on Excess Policy for ECC, SL Fees for CO, ERP for ECC 
    #Author = Amol Gaymukhe
    #TC=69069,69058,69043
    [Documentation]             Verify New Business-ECC with TRIA Yes
    [Tags]                      Regression_Test_ECC         Regression_Test
    Creating a new Account
    Enter data on Insured info Page for ECC
    Select broker Contact Source
    VerifyText                  Submission Name
    Select state CO
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
    ClickText                   Charge CO SL Tax
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
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto                 Alliance                    Excess_2024       Yes        1000000    1000000                 100            Apr 5, 2023    Apr 5, 2024
    Sleep                       5s
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp        Alliance_pro                Excess_2021       No         1000000    1000000                 100            Apr 5, 2022    Apr 5, 2023
    Expand Subjectivities
    Update All Subjectivities

    ClickText                   Qualify Submission          anchor=ECC
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              -------------On Compare and rate quote------------------

    Enter Retroactive date
    Verify Primary SL Fees
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    ClickText                   Add On Policies             anchor=Related
    VerifyText                  Excess
    Change Policy               Midterm Cancellation
    Select Midterm Cancellation Input
    Change Policy               Extended Reporting Period
    Select ERP Input
    ClickText                   Related                     anchor=Emails
    VerifyText                  Extended Reporting Period
    Logout