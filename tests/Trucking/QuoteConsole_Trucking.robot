*** Settings ***
Resource                        ../../resources/common.robot

Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/Trucking/PageObjects_Trucking_SubmissionConsole.robot
Resource                        ../../PageObjects/Trucking/PageObjects_Trucking_UnderwrittingConsole.robot
Resource                        ../../PageObjects/Trucking/PageObjects_Trucking_QuoteConsole.robot


Library                         RetryFailed                 global_retries=${retry_count}

Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***
Validate All the Elements on Quote Console Page Trucking
    #Author= Amol Gaymukhe
    #TC=115886, 115871, 115872, 115873, 115877, 115882
    [Tags]                      Smoke_Test_Trucking         Smoke_Test
    [Documentation]             Verify All The Elements
    Creating a new Account
    Select Trucking
    Enter Data Into Submission Info Page Trucking
    Enter Full data On Submission Info Page
    Add Product                 Excess
    ClickText                   Save
    Import SAN NO and PD SAN NO                             5216351AJ00000              7216351AJ00000
    ClickText                   Save                        anchor=NEXT:Underwriting Console >
    VerifyText                  Success!                    anchor=Record is saved !    timeout=25s
    ClickText                   NEXT:Underwriting Console >
    VerifyText                  Excess Rating
    TypeText                    Comments                    This is a test comment
    Sleep                       5s
    ClickText                   Save                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
    ClickText                   Rate                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Rated Successfully!                 timeout=30s
    Update All Subjectivities
    Sleep                       5s
    ClickText                   Save                        anchor=Rate
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
    ClickText                   NEXT:Quote Console >
    Sleep                       15s
    VerifyText                  Quote Details               timeout=25s
    Validate field on Quote Console page for Trucking
    Select Filing               No Filing
    Click On Save
    Click on Finalize Button
    Verify Bound Pending
    Sleep                       5s
    # ClickText                   Bind
    # RefreshPage
    ClickText                   Bind
    VerifyText                  Error                       anchor=Filing Sign Off needs to be completed before Bind    timeout=25s
    Select Filing Review SPOE                               Copado SPOE
    ${SPOE_URL}=                GetUrl
    ClickText                   View profile
    ClickText                   Log Out
    ## Filing SPOE Check Code
    Home2
    Log To Console              ${uniqueName}
    GoTo                        ${SPOE_URL}
    # Select Submission from Search
    Complete Filing Review SPOE Sign Off Flow
    ClickText                   View profile
    ClickText                   Log Out
    ####
    Home
    Select Submission from Search
    # Click on Finalize Button
    # Verify Bound Pending
    ClickText                   Bind
    VerifyText                  Error                       anchor=FreightIQ Final Pricing Action is required to Bind    timeout=25s
    Complete FreightIQ Flow
    Click On Save
    Click on Finalize Button
    Click On Proceed to Bind for final Bind

