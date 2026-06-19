*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInfo.robot

Resource                        ../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_Compare&RateQuote.robot
Resource                        ../../resources/ReadPDF.robot
Resource                        ../../PageObjects/EIL/PageObjects_PDFRead_EIL.robot
Resource                        ../../PageObjects/PageObjects_PolicyPage.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***
Read Quote Letter Policy Document and Binder For EIL
    #Author = Amol Gaymukhe
    #TC=69052
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
    TypeText                    Wastewater treatment systems                         50
    TypeText                    Air Pollution Control Design                            50

    Expand Subjectivities
    Subjectivities for CGL CPL PL Excess and EIL
    ClickText                   Save

    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=Truss                        search_by_industry=Manufacturing
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Sleep                       10s

    #Edit Location and add base premium
    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off
    #VerifyText                 Success                     anchor=The EIL Asset Location is updated                timeout=45s
    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Enter Retroactive date
    Enter Quote Option
    Click on Rate Quote
    Get Quote Letter Dynamic Document EIL
    Click on Finalize Quote
    Sleep                       15s
    RefreshPage
    Generate Primary or Excess Document                     Generate Primary
    Get WORD document and attach it to log
    Read Doc Quote Letter Static Document EIL
    Read Doc Quote Letter Dynamic Document EIL
    Click On Bind
    Sleep                       30s
    Get Policy No
    Generate Document on Policy                             Policy
    Sleep                       15s
    Click On Policy and Download
    Sleep                       20s
    Get WORD document and attach it to log
    Read Policy Letter Static Document EIL
    Read Policy Letter Dynamic Document EIL
    Back
    Generate Document on Policy                             Binder
    Sleep                       15s
    Click On Binder and Download
    Sleep                       20s
    Get WORD document and attach it to log
    Read Binder Letter Static Document EIL
    Read Binder Letter Dynamic Document EIL
    Logout