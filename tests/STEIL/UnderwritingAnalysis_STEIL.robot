*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_InsuredInfo.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInit.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_SubmissionInfo.robot
Resource                        ../../PageObjects/STEIL/PageObjects_STEIL_UnderwritingAnalysis.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***


Verify STEIL Underwriter Analysis Elements
    # Author = Amol Gaymukhe
    #TC=98014,98015,98017,98016,98018,98019
    [Documentation]             STEIL Underwriter Analysis
    [Tags]                      Smoke_Test_STEIL            Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for STEIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Validate NEXT Underwriter Analysis Info Elements for STEIL
    VerifyText                  Retroactive Date            timeout=10s
    Validate Elements on Underwriting Analysis for STEIL
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >
    # Validate Subjectivities are open for STEIL
    Validated New Tank Picklist for AST                     Tank Test One               Location 1     2003                     AST           111 - 550 Gallons          Fiberglass    Fiberglass Coated Steel
    Validated New Tank Picklist for UST                     Tank Test One               Location 1     2004                     UST           4001 - 15,000 Gallons      STI-P3    Cathode Protected Steel

    Expand Subjectivities
    #Update Subjectivity
    Update All Subjectivities

    #Add New Tank
    Add New STEIL Tank          Tank Test One               Location 1                  2003    AST    111 - 550 Gallons        Fiberglass    Fiberglass Coated Steel

    #Qualify
    ClickElement                //button[@title\='Qualify Submission']
    Sleep                       30s
    VerifyText                  Create And Compare Quotes
    Logout



    # Update Subjectivity to Underwriting Analysis
    #                           [Documentation]             STEIL Underwriter Analysis
    #                           [Tags]                      STEIL Underwriter Analysis
    #                           # Author = Vighanesh Surve
    #                           #TC=98018
    #                           # Update Subjectivity to Underwriting Analysis

    #                           Creating a new Account
    #                           Enter data on Insured info Page for STEIL
    #                           Validate Submission Init on Submission info page for STEIL
    #                           Select broker Contact Source
    #                           ClickText                   Next                        anchor=Cancel
    #                           VerifyText                  Submission Name
    #                           Validate NEXT Underwriter Analysis Info Elements for STEIL
    #                           VerifyText                  Retroactive Date            timeout=10s
    #                           ClickText                   Submission Info
    #                           sleep                       5s
    #                           ClickText                   NEXT:Underwriter Analysis >
    #                           Update Status Subjectivity                              UST OFAC       Defer to Post Bind
    #                           Update Status Subjectivity                              NI or AI       Completed
    #                           Update Status Subjectivity                              UST Ren App    Waive
    #                           Update Status Subjectivity                              TRIA - STEIL                            Waive
    #                           Update Status Subjectivity                              UST App        Waive
    #                           Update Status Subjectivity                              BRF - STEIL    Waive

    # Add Tank to Underwriting Analysis
    #                           [Documentation]             STEIL Underwriter Analysis
    #                           [Tags]                      STEIL Underwriter Analysis
    #                           # Author = Vighanesh Surve
    #                           #TC=98016

    #                           Creating a new Account
    #                           Enter data on Insured info Page for STEIL
    #                           Validate Submission Init on Submission info page for STEIL
    #                           Select broker Contact Source
    #                           ClickText                   Next                        anchor=Cancel
    #                           VerifyText                  Submission Name
    #                           Validate NEXT Underwriter Analysis Info Elements for STEIL
    #                           VerifyText                  Retroactive Date            timeout=10s
    #                           ClickText                   Submission Info
    #                           sleep                       5s
    #                           ClickText                   NEXT:Underwriter Analysis >
    #                           Add New STEIL Tank          Tank Test One               Location 1     2003                     AST           111 - 550 Gallons          Fiberglass    Fiberglass Coated Steel

    # Verify the functionality of Qualify Submission Button on Underwriter Analysis tab
    #                           [Documentation]             STEIL Underwriter Analysis
    #                           [Tags]                      STEIL Underwriter Analysis
    #                           # Author = Vighanesh Surve
    #                           #TC=98019
    #                           Creating a new Account
    #                           Enter data on Insured info Page for STEIL
    #                           Validate Submission Init on Submission info page for STEIL
    #                           Select broker Contact Source
    #                           ClickText                   Next                        anchor=Cancel
    #                           VerifyText                  Submission Name
    #                           Validate NEXT Underwriter Analysis Info Elements for STEIL
    #                           VerifyText                  Retroactive Date            timeout=10s
    #                           ClickText                   Submission Info
    #                           sleep                       5s
    #                           ClickText                   NEXT:Underwriter Analysis >
    #                           PickList                    Business NAICS Code         Citrus grove or orchard
    #                           Add New STEIL Tank          Tank Test One               Location 1     2003                     AST           111 - 550 Gallons          Fiberglass    Fiberglass Coated Steel

    #                           #Qualify Submission
    #                           ClickElement                //button[@title\='Qualify Submission']
    #                           Sleep                       30s
    #                           VerifyText                  Create And Compare Quotes

