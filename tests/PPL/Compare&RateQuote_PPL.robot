*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_InsuredInfo.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_SubmissionInit.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_SubmissionInfo.robot

Resource                        ../../PageObjects/PPL/PageObjects_PPL_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_Compare&RateQuote.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

Library                         ../../libraries/MailLib.py                              ${tenant_id}                ${client_id_mail}           ${client_secret_mail}

Library                         ${CURDIR}/../../libraries/graph.py
Resource                        ${CURDIR}/../../resources/graph.resource

*** Test Cases ***

Verify the functionality of Clone, Edit, Retroacive, finalize button and all elements on Compare & Rate Quote for PPL
    #Author = Amol Gaymukhe
    #TC=98074,98075,98076,98077,98070,98069
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Smoke_Test_PPL              Smoke_Test

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

    ClickText                   Save                        anchor=Qualify Submission                               timeout=5s
    Sleep                       10s

    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes                               timeout=35s
    Log To Console              ----On Compare and rate quote----
    Verify Fields On Compare and Rate quote
    Verify Retroactive date Message when it is Blank
    Sleep                       6s
    Enter Retroactive date
    Enter Quote Option
    Click On Save
    Click on Rate Quote
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



Verify All Documents Generation, Bind for PPL
    #Author = Amol Gaymukhe
    #TC=98082,98073,98078,98071,98080,98081,98072,
    [Documentation]             Verify able verify All documents and Bind
    [Tags]                      Smoke_Test_PPL              Smoke_Test

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

    ClickText                   Save                        anchor=Qualify Submission                               timeout=5s
    Sleep                       10s


    #Qualify Submission
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes                               timeout=30s
    Log To Console              --------------On Compare and Rate Quote----------------
    Enter Retroactive date
    Enter Quote Option
    Click On Save
    Click on Rate Quote
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
    Sleep                       90s
    Click On Bind
    Logout