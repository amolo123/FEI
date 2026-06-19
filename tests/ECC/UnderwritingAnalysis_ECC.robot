** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_InsuredInfo.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_SubmissionInit.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_SubmissionInfo.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_Compare&RateQuote.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify the field on Underwriter Analysis Page
    # Author = Vighanesh Surve
    #TC= 97771,97772,97779
    [Documentation]             field on Underwriter Analysis Page
    [Tags]                      Smoke_Test_ECC    Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for ECC
    Select broker Contact Source
    Sleep                       10s
    VerifyText                  Submission Name
    Change Underwriter and CSR
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Sleep                       10s
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    VerifyText                  Total Premium Basis         anchor=General Info         timeout=30s
    Validate Underwriting Analysis Elements for ECC
    Expand Subjectivities
    Subjectivities for CGL CPL PL and Excess
    ClickText                   Save                        anchor=Qualify Submission
    VerifyText                  Success                     anchor=Update records successfully!

    Add Exposure                Above Ground Storage Tank Installation
    Add Exposure                Air Pollution Control Installation
    Add Exposure                All Professional Services
    Add Exposure                Air Pollution Control Design

    TypeText                    Above Ground Storage Tank Installation                  50
    TypeText                    Air Pollution Control Installation                      25
    TypeText                    All Professional Services                               25
    TypeText                    Air Pollution Control Design                            25

    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!

    TypeText                    Above Ground Storage Tank Installation                  50
    TypeText                    Air Pollution Control Installation                      25
    TypeText                    All Professional Services                               25
    TypeText                    Air Pollution Control Design                            25
    TypeText                    Private Passenger Vehicle                               1
    TypeText                    Private Passenger Vehicle                               2
    TypeText                    Light Vehicle               2
    TypeText                    Light Vehicle               1
    TypeText                    Medium Vehicle              2
    TypeText                    Medium Vehicle              3
    TypeText                    Heavy Vehicle               1
    TypeText                    Heavy Vehicle               2
    TypeText                    Extra Heavy Vehicle         2
    TypeText                    Extra Heavy Vehicle         1
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Logout

Verify able to add Excess Prior Policies on Exposures section
    # Author = Amol Gaymukhe
    #TC=97776
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Smoke_Test_ECC    Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for ECC
    Validate Submission Init on Submission info page for ECC
    Select broker Contact Source
    Sleep                       10s
    VerifyText                  Submission Name
    Change Underwriter and CSR
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    ClickText                   Save
    Go Back To Insured Info and come back to submission Info
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    ClickText                   Save
    Click Next To Underwriter Analysis
    VerifyText                  Total Premium Basis         anchor=General Info
    TypeText                    *Total Premium Basis        30000
    # Add exposure
    Add Exposure                Above Ground Storage Tank Installation
    Add Exposure                Air Pollution Control Installation
    Add Exposure                All Professional Services
    Add Exposure                Air Pollution Control Design
    Enter Data In Excess Fields
    ClickText                   Save
    #Add Excess Prior polic
    Add Prior Policies for Excess                           STOCKBRIDGE INS CO          Excess Auto                 Alliance       Excess_2024         Yes        1000000               1000000        100    Apr 5, 2023    Apr 5, 2024
    Add Prior Policies for Excess                           INS CO IN LC                Excess Worker's Comp        Alliance_pro            Excess_2021           No     1000000        1000000        100    Apr 5, 2022    Apr 5, 2023

    TypeText                    Above Ground Storage Tank Installation                  50
    TypeText                    Air Pollution Control Installation                      25
    TypeText                    All Professional Services                               25
    TypeText                    Air Pollution Control Design                            25

    ClickText                   Save
    # Qualify Submission
    ClickText                   Qualify Submission          anchor=ECC
    VerifyText                  Success                     anchor=Update records successfully!
    Logout                     


