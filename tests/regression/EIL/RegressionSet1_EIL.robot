*** Settings ***
Resource                        ../../../resources/common.robot
Resource                        ../../../PageObjects/PageObjects_Account.robot
Resource                        ../../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource                        ../../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot
Resource                        ../../../PageObjects/EIL/PageObjects_EIL_SubmissionInfo.robot

Resource                        ../../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot
Resource                        ../../../PageObjects/EIL/PageObjects_EIL_Compare&RateQuote.robot
Resource                        ../../../PageObjects/PageObject_Compare&Rate_Common.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***

Verify New Business-EIL with TRIA
    #Author=Amol Gaymukhe
    #TC=68996,68997
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Regression_Test_EIL         Regression_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    Select broker Contact Source
    Sleep                       15s
    Log To Console              ------On Submission Info------
    Change Underwriter and CSR
    ScrollTo                    Coverage Product
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Log To Console              ----Coverage products are selected---
    Select Application Type
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Sleep                       10s

    VerifyText                  EIL Retro Date
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    VerifyText                  Total Premium Basis         anchor=General Info
    TypeText                    *Total Premium Basis        6000000
    ClickText                   Save
    Sleep                       5s
    Scroll                      Exposure
    # Add exposures
    Add Exposure                Above Ground Storage Tank Installation
    Add Exposure                Air Pollution Control Installation
    Add Exposure                Algae Farming
    Add Exposure                Air Pollution Control Design
    Add Exposure                Wastewater treatment systems

    TypeText                    Above Ground Storage Tank Installation                  25
    TypeText                    Air Pollution Control Installation                      25
    TypeText                    Algae Farming               50
    TypeText                    Wastewater treatment systems                            50
    TypeText                    Air Pollution Control Design                            50

    Expand Subjectivities
    Subjectivities for CGL CPL PL Excess and EIL
    ClickText                   Save

    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=Truss           search_by_industry=Manufacturing
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Sleep                       10s

    #Edit Location and add base premium
    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Check Tria Premium After No
    Log To Console              -------- Tria Premium after NO checked successfully -------
    Enter Retroactive date
    Enter Tria Selection Yes
    Click on Rate Quote
    Sleep                       5s
    Check Tria Premium After Yes
    Log To Console              -------- Tria Premium after Yes checked successfully -------
    Logout


Verify Unable to generate Quote Proposal on Failed Sanction Check
    #Author=Amol Gaymukhe
    #TC=80629
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Regression_Test_EIL         Regression_Test

    Home
    ClickElement                //span[text()\='App Launcher']
    TypeText                    //input[@placeholder\='Search apps and items...']       FEI Insurance
    ClickText                   FEI Insurance
    VerifyText                  FEI Insurance               anchor=Home
    VerifyText                  New                         anchor=Printable View
    ClickText                   New
    ClickElement                //button/span[text()\="Select Product"]
    ClickText                   EIL                         anchor=Product
    ClickText                   Next
    Sleep                       5s
    ClickElement                (//input[@placeholder\="Search..."])[1]
    TypeText                    (//input[@placeholder\="Search..."])[1]                 82 ELM REALTY
    ClickElement                (//li[@role\='presentation']/span)[1]
    sleep                       10s
    ClickElement                (//button[@name\='SaveAccount'])

    Log To Console              ----- Account added -----
    ClickText                   NEXT:Submission Info >
    Log To Console              ----- Data Entered On EIL Page ---------------

    Select broker Contact Source
    ClickText                   Yes                         anchor=No
    Sleep                       15s
    RefreshPage

    ClickText                   Compare & Rate Quotes
    ClickText                   Generate Primary
    VerifyText                  Error                       anchor=Cannot generate quote for sanction fail accounts    timeout=20s
    Logout


Clearing House Fees for WY State 
    #Author=Amol Gaymukhe
    #TC=69068
    [Documentation]             Clearing House Fees For WY
    [Tags]                      Regression_Test_EIL         Regression_Test
    Creating an account with WY state
    Enter data on Insured info Page for EIL
    Select broker Contact Source
    Sleep                       15s
    Log To Console              ------On Submission Info------
    Change Underwriter and CSR
    ScrollTo                    Coverage Product
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Log To Console              ----Coverage products are selected---
    Select Application Type
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Sleep                       10s

    VerifyText                  EIL Retro Date
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    VerifyText                  Total Premium Basis         anchor=General Info
    TypeText                    *Total Premium Basis        6000000
    ClickText                   Save
    Sleep                       5s
    Scroll                      Exposure
    # Add exposures
    Add Exposure                Above Ground Storage Tank Installation
    Add Exposure                Air Pollution Control Installation
    Add Exposure                Algae Farming
    Add Exposure                Air Pollution Control Design
    Add Exposure                Wastewater treatment systems

    TypeText                    Above Ground Storage Tank Installation                  25
    TypeText                    Air Pollution Control Installation                      25
    TypeText                    Algae Farming               50
    TypeText                    Wastewater treatment systems                            50
    TypeText                    Air Pollution Control Design                            50

    Expand Subjectivities
    Subjectivities for CGL CPL PL Excess and EIL

    ClickText                   Save

    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=Truss           search_by_industry=Manufacturing
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Sleep                       10s

    #Edit Location and add base premium
    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Verify Clearing house Fees
    Logout


