*** Settings ***
Resource                        ../../../resources/common.robot
Resource                        ../../../PageObjects/PageObjects_Account.robot
Resource                        ../../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource                        ../../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot
Resource                        ../../../PageObjects/EIL/PageObjects_EIL_SubmissionInfo.robot

Resource                        ../../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot
Resource                        ../../../PageObjects/EIL/PageObjects_EIL_Compare&RateQuote.robot
Resource                        ../../../PageObjects/PageObjects_PolicyPage.robot
Resource                        ../../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***

Cancel and Replace For EIL  
    #Author=Amol Gaymukhe
    #TC=69036
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
    TypeText                    Wastewater treatment systems    50
    TypeText                    Air Pollution Control Design                            50

    Expand Subjectivities
    Subjectivities for CGL CPL PL and EIL

    ClickText                   Save

    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=Truss    search_by_industry=Manufacturing
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Sleep                       10s

    #Edit Location and add base premium
    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off
    #VerifyText                 Success                     anchor=The EIL Asset Location is updated    timeout=45s
    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Enter Retroactive date
    Enter Quote Option
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind

    Log To Console              ------ On Policy Page -------
    Change Policy               Cancel & Replace
    Select Cancel & Replace Input
    VerifyText                  Create And Compare Quotes
    Rate Correction Quote
    Click on Finalize Quote after Cancel and Replace
    Click On Bind After Cancel and Replace
    ClickText                   Related                     anchor=Emails
    VerifyText                  Cancelled                   anchor=Status
    VerifyText                  Correction                  anchor=Status
    VerifyText                  Bound                       anchor=Status
    Logout


Enter Credit & Debit and Re-rate on Renewal Business 
    #Author=Amol Gaymukhe
    #TC=69048,75940
    [Documentation]             Enter Credit and Debit on renewal
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
    TypeText                    Wastewater treatment systems    50
    TypeText                    Air Pollution Control Design                            50

    Expand Subjectivities
    Subjectivities for CGL CPL PL and EIL

    ClickText                   Save

    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=Truss    search_by_industry=Manufacturing
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Sleep                       10s

    #Edit Location and add base premium
    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off
    #VerifyText                 Success                     anchor=The EIL Asset Location is updated    timeout=45s
    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Enter Retroactive date
    Enter Quote Option
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind

    Click On renewal
    ClickText                   Submission Info
    ClickText                   Application Type
    ClickText                   FEI Renewal Application
    ClickText                   Save

    ClickText                   Underwriting Analysis
    Expand Subjectivities
    Update All Subjectivities
    ClickText                   Save                        anchor=Qualify Submission
    Sleep                       6s
    ClickText                   Compare & Rate Quotes

    Enter Value in Credit Debit Factor
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind

    ClickText                   Related                     anchor=Emails
    VerifyText                  Renewal                     anchor=Type
    Logout



ADD on Excess Policy for EIL, Free Form Endorsement For EIL, Generate Document 
    #Author=Amol Gaymukhe
    #TC=69059,69055,69010
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
    TypeText                    Wastewater treatment systems    50
    TypeText                    Air Pollution Control Design                            50

    Expand Subjectivities
    Subjectivities for CGL CPL PL Excess and EIL
    ClickText                   Save

    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=Truss    search_by_industry=Manufacturing
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Sleep                       10s

    #Edit Location and add base premium
    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off
    #VerifyText                 Success                     anchor=The EIL Asset Location is updated    timeout=45s
    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Click On Endorsement
    Add Free Form Endorsement
    Click on Rate Quote
    Enter Retroactive date
    Enter Quote Option
    Click On Save
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    ClickText                   Add On Policies             anchor=Related
    VerifyText                  Excess                      anchor=Policy Type
    ClickText                   P-                          anchor=Policy Name
    Sleep                       20s
    Generate Document on Policy                             Binder
    Generate Document on Policy                             Policy
    Logout
