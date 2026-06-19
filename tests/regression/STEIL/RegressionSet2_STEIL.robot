*** Settings ***
Resource                        ../../../resources/common.robot
Resource                        ../../../PageObjects/PageObjects_Account.robot
Resource                        ../../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../../PageObjects/STEIL/PageObjects_STEIL_InsuredInfo.robot
Resource                        ../../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInit.robot
Resource                        ../../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInfo.robot

Resource                        ../../../PageObjects/STEIL/PageObjects_STEIL_UnderwritingAnalysis.robot
Resource                        ../../../PageObjects/STEIL/PageObjects_STEIL_Compare&RateQuote.robot
Resource                        ../../../PageObjects/PageObjects_PolicyPage.robot
Resource                        ../../../PageObjects/PageObject_Compare&Rate_Common.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***
Flat Term Cancellation for STEIL
    #Author = Amol Gaymukhe
    #TC=69034
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Regression_Test_STEIL       Regression_Test
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Select Application Type
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >

    VerifyText                  Retroactive Date            timeout=10s
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >
    Validated New Tank Picklist for AST                     Tank Test One               Location 1     2003                     AST           111 - 550 Gallons          Fiberglass    Fiberglass Coated Steel
    Validated New Tank Picklist for UST                     Tank Test One               Location 1     2004                     UST           4001 - 15,000 Gallons      STI-P3    Cathode Protected Steel
    Add Retroacive Date
    Select NAICS Code

    Expand Subjectivities
    #Update Subjectivity
    Update All Subjectivities

    #Add New Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003    AST    111 - 550 Gallons        Fiberglass    Fiberglass Coated Steel

    #Qualify
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              ----On Compare and rate quote-----

    Enter Quote Option
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Sleep                       10s
    Log To Console              ----On Policy page-----

    Change Policy               Flat Cancellation
    Select Flat Cancellation Input
    ClickText                   Related                     anchor=Add On Policies
    VerifyAll                   Flat Cancellation
    VerifyText                  Bound                       anchor=1
    VerifyText                  Bound                       anchor=2
    Logout

Cancel and Replace for STEIL
    #Author = Amol Gaymukhe
    #TC=69038
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Regression_Test_STEIL       Regression_Test
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Select Application Type
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >

    VerifyText                  Retroactive Date            timeout=10s
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >
    Validated New Tank Picklist for AST                     Tank Test One               Location 1     2003                     AST           111 - 550 Gallons          Fiberglass    Fiberglass Coated Steel
    Validated New Tank Picklist for UST                     Tank Test One               Location 1     2004                     UST           4001 - 15,000 Gallons      STI-P3    Cathode Protected Steel
    Add Retroacive Date
    Select NAICS Code

    Expand Subjectivities
    #Update Subjectivity
    Update All Subjectivities

    #Add New Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003    AST    111 - 550 Gallons        Fiberglass    Fiberglass Coated Steel

    #Qualify
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              ----On Compare and rate quote-----

    Enter Quote Option
    Click on Rate Quote
    Click on Finalize Quote
    Click On Bind
    Sleep                       10s

    Log To Console              ----On Policy page-----
    ${url}=                     GetUrl
    Log To Console              ${url}
    Change Policy               Cancel & Replace
    Select Cancel & Replace Input
    # ClickText                 Related                     anchor=Emails
    # ClickElement              (//lightning-primitive-cell-factory[@data-label\='Submission Name'])[1]
    Go To                       ${url}
    ClickText                   Related                     anchor=Emails
    ClickElement                (//lightning-primitive-cell-factory[@data-label\='Submission Name'])[1]
    VerifyText                  Create And Compare Quotes
    Rate Correction Quote
    Click on Finalize Quote after Cancel and Replace
    Click On Bind After Cancel and Replace
    ClickText                   Related                     anchor=Emails
    VerifyText                  Correction                  anchor=Status
    VerifyText                  Bound                       anchor=Status
    #VerifyText                 Cancelled                   anchor=Status
    Logout


Amendment-with Endorsement having additional Premium for STEIL
    #Author = Amol Gaymukhe
    #TC=69000,69026,69030,69046
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Regression_Test_STEIL       Regression_Test
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Select Application Type
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >

    VerifyText                  Retroactive Date            timeout=10s
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >
    Validated New Tank Picklist for AST                     Tank Test One               Location 1     2003                     AST           111 - 550 Gallons          Fiberglass    Fiberglass Coated Steel
    Validated New Tank Picklist for UST                     Tank Test One               Location 1     2004                     UST           4001 - 15,000 Gallons      STI-P3    Cathode Protected Steel
    Add Retroacive Date
    Select NAICS Code

    Expand Subjectivities
    #Update Subjectivity
    Update All Subjectivities

    #Add New Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003    AST    111 - 550 Gallons        Fiberglass    Fiberglass Coated Steel

    #Qualify
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              ----On Compare and rate quote-----

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

    # ClickText                 Underwriting Analysis
    # ClickText                 Save                        anchor=Qualify Submission
    # Sleep                     6s
    ClickText                   Compare & Rate Quotes
    VerifyText                  Create And Compare Quotes

    RefreshPage
    Check Premium before adding additional premium endorsement
    Select Endorsement on Amendment ECC-557-0712
    Click on Rate after Amendment
    Sleep                       10s
    Check Premium after adding additional premium endorsement
    Check after additional premium endorsement the premium is increased
    Logout


Amendment-with Endorsement not having additional Premium and having flat premium for STEIL
    #Author = Amol Gaymukhe
    #TC=69000,69026,69030,69046
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Regression_Test_STEIL       Regression_Test
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Select Application Type
    Save On Submission Info
    ClickText                   NEXT:Underwriter Analysis >

    VerifyText                  Retroactive Date            timeout=10s
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >
    Validated New Tank Picklist for AST                     Tank Test One               Location 1     2003                     AST           111 - 550 Gallons          Fiberglass    Fiberglass Coated Steel
    Validated New Tank Picklist for UST                     Tank Test One               Location 1     2004                     UST           4001 - 15,000 Gallons      STI-P3    Cathode Protected Steel
    Add Retroacive Date
    Select NAICS Code

    Expand Subjectivities
    #Update Subjectivity
    Update All Subjectivities

    #Add New Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003    AST    111 - 550 Gallons        Fiberglass    Fiberglass Coated Steel

    #Qualify
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              ----On Compare and rate quote-----

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

    # ClickText                 Underwriting Analysis
    # ClickText                 Save                        anchor=Qualify Submission
    # Sleep                     6s
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
