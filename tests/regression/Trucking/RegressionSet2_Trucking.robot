*** Settings ***

Resource                        ../../../resources/common.robot
Resource                        ../../../PageObjects/Freberg_Common.robot
Resource                        ../../../PageObjects/PageObjects_Account.robot
Resource                        ../../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../../PageObjects/Trucking/PageObjects_Trucking_SubmissionConsole.robot
Resource                        ../../../PageObjects/Trucking/PageObjects_Trucking_UnderwrittingConsole.robot
Resource                        ../../../PageObjects/Trucking/PageObjects_Trucking_QuoteConsole.robot
Resource                        ../../../PageObjects/PageObjects_PolicyPage.robot

Library                         RetryFailed                 global_retries=${retry_count}

Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***
Verify Renewal transaction on Primary for trucking
    #Author= Amol Gaymukhe
    #TC=116758
    [Tags]                      Regression_Test_Trucking    Regression_Test
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
    VerifyText                  Success                     anchor=Update records successfully!                   timeout=20s
    Sleep                       5s
    ClickText                   Rate                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Rated Successfully!                            timeout=30s
    Update All Subjectivities
    Sleep                       5s
    ClickText                   Save                        anchor=Rate
    VerifyText                  Success                     anchor=Update records successfully!                   timeout=20s
    ClickText                   NEXT:Quote Console >
    Sleep                       15s
    VerifyText                  Quote Details               timeout=25s
    Click on Finalize Button
    Verify Bound Pending
    Select Filing               No Filing
    Click On Save
    Select Filing Review SPOE                               Copado SPOE
    ${SPOE_URL}=                GetUrl
    ClickText                   View profile
    ClickText                   Log Out
    ## Filing SPOE Check Code
    Home2
    Log To Console              ${uniqueName}
    GoTo                        ${SPOE_URL}
    #Select Submission from Search
    Complete Filing Review SPOE Sign Off Flow
    ClickText                   View profile
    ClickText                   Log Out
    ####
    Home
    GoTo                        ${SPOE_URL}
    Click on Finalize Button
    Verify Bound Pending
    Complete FreightIQ Flow
    Click On Save
    Click on Finalize Button
    Click On Proceed to Bind for final Bind
    Sleep                       10s
    ClickElement                //button[text()\="Renewal"]
    VerifyText                  Account Name
    Import SAN NO and PD SAN NO                             2792051AJ00000              7603051AJ00000
    VerifyText                  Application Type
    ClickText                   Application Type
    ClickText                   FEI Renewal Application
    ClickText                   Save                        anchor=NEXT:Underwriting Console >
    Renewal Flow Complete Trucking
    VerifyText                  Quote Details
    Complete FreightIQ Flow
    Select Filing               No Filing
    Click On Save
    Click on Finalize Button
    Verify Bound Pending
    Select Filing Review SPOE                               Copado SPOE
    ${SPOE_URL}=                GetUrl
    ClickText                   View profile
    ClickText                   Log Out
    ## Filing SPOE Check Code
    Home2
    Log To Console              ${uniqueName}
    GoTo                        ${SPOE_URL}
    #Select Submission from Search
    Complete Filing Review SPOE Sign Off Flow
    ClickText                   View profile
    ClickText                   Log Out
    ####
    Home
    GoTo                        ${SPOE_URL}
    ClickText                   Bind
    VerifyText                  Success                     anchor=Bind quote successfully!                       timeout=35s
    ClickText                   Related                     anchor=Emails
    VerifyText                  Renewal                     anchor=Type


Verify Amendment transaction on Excess for trucking
    #Author= Amol Gaymukhe
    #TC=116881
    [Tags]                      Regression_Test_Trucking    Regression_Test
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
    VerifyText                  Success                     anchor=Update records successfully!                   timeout=20s
    Sleep                       5s
    ClickText                   Rate                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Rated Successfully!                            timeout=30s
    Update All Subjectivities
    Sleep                       5s
    ClickText                   Save                        anchor=Rate
    VerifyText                  Success                     anchor=Update records successfully!                   timeout=20s
    ClickText                   NEXT:Quote Console >
    Sleep                       15s
    VerifyText                  Quote Details               timeout=25s
    Click on Finalize Button
    Verify Bound Pending
    Select Filing               No Filing
    Click On Save
    Select Filing Review SPOE                               Copado SPOE
    ${SPOE_URL}=                GetUrl
    ClickText                   View profile
    ClickText                   Log Out
    ## Filing SPOE Check Code
    Home2
    Log To Console              ${uniqueName}
    GoTo                        ${SPOE_URL}
    #Select Submission from Search
    Complete Filing Review SPOE Sign Off Flow
    ClickText                   View profile
    ClickText                   Log Out
    ####
    Home
    GoTo                        ${SPOE_URL}
    Click on Finalize Button
    Verify Bound Pending
    Complete FreightIQ Flow
    Click On Save
    Click on Finalize Button
    Click On Proceed to Bind for final Bind
    ${amendment_date1}=         GetText                     //p[text()\='Effective Date']/parent::div//lightning-formatted-text    result_format=datetime
    Log To Console              ${amendment_date1}
    ClickText                   Add On Policies
    RefreshPage
    ClickText                   Add On Policies
    ClickElement                (//lightning-primitive-custom-cell//a)                  anchor=FEI-TXS
    Change Policy               Amendment
    Select Amendment Input Trucking Excess                  ${amendment_date1}
    # Import SAN NO and PD SAN NO                           1717551AJ00000              3717551AJ00000
    # ClickText                 NEXT:Underwriting Console >
    # VerifyText                Excess Rating
    # ClickText                 NEXT:Quote Console >
    VerifyText                  Quote Details
    Select Filing               No Filing
    Click On Save
    Click on Finalize Button
    Verify Bound Pending
    # Select Filing Review SPOE                             Copado SPOE
    # Home
    # GoTo                      ${SPOE_URL}
    # Click on Finalize Button
    # Verify Bound Pending
    # Complete FreightIQ Flow
    # Click On Save
    # Click on Finalize Button
    # Click On Proceed to Bind for final Bind
    Click on Bind
    ClickText                   Related                     anchor=Emails
    VerifyText                  New Business                anchor=Quote Type
    VerifyText                  Amendment                   anchor=Quote Type




