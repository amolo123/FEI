*** Settings ***
Resource                        ../resources/common.robot
Resource                        ../PageObjects/PageObjects_Account.robot
Resource                        ../PageObjects/PageObjects_HomePage.robot
Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers


*** Test Cases ***

Validate Creation of Business Account : Save and New Button 
    # Author = Amol
    #TC=
    [Documentation]             Save and New Of the Created Account
    [Tags]                      Smoke_Test
    Creating a new Account with Save and new


Validate Creation of Business Account : Cancel Button 
    # Author = Amol
    #TC=
    [Documentation]             Save and New Of the Created Account
    [Tags]                      Smoke_Test
    Creation of Account Cancel
    Validate if account was created when user had Cancel


Validate when check box for "Mailing same as billing address" is checked - Mailing and Billing address are same on the Details tab after saving the account info    
    # Author = Amol
    #TC=
    [Documentation]             Save and New Of the Created Account
    [Tags]                      Smoke_Test
    Creating a new Account
    Verify Account Created Fields

Validate Creation of Business Account : Save Button 
    # Author = Amol
    #TC=
    [Documentation]             Creating an Account and Verifying
    [Tags]                      Smoke_Test
    #Validate Account Elements
    Creating a new Account
    Verify Account Created Fields
    #Delete Account Click

Validate Editing the Details Tab after the Account Creation 
    # Author = Amol
    #TC=
    [Documentation]             Editing Of the Created Account
    [Tags]                      Smoke_Test
    Creating a new Account
    Editing the Account

Validate when check box for "Mailing same as billing address" is unchecked- Mailing and Billing address are not same on the Details tab after saving the account info
    # Author = Akshay Verma
    #TC=94259
    [Documentation]             "Mailing same as billing address" is unchecked- Mailing and Billing address are not same
    [Tags]                      Smoke_Test
    Creation of Account unchecked Mailing same as Billing address
    Verify Billing and Mailling address

Validate the Buttons acc - Follow & Edit
    # Author = Akshay Verma
    #TC=94260
    [Documentation]             Validate the Buttons acc - Follow & Edit
    [Tags]                      Smoke_Test
    Creation of Account unchecked Mailing same as Billing address
    Verify Follow and Edit Button

Verify Insurance Item, Contact, Sanction, on Account
    # Author = Akshay Verma
    #TC=94261
    [Documentation]             Validate the Buttons acc - Follow & Edit
    [Tags]                      Smoke_Test
    Creation of Account unchecked Mailing same as Billing address
    Verify Insurance Item Contact Sanction on Account

