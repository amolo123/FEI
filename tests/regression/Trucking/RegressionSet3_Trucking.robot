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
Verify Generate Binder & Complete Policy on Primary Trucking
    #Author= Amol Gaymukhe
    #TC=116814
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
    Sleep                       5s
    ClickText                   Rate                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Rated Successfully!                 timeout=30s
    Update All Subjectivities
    Sleep                       5s
    ClickText                   Save                        anchor=Rate
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
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
    Generate Document on Policy                             Binder
    Generate Document on Policy                             CompletePolicy
    ClickText                   (//article[@aria-label\='Document Revisions']//records-hoverable-link)[1]
    ClickText                   View Document
    VerifyText                  Success                     anchor=Document has been downloaded sucessfully!
    Back
    ClickText                   (//article[@aria-label\='Document Revisions']//records-hoverable-link)[2]
    ClickText                   View Document
    VerifyText                  Success                     anchor=Document has been downloaded sucessfully!

Verify Generate Binder, Policy & Complete Policy on Excess Trucking
    #Author= Amol Gaymukhe
    #TC=116815
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
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
    Sleep                       5s
    ClickText                   Rate                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Rated Successfully!                 timeout=30s
    Update All Subjectivities
    Sleep                       5s
    ClickText                   Save                        anchor=Rate
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
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
    Sleep                       10s
    Click on Finalize Button
    Verify Bound Pending
    Complete FreightIQ Flow
    Click On Save
    Click on Finalize Button
    Click On Proceed to Bind for final Bind
    ClickText                   Add On Policies
    ClickElement                (//lightning-primitive-custom-cell//a)                  anchor=FEI-TXS
    Generate Document on Policy                             Binder
    Generate Document on Policy                             CompletePolicy
    ClickText                   (//article[@aria-label\='Document Revisions']//records-hoverable-link)[1]
    ClickText                   View Document
    VerifyText                  Success                     anchor=Document has been downloaded sucessfully!
    Back
    ClickText                   (//article[@aria-label\='Document Revisions']//records-hoverable-link)[2]
    ClickText                   View Document
    VerifyText                  Success                     anchor=Document has been downloaded sucessfully!



Verify Generate Binder on PD Surplus on Trucking
    #Author= Amol Gaymukhe
    #TC=116816
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
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
    Sleep                       5s
    ClickText                   Rate                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Rated Successfully!                 timeout=30s
    Update All Subjectivities
    Sleep                       5s
    ClickText                   Save                        anchor=Rate
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
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
    ClickText                   Add On Policies
    ClickElement                (//lightning-primitive-custom-cell//a)                  anchor=FBCAT
    Generate Document on Policy                             Binder
    ClickText                   (//article[@aria-label\='Document Revisions']//records-hoverable-link)[1]
    ClickText                   View Document
    VerifyText                  Success                     anchor=Document has been downloaded sucessfully!

Verify Trucking renewal Clone
    #Author= Amol Gaymukhe`
    #TC=120908
    [Tags]                      Regression_Test_Trucking    Regression_Test
    [Documentation]             Verify All The Elements
    Creating a new Account
    Select Trucking
    Enter Data Into Submission Info Page Trucking
    Enter Full data On Submission Info Page
    Add Product                 Excess
    ClickText                   Save
    Sleep                       5s
    Import SAN NO and PD SAN NO                             5216351AJ00000              7216351AJ00000
    ClickText                   Save                        anchor=NEXT:Underwriting Console >
    VerifyText                  Success!                    anchor=Record is saved !    timeout=25s
    Get product selection business type and broker Contact
    ClickText                   NEXT:Underwriting Console >
    VerifyText                  Excess Rating
    TypeText                    Comments                    This is a test comment
    Sleep                       5s
    ClickText                   Save                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
    Sleep                       5s
    ClickText                   Rate                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Rated Successfully!                 timeout=30s
    Update All Subjectivities
    Sleep                       5s
    ClickText                   Save                        anchor=Rate
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
    
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
    Sleep                       10s
    Click on Finalize Button
    Verify Bound Pending
    Complete FreightIQ Flow
    Click On Save
    Click on Finalize Button
    Click On Proceed to Bind for final Bind
    ClickElement                //button[text()\="Renewal"]
    VerifyText                  Account Name
    Import SAN NO and PD SAN NO                             2792051AJ00000              7603051AJ00000
    VerifyText                  Application Type
    ClickText                   Application Type
    ClickText                   FEI Renewal Application
    ClickText                   Save                        anchor=NEXT:Underwriting Console >
    Get product selection business type and broker Contact after Renewal
    Compare Submission Info data Trucking