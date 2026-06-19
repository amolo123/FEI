*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_InsuredInfo.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInit.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInfo.robot

Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_Compare&RateQuote.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot



Library                         RetryFailed                 gglobal_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify the functionality of Clone, Edit, Retroacive, finalize button and all elements on Compare & Rate Quote For STEIL
    #Author = Amol Gaymukhe
    #TC=98025,98026,98027,98022
    [Documentation]             Verify able to add Excess Prior Policies on Exposures section
    [Tags]                      Smoke_Test_STEIL            Smoke_Test
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

    Verify Fields On Compare and Rate quote
    Verify Quote option is required to finalize
    Sleep                       6s
    Enter Quote Option
    Enter Value in Credit Debit Factor
    Enter Value in Primary Policy fees and Primary Loss Control Fees
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
    #Not Applicable For STEIL
    #Select Endorsements
    Logout


Verify All Documents Generation, Bind For STEIL
    #Author = Amol Gaymukhe
    #TC=98033,98028,98029,98023,98030,98032,98024,
    [Documentation]             Verify All Documents Generation, Bind For STEIL
    [Tags]                      Smoke_Test_STEIL            Smoke_Test
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
    Log To Console              --------------On Compare and Rate Quote----------------

    Enter Quote Option
    Enter Value in Credit Debit Factor
    Enter Value in Primary Policy fees and Primary Loss Control Fees
    Click on Rate Quote
    Click on Finalize Quote
    RefreshPage
    Generate Factor Summary Document from Dropdown Menu
    Sleep                       5s
    Generate Calclog Document from Dropdown Menu
    Sleep                       10s
    # Generate Specimen Policy Document from Dropdown Menu                              Primary
    # Sleep                     5s
    #Not Applicable For STEIL
    # Generate Specimen Policy Document from Dropdown Menu                              Excess
    # Sleep                     10s
    # Generate Rating Summary Document from Dropdown Menu                               Primary
    #Generate Rating Summary Document from Dropdown Menu    Excess
    Generate Primary or Excess Document                     Generate Primary
    Sleep                       5s
    #Not Applicable For STEIL
    # Generate Primary or Excess Document                   Generate Excess
    # Sleep                     10s
    Click On Bind
    Logout



