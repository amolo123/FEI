*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot

Resource                        ../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot
Resource                        ../../resources/Upload_CSV_file.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***

Verify the field on Underwriter Ananysis for EIL
    # Author = Amol Gaymukhe
    #TC=97982,97989,97985,97985
    [Documentation]             field on Underwriter Ananysis for EIL
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    Select broker Contact Source
    VerifyText                  SUBMISSION INFO
    Sleep                       15s
    Change Underwriter and CSR
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Sleep                       5s
    VerifyText                  EIL Retro Date
    Validate Elements on Underwriting Analysis for EIL

    ClickText                   Submission Info
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    VerifyText                  Total Premium Basis         anchor=General Info
    ScrollTo                    Total Premium Basis
    TypeText                    Total Premium Basis         600000
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!

    Scroll                      Exposure
    # Add exposures
    Add Exposure                Wastewater treatment systems
    Add Exposure                General Contracting NOC Low Hazard
    Add Exposure                General Contracting NOC Med Hazard
    Add Exposure                General Consulting
    Add Exposure                Geophysical surveys

    TypeText                    Wastewater treatment systems                            100
    TypeText                    General Contracting NOC Low Hazard                      25
    TypeText                    General Contracting NOC Med Hazard                      25
    TypeText                    General Consulting          25
    TypeText                    Geophysical surveys         25
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=Truss            search_by_industry=Manufacturing
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
    Logout

Verify Exposures able to enter Excess metro and other field 
    # Author = Amol Gaymukhe
    #TC=97987,97991,97992,97988
    [Documentation]             Underwriter_Ananysis_EIL
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    Sleep                       10s
    VerifyText                  Submission Name
    Change Underwriter and CSR
    Sleep                       5s
    ClickText                   < PREVIOUS:Insured Info     anchor=Submission Header
    ClickText                   NEXT:Submission Info >      anchor=Notes                timeout=5sec
    ScrollTo                    Coverage Product
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
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
    Enter Data In Excess Fields
    ClickText                   Save

    VerifyText                  Success                     anchor=Update records successfully!

    Expand Aria                 Subjectivities

    Subjectivities for CGL CPL PL Excess and EIL

    ClickText                   Save

    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=Truss            search_by_industry=Manufacturing
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Sleep                       10s

    #Edit Location and add base premium

    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off
    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Logout
