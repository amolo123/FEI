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
Verify Multiple forms Amendment and renewing the policy for EIL
    #Author=Amol Gaymukhe
    #TC=120375
    [Documentation]             Verify Multiple forms Amendment and renewing the policy for ECC
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

    Change Policy               Amendment
    Select Amendment Input

    ClickText                   Submission Info
    ClickText                   Application Type
    ClickText                   FEI Renewal Application
    ClickText                   Save

    ClickText                   Underwriting Analysis
    ClickText                   Save                        anchor=Qualify Submission
    Sleep                       6s
    ClickText                   Compare & Rate Quotes
    VerifyText                  Create And Compare Quotes
    Select Endorsements after Amendment and Additional Premium with arg                 Governmental Entity Endorsement
    Click on Rate Quote after amendment
    Sleep                       30s
    Click on Finalize Quote after amendment
    Click On Bind after amendment
    Log To Console              ------Amendment with flat premium is successfull------
    Change Policy               Amendment
    Select Amendment Input
    ClickText                   Compare & Rate Quotes
    Sleep                       20s
    VerifyText                  Create And Compare Quotes
    Select Endorsements after Amendment and Additional Premium with arg                 Material Change Endorsement
    Click on Rate Quote after amendment
    Sleep                       30s
    Click on Finalize Quote after amendment
    Click On Bind after amendment
    Log To Console              ------Amendment with flat premium is successfull------
    ClickText                   Renewal
    VerifyText                  Renewal Opportunity is created successfully!            timeout=120s

Verify EIL Renewal Clone
    #Author=Amol Gaymukhe
    #TC=120375
    [Documentation]             Verify EIL Renewal Clone
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
    Save Coverage Products and broker name On Submission Page
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
    ClickText                   Save                        anchor=Qualify Submission 

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
    ClickText                   Save                        anchor=Qualify Submission
    Save Total Premium Basis On Underwriting Analysis Page 
    Save Exposures On Underwriting Analysis Page with Arg            10  

    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Enter Retroactive date
    Enter Quote Option
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Click On renewal
    ClickText                   Application Type
    ClickText                   FEI Renewal Application
    ClickText                   Save
    Get Coverage Product and Broker Contact On Renewal
    Compare Submission Info data 
    ClickText                   Underwriting Analysis
    RefreshPage
    Get Save Total Premium Basis On Renewal
    Get Exposures On Underwriting Analysis Page On Renewal with Arg                     10
    Compare Undewritting analysis data
