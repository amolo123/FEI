*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_InsuredInfo.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_SubmissionInfo.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_SubmissionInit.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_UnderwritingAnalysis.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***

Verify the field on Underwriter Ananysis for PPL
    # Author = Amol Gaymukhe
    #TC=97982,97989,98066,98062,98059
    [Documentation]             Underwriter Ananysis for PPL
    [Tags]                      Smoke_Test_PPL              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Sleep                       5s
    VerifyText                  EIL Retro Date
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Validate Elements on Underwriting Analysis for PPL
    VerifyText                  Total Premium Basis         anchor=General Info
    ScrollTo                    Total Premium Basis
    TypeText                    Total Premium Basis         700000
    Scroll                      Exposure
    Add exposures for PPL
    Expand Aria                 Subjectivities
    #Validate Subjectivities
    Logout

Verify the functionality of Qualify Submission Button on Underwriter Analysis tab
    # Author = Amol Gaymukhe
    #TC=98068,98067,98063,98061,98060,98064,98065
    [Documentation]             Underwriter Ananysis for PPL
    [Tags]                      Smoke_Test_PPL              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Sleep                       8s
    VerifyText                  Submission Name
    Change Underwriter and CSR
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    VerifyText                  EIL Retro Date
    ClickText                   Submission Info
    sleep                       5s
    ScrollTo                    Coverage Product

    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess

    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Sleep                       5s
    TypeText                    EIL Retro Date              23-10-2022
    Sleep                       10s
    VerifyText                  Total Premium Basis         anchor=General Info
    ScrollTo                    Total Premium Basis
    TypeText                    Total Premium Basis         600000
    ClickText                   Save
    VerifyText                  Success

    Scroll                      Exposure
    # Add exposures
    Add Exposure                Above Ground Storage Tank Installation
    Add Exposure                Bioremediation
    Add Exposure                Air Pollution Control Design
    Add Exposure                Intermediate Chemical Suppliers Sealants
    Add Exposure                Intermediate Chemical Suppliers Waxes (no pharmaceuticals)
    Add Exposure                Chemical Distribution?
    Add Exposure                Machine Shops

    #Add Percentage to added exposure
    TypeText                    Above Ground Storage Tank Installation                  25
    TypeText                    Bioremediation              25
    TypeText                    Air Pollution Control Design                            50
    TypeText                    Intermediate Chemical Suppliers Sealants                25
    TypeText                    Intermediate Chemical Suppliers Waxes (no pharmaceuticals)                          25
    TypeText                    Chemical Distribution?      25
    TypeText                    Machine Shops               25

    Enter Data In Excess Fields
    ClickText                   Save                        anchor=Qualify Submission
    Sleep                       5s

    #Add Industry
    ScrollText                  Locations and Assets        timeout=2s
    Add Industry Classifications                            search_for_classifications=221111 - Hydroelectric Power Generation                  search_by_industry=Utilities
    ClickText                   Save
    VerifyText                  Success                     anchor=Update records successfully!
    Sleep                       10s

    #Edit Location and add base premium

    Edit Record In EIL Asset Locations                      Location 1
    PickList                    Select EIL Classification                               221111 - Hydroelectric Power Generation
    PickList                    Basic Premiums              USD 5,000.00
    ClickText                   Save                        anchor=Cancel
    UseModal                    Off

    # New Loaction
    Add Industry Classifications                            search_for_classifications=Wood Window and Door         search_by_industry=Manufacturing
    New EIL Asset Location      location_name=Location Two                              address=2300 Ahtanum Rd, Yakima, WA 98903, USA          EIL_classification=321911 - Wood Window and Door Manufacturing    basic_premiums=USD 6,000.00

    #Add Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003                        AST                         111 - 550 Gallons    Fiberglass    Fiberglass Coated Steel

    # Update Subjectivity to Underwriting Analysis
    Expand Subjectivities
    Update All Subjectivities
    ClickText                   Save                        anchor=Qualify Submission                               timeout=5s
    Sleep                       10s
    #Add Excess Prior policy

    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Logout