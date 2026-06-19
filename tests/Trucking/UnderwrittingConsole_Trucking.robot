*** Settings ***
Resource                        ../../resources/common.robot

Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/Trucking/PageObjects_Trucking_SubmissionConsole.robot
Resource                        ../../PageObjects/Trucking/PageObjects_Trucking_UnderwrittingConsole.robot

Library                         RetryFailed                 global_retries=${retry_count}

Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***

Validate All the Elements on Underwrtting Page Trucking
    #Author= Amol Gaymukhe
    #TC=115863
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
    VerifyText                  Vehicle Schedule
    Validate field on Underwrtting Console page for Trucking
    ClickText                   < PREVIOUS:Submission Console
    VerifyText                  Account Information
    Add Product                 Excess
    ClickText                   Save                        anchor=NEXT:Underwriting Console >
    VerifyText                  Success!                    anchor=Record is saved !    timeout=25s
    ClickText                   NEXT:Underwriting Console >
    VerifyText                  Excess Rating
    Validate field on Underwrtting Console page for Trucking Excess


Verify Subjectivities on Underwriting Console for Trucking and Warning Mesage of Rating, Save button and Rate Button
    #Author= Amol Gaymukhe
    #TC=115866,115865,115864,115867
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
    VerifyText                  Vehicle Schedule
    VerifyText                  Excess Rating
    TypeText                    Comments                    This is a test comment
    ClickText                   Save                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Update records successfully!        timeout=20s
    Update All Subjectivities
    ClickText                   NEXT:Quote Console >
    VerifyText                  Error                       anchor=Please Rate Excess Quote before moving to Quote Console    timeout=20s
    ClickText                   Rate                        anchor=NEXT:Quote Console >
    VerifyText                  Success                     anchor=Rated Successfully!                 timeout=20s
    ClickText                   NEXT:Quote Console >
    Sleep                       15s
    VerifyText                  Quote Details               timeout=25s
