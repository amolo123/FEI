*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInfo.robot

Resource                        ../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_Compare&RateQuote.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify the functionality of Clone, Edit, Retroacive, finalize button and all elements on Compare & Rate Quote For EIL
    #Author = Amol Gaymukhe
    #TC=98074,98076,98077,
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Smoke_Test_EIL              Smoke_Test
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
    #VerifyText                 Success                     anchor=The EIL Asset Location is updated    timeout=45s
    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Verify Fields On Compare and Rate quote
    Verify Retroactive date Message when it is Blank
    Sleep                       6s
    Enter Retroactive date
    Enter Quote Option
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


Verify All Documents Generation, Bind For EIL
    #Author = Amol Gaymukhe
    #TC=98082,98073,98078,98071,98080,98081,98072
    [Documentation]             Verify able verify All documents and Bind
    [Tags]                      Smoke_Test_EIL              Smoke_Test
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
    Select Application Type
    Save On Submission Info
    Log To Console              ----Coverage products are selected---
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
    VerifyText                  Success                     anchor=Update records successfully!        timeout=10s

    #Edit Location and add base premium
    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off
    #VerifyText                 Success                     anchor=The EIL Asset Location is updated    timeout=45s
    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    VerifyText                  Create And Compare Quotes                               timeout=65s
    Log To Console              --------------On Compare and Rate Quote----------------

    Enter Retroactive date
    Enter Quote Option
    Enter Value in Credit Debit Factor
    Enter Value in Primary Policy fees and Primary Loss Control Fees
    Enter Value in Excess Credit Debit Factor
    Click on Rate Quote
    Click on Finalize Quote
    RefreshPage
    Generate Factor Summary Document from Dropdown Menu
    Sleep                       5s
    Generate Calclog Document from Dropdown Menu
    Sleep                       10s
    Generate Primary or Excess Document                     Generate Primary
    Sleep                       5s
    Generate Primary or Excess Document                     Generate Excess
    Sleep                       10s
    Click On Bind
    Logout