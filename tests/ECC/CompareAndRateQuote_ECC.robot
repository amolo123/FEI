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

Verify the functionality of Clone Edit Retroacive finalize button and all elements on Compare & Rate Quote 
    #Author = Amol Gaymukhe
    #TC=97802,97804,97806,97807
    #TC=Reg-69066,Reg-69051,Reg-75939
    [Documentation]             Clone Edit Retroacive finalize button and all elements
    [Tags]                      Smoke_Test_ECC              Smoke_Test
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
    #Update All Subjectivities
    # Update Status Subjectivity                            ECC OFAC                    Completed
    # Update Status Subjectivity                            TRIA - All                  Completed
    # Update Status Subjectivity                            BRF                         Completed
    # Update Status Subjectivity                            BRF - UL info               Completed
    # Update Status Subjectivity                            TRIA - XS                   Completed
    # Update Status Subjectivity                            XS OFAC                     Completed
    # Update Status Subjectivity                            BRF - XS                    Completed
    Subjectivities for CGL CPL PL and Excess
    ClickText                   Qualify Submission          anchor=ECC

    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              -------------On Compare and rate quote------------------
    Verify Fields On Compare and Rate quote
    Verify Retroactive date Message when it is Blank
    Sleep                       6s
    Enter Retroactive date
    Enter Value in Credit Debit Factor
    Enter Value in Primary Policy fees and Primary Loss Control Fees
    Enter Value in Excess Credit Debit Factor
    Click on Rate Quote
    Sleep                       5s
    Clone Quote Click
    Sleep                       15s
    Close Quote                 2
    Click on New Quote
    Sleep                       15s
    Close Quote                 2
    Click on Finalize Quote
    Click on Edit Quote
    Select Endorsements
    Logout
    #Sleep                      5s
    #Click on Rate Quote


Verify All Documents Generation and Bind
    #Author = Amol Gaymukhe
    #TC=97820,97801,97808,97799,97810,97819,97800,97798
    #TC=Reg-69004,Reg-77541,Reg-69003
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Smoke_Test_ECC              Smoke_Test
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
    Expand Subjectivities
    # Update Status Subjectivity                            ECC OFAC                    Completed
    # Update Status Subjectivity                            TRIA - All                  Completed
    # Update Status Subjectivity                            BRF                         Completed
    # Update Status Subjectivity                            BRF - UL info               Completed
    # Update Status Subjectivity                            TRIA - XS                   Completed
    # Update Status Subjectivity                            XS OFAC                     Completed
    # Update Status Subjectivity                            BRF - XS                    Completed
    Subjectivities for CGL CPL PL and Excess
    ClickText                   Qualify Submission          anchor=ECC
    VerifyText                  Success                     anchor=Update records successfully!         timeout=45s
    VerifyText                  Create And Compare Quotes                               timeout=45s
    Enter Retroactive date
    Enter Value in Credit Debit Factor
    Enter Value in Primary Policy fees and Primary Loss Control Fees
    Enter Value in Excess Credit Debit Factor
    Click on Rate Quote
    Click on Finalize Quote
    RefreshPage
    Generate Factor Summary Document from Dropdown Menu
    Sleep                       5s
    # Generate Specimen Policy Document from Dropdown Menu                              Primary
    # Generate Specimen Policy Document from Dropdown Menu                              Excess
    Sleep                       10s
    Generate Rating Summary Document from Dropdown Menu     Primary
    #Generate Rating Summary Document from Dropdown Menu    Excess
    Generate Calclog Document from Dropdown Menu
    Generate Primary or Excess Document                     Generate Primary
    Generate Primary or Excess Document                     Generate Excess
    Sleep                       10s
    Click On Bind
    Logout

Verify Generate Loss Run on Account
    # Author = Akshay Verma
    #TC=94262
    [Documentation]             Validate the Buttons acc - Follow & Edit
    [Tags]                      Smoke_Test_ECC              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for ECC
    Select broker Contact Source
    VerifyText                  Submission Name
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Select Application Type
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
    Expand Subjectivities
    # Update Status Subjectivity                            ECC OFAC                    Completed
    # Update Status Subjectivity                            TRIA - All                  Completed
    # Update Status Subjectivity                            BRF                         Completed
    # Update Status Subjectivity                            BRF - UL info               Completed
    # Update Status Subjectivity                            TRIA - XS                   Completed
    # Update Status Subjectivity                            XS OFAC                     Completed
    # Update Status Subjectivity                            BRF - XS                    Completed
    Subjectivities for CGL CPL PL and Excess
    ClickText                   Qualify Submission          anchor=ECC
    VerifyText                  Success                     anchor=Update records successfully!         timeout=45s
    VerifyText                  Create And Compare Quotes                               timeout=45s
    Enter Retroactive date
    Enter Value in Credit Debit Factor
    Enter Value in Primary Policy fees and Primary Loss Control Fees
    Enter Value in Excess Credit Debit Factor
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    #ClickElement               //a[@id\='window']
    ClickFieldValue             Account
    ClickElement                //li[@class\='slds-dropdown-trigger slds-dropdown-trigger_click slds-button_last overflow']
    ClickText                   Generate Loss Run Doc
    UseModal                    on
    ClickElement                //label[@class\='slds-checkbox__label']
    ClickElement                //button[@class\='slds-button slds-button_brand']
    Logout
    #VerifyText                 Success                     anchor=Loss Run request is successfully     timeout=45s
