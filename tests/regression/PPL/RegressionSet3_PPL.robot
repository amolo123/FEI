*** Settings ***
Resource                        ../../../resources/common.robot
Resource                        ../../../PageObjects/PageObjects_Account.robot
Resource                        ../../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../../PageObjects/PPL/PageObjects_PPL_InsuredInfo.robot
Resource                        ../../../PageObjects/PPL/PageObjects_PPL_SubmissionInit.robot
Resource                        ../../../PageObjects/PPL/PageObjects_PPL_SubmissionInfo.robot

Resource                        ../../../PageObjects/PPL/PageObjects_PPL_UnderwritingAnalysis.robot
Resource                        ../../../PageObjects/PPL/PageObjects_PPL_Compare&RateQuote.robot
Resource                        ../../../PageObjects/PageObjects_PolicyPage.robot
Resource                        ../../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

Library                         ../../../libraries/MailLib.py                           ${tenant_id}                ${client_id_mail}           ${client_secret_mail}

Library                         ${CURDIR}/../../../libraries/graph.py
Resource                        ${CURDIR}/../../../resources/graph.resource

*** Test Cases ***

Amendment-with Endorsement having additional Premium for PPL
    #Author = Amol Gaymukhe
    #TC=68999,68998
    [Documentation]             ERP and Extension On PPL
    [Tags]                      Regression_Test_PPL         Regression_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Sleep                       8s
    VerifyText                  Submission Name
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    VerifyText                  EIL Retro Date
    ClickText                   Submission Info
    sleep                       5s
    ScrollTo                    Coverage Product

    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Select Application Type
    Save On Submission Info
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

    #Add excess data
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

    Expand Subjectivities
    Update All Subjectivities
    ClickText                   Save                        timeout=5s
    Sleep                       10s
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes                               timeout=35s
    Log To Console              ----On Compare and rate quote-----

    Enter Retroactive date
    Enter Quote Option
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Sleep                       10s

    Change Policy               Amendment
    Select Amendment Input

    ClickText                   Submission Info
    ClickText                   Application Type
    ClickText                   FEI Renewal Application
    ClickText                   Save
    Sleep                       10s

    ClickText                   Compare & Rate Quotes
    VerifyText                  Create And Compare Quotes

    RefreshPage
    Check Premium before adding additional premium endorsement
    Select Endorsement on Amendment
    Click on Rate after Amendment
    Sleep                       10s
    Check Premium after adding additional premium endorsement
    Check after additional premium endorsement the premium is increased
    Logout



Amendment-with Endorsement not having additional Premium and having flat premium for PPL
    #Author = Amol Gaymukhe
    #TC=68999,68998
    [Documentation]             ERP and Extension On PPL
    [Tags]                      Regression_Test_PPL         Regression_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Sleep                       8s
    VerifyText                  Submission Name
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    VerifyText                  EIL Retro Date
    ClickText                   Submission Info
    sleep                       5s
    ScrollTo                    Coverage Product

    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Select Application Type
    Save On Submission Info
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

    #Add excess data
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

    Expand Subjectivities
    Update All Subjectivities

    ClickText                   Save                        timeout=5s
    Sleep                       10s
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes                               timeout=35s
    Log To Console              ----On Compare and rate quote-----

    Enter Retroactive date
    Enter Quote Option
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Sleep                       10s

    Change Policy               Amendment
    Select Amendment Input

    ClickText                   Submission Info
    ClickText                   Application Type
    ClickText                   FEI Renewal Application
    ClickText                   Save
    Sleep                       10s

    ClickText                   Compare & Rate Quotes
    VerifyText                  Create And Compare Quotes

    Check Primary Quote Premium before flat input
    RefreshPage
    Enter Data In Flat Premium
    Click on Rate after Amendment
    Sleep                       10s
    Check Primary Quote Premium after flat input
    Validate premium is increased after flat premium
    Logout


Cancel and Replace for PPL
    #Author = Amol Gaymukhe
    #TC=68999,68998
    [Documentation]             ERP and Extension On PPL
    [Tags]                      Regression_Test_PPL         Regression_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Sleep                       8s
    VerifyText                  Submission Name
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    VerifyText                  EIL Retro Date
    ClickText                   Submission Info
    sleep                       5s
    ScrollTo                    Coverage Product

    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability

    Select Application Type
    Save On Submission Info
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

    Expand Subjectivities
    Update All Subjectivities

    ClickText                   Save                        timeout=5s
    Sleep                       10s
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes                               timeout=35s
    Log To Console              ----On Compare and rate quote-----

    Enter Retroactive date
    Enter Quote Option
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Sleep                       10s
    ${currPolicyPage_url}=      Get URL
    Change Policy               Cancel & Replace
    Select Cancel & Replace Input
    Sleep                       10s
    Go To                       ${currPolicyPage_url}
    ClickText                   Related                     anchor=Emails
    ClickElement                //th[@data-label\='Submission Name']/lightning-primitive-cell-factory
    Rate Correction Quote
    Click on Finalize Quote after Cancel and Replace
    Click On Bind After Cancel and Replace
    ClickText                   Related                     anchor=Emails
    VerifyText                  Cancelled                   anchor=Status
    VerifyText                  Correction                  anchor=Status
    VerifyText                  Bound                       anchor=Status
    Logout

