*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/Trucking/PageObjects_Trucking_SubmissionConsole.robot
Resource                        ../../PageObjects/Trucking/PageObjects_Trucking_UnderwrittingConsole.robot
Resource                        ../../PageObjects/Trucking/PageObjects_Trucking_QuoteConsole.robot
Resource                        ../../resources/ReadPDF.robot
Resource                        ../../PageObjects/Trucking/PageObjects_PDFRead_Trucking.robot
Resource                        ../../PageObjects/PageObjects_PolicyPage.robot


Library                         RetryFailed                 global_retries=${retry_count}

Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***
Verify Excess Quote Document on Quote Console
    #Author= Amol Gaymukhe
    #TC=116757
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
    Get Quote Letter Dynamic Document Trucking
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
    Select Filing               No Filing
    Click On Save
    Click on Finalize Button
    Get Premium from Quote Console
    Generate Primary or Excess or PD(Surplus) Document      Primary
    Sleep                       5s
    Get WORD document and attach it to log
    Read Doc Quote Letter Primary Static Document Trucking
    Read Doc Quote Letter Primary Dynamic Document Trucking
    Sleep                       30s
    Generate Primary or Excess or PD(Surplus) Document      Excess
    Get WORD document and attach it to log
    Read Doc Quote Letter Excess Static Document Trucking
    Read Doc Quote Letter Excess Dynamic Document Trucking
    Sleep                       30s
    Generate Primary or Excess or PD(Surplus) Document      PD(Surplus)
    Get WORD document and attach it to log
    Read Doc Quote Letter PD(Surplus) Static Document Trucking
    Read Doc Quote Letter PD(Surplus) Dynamic Document Trucking

