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

Verify able to validate Endorsements For EIL
    #Author = Amol Gaymukhe
    #TC=
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
    # # Add exposures
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

    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=Truss    search_by_industry=Manufacturing
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Sleep                       10s

    # #Edit Location and add base premium
    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off

    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Click On Endorsement
    #Verify Default Endorsements for EIL                     EIL_VA
    Verify already added Endorsements for EIL
    Add Endorsement             EIL-1055-0316               In-Place Asbestos Coverage Endorsement
    Add Endorsement             EIL-1085-0316               Named Insured Endorsement
    Logout

