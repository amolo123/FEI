*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_InsuredInfo.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInit.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInfo.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_UnderwritingAnalysis.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_Compare&RateQuote.robot
Library                         ../../libraries/MailLib.py                              ${tenant_id}         ${client_id_mail}        ${client_secret_mail}

Library                         ../../libraries/graph.py
Resource                        ../../resources/graph.resource

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Send Email Functionality for STEIL
    #Author = Amol Gaymukhe
    #TC=
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
    Validated New Tank Picklist for AST                     Tank Test One               Location 1           2003                     AST                      111 - 550 Gallons                        Fiberglass    Fiberglass Coated Steel
    Validated New Tank Picklist for UST                     Tank Test One               Location 1           2004                     UST                      4001 - 15,000 Gallons                    STI-P3    Cathode Protected Steel

    Add Retroacive Date
    Select NAICS Code

    #Update Subjectivity
    Update Status Subjectivity                              UST OFAC                    Defer to Post Bind
    Update Status Subjectivity                              NI or AI                    Completed
    Update Status Subjectivity                              UST Ren App                 Waive
    # Update Status Subjectivity                            TRIA - STEIL                Waive
    Update Status Subjectivity                              UST App                     Waive
    Update Status Subjectivity                              BRF - STEIL                 Waive

    #Add New Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003                 AST                      111 - 550 Gallons        Fiberglass    Fiberglass Coated Steel

    #Qualify
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes

    Enter Quote Option
    Click on Rate Quote
    Sleep                       5s
    Click on Finalize Quote

    Send Mail On Submission Page                            90 Day Clearance
    Send Mail On Submission Page                            Endorsement Email
    Send Mail On Submission Page                            FEI Quote Declaration Email Template
    Send Mail On Submission Page                            Indication Email
    Send Mail On Submission Page                            Policy Email
    Send Mail On Submission Page                            Quote Email
    Send Mail On Submission Page                            Second Sub notification
    Send Mail On Submission Page                            SOA Email
    Logout
