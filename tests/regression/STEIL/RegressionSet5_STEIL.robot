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

Verify Multiple forms Amendment and renewing the policy for STEIL
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
    Select Endorsements after Amendment and Additional Premium with arg                 ECC-520-0712
    Click on Rate Quote after amendment
    Sleep                       30s
    Click on Finalize Quote after amendment
    Click On Bind after amendment
    Log To Console              ------Amendment with flat premium is successfull------


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

    Select Endorsements after Amendment and Additional Premium with arg                 ECC-571-0712
    Click on Rate Quote after amendment
    Sleep                       30s
    Click on Finalize Quote after amendment
    Sleep                       20s
    Click On Bind after amendment
    Log To Console              ------Amendment with flat premium is successfull------
    ClickText                   Renewal
    VerifyText                  Renewal Opportunity is created successfully!            timeout=120s


Verify STEIL Renewal Clone    
    #Author = Amol Gaymukhe
    #TC=120907
    [Documentation]             Verify STEIL Renewal Clone
    [Tags]                      Regression_Test_STEIL       Regression_Test
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Select Application Type
    Save On Submission Info
    Save Coverage Products and broker name On Submission Page
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
    Get Retro date NAICS EIL asset Location and tank
    #Qualify
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Log To Console              ----On Compare and rate quote-----

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
    Get Retro date NAICS EIL asset Location and tank after renewal
    Compare Undewritting analysis data for STEIL
