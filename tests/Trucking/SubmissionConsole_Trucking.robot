*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/Trucking/PageObjects_Trucking_SubmissionConsole.robot

Library                         RetryFailed                 global_retries=${retry_count}

Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***
Validate All the Elements on SubmissionInfo Page Trucking
    #Author= Amol Gaymukhe
    [Tags]                      Smoke_Test_Trucking         Smoke_Test
    [Documentation]             Verify All The Elements
    Creating a new Account
    Select Trucking
    Enter Data Into Submission Info Page Trucking
    Validate field on Submission Console page for Trucking


Validate All Buttons Fields On SubmissionInfo Page Trucking
    #Author= Amol Gaymukhe
    [Tags]                      Smoke_Test_Trucking         Smoke_Test
    [Documentation]             Verify All Buttons and Its form Elements
    Creating a new Account
    Select Trucking
    Enter Data Into Submission Info Page Trucking
    Check Import SAN form fields
    Check New Event form fields
    Check New Note form fields
    Check Delete form fields

Validate All Buttons Functionality On SubmissionInfo Page Trucking
    #Author= Amol Gaymukhe
    [Tags]                      Smoke_Test_Trucking         Smoke_Test
    [Documentation]             Verify All Buttons and Its form Elements
    Creating a new Account
    Select Trucking
    Enter Data Into Submission Info Page Trucking
    Create New Event
    Create Import SAN Button Functionality
    Create New Note Button Functionality
    Click on Delete Button and Remove Opportunity


Validate Save and Next Button On SubmissionInfo Page Trucking 
    #Author= Amol Gaymukhe
    [Tags]                      Smoke_Test_Trucking         Smoke_Test
    [Documentation]             Save and Next Button
    Creating a new Account
    Select Trucking
    Enter Data Into Submission Info Page Trucking
    Enter Full data On Submission Info Page
    Import SAN NO and PD SAN NO                             5216351AJ00000              7216351AJ00000
    ClickText                   NEXT:Underwriting Console >
    VerifyText                  Vehicle Schedule
