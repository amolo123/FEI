*** Settings ***
Resource                        ../../../resources/common.robot
Resource                        ../../../PageObjects/PageObjects_Account.robot
Resource                        ../../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../../PageObjects/ECC/PageObjects_ECC_InsuredInfo.robot
Resource                        ../../../PageObjects/ECC/PageObjects_ECC_SubmissionInit.robot
Resource                        ../../../PageObjects/ECC/PageObjects_ECC_SubmissionInfo.robot

Resource                        ../../../PageObjects/ECC/PageObjects_ECC_UnderwritingAnalysis.robot
Resource                        ../../../PageObjects/ECC/PageObjects_ECC_Compare&RateQuote.robot
Resource                        ../../../PageObjects/PageObject_Compare&Rate_Common.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers



*** Test Cases ***

Verify New Business-ECC with TRIA
    #Author = Amol Gaymukhe
    #TC=68701
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
    Enter Tria Selection Yes
    Click on Rate Quote
    Sleep                       5s
    Check Tria Premium After Yes
    Logout



New Business-ECC+Excess with TRIA both NO and New Business-ECC+Excess with TRIA both Yes
    #Author = Amol Gaymukhe
    #TC=77740,77739
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
    Sleep                       5s
    Check Tria Premium and Excess Tria Premium After No

    Click on Rate Quote
    Enter Tria Selection Yes
    Enter Excess Tria Selection Yes
    Click on Rate Quote
    Sleep                       5s
    Check Tria Premium and Excess Tria Premium After Yes
    Logout


New Business-ECC+Excess with TRIA both Yes & NO    
    #Author = Akshay Verma
    #TC=77741
    [Documentation]             Verify New Business-ECC with TRIA Yes & NO
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
    Sleep                       5s

    Enter Tria Selection Yes
    Click on Rate Quote
    Sleep                       5s
    Check Tria Premium Yes and Excess Tria Premium No
    Logout

Policy fees and Primary Loss control fees on ECC
    #Author = Amol Gaymukhe
    #TC=69070
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
    Enter Primary Policy Fees
    Enter Primary Loss Control Fees
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Logout



