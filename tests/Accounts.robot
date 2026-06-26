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

Verify Insurance Item, Contact, Sanction, on Account2
    # Author = Akshay Verma
    #TC=94261
    [Documentation]             Validate the Buttons acc - Follow & Edit
    [Tags]                      Smoke_Test
    Home
    Creating a new Account
    Home
    ClickText                   App Launcher
    TypeText                    //input[@placeholder\='Search apps and items...']       FEI Insurance
    ClickText                   FEI Insurance
    VerifyText                  FEI Insurance               anchor=Home
    VerifyText                  New                         anchor=Printable View
    ClickText                   New
    ClickElement                //button/span[text()\="Select Product"]
    ClickText                   ECC                         anchor=Product
    ClickText                   Next
    ClickElement                (//input[@placeholder\="Search..."])[1]
    TypeText                    (//input[@placeholder\="Search..."])[1]                 ${uniqueName}               anchor=Account Name
    ClickElement                (//li[@role\='presentation']/span)[1]
    PickList                    Business Type               LLC
    TypeText                    Credit Score                10
    TypeText                    SIC Code                    345687
    TypeText                    SIC Description             Entertainment               345687
    ClickText                   NEXT:Submission Info >
    VerifyText                  Confirmation
    ClickText                   Yes                         anchor=No
    UseModal                    On
    VerifyText                  Submission Init Form
    ClickElement                //label[text()\='Broker Contact']/following-sibling::div//input
    TypeText                    //label[text()\='Broker Contact']/following-sibling::div//input                     Akshay Verma
    Sleep                       3s
    ClickElement                //label[text()\='Broker Contact']/following-sibling::div//span[contains(text(),'Akshay Verma - Akshay Broker - Independence')]
    ClickText                   Next                        anchor=Cancel
    ${picklist}=                GetPickList                 Relationship Type           selected=True
    Log To Console              ${picklist}
    IF                          '${picklist}' == 'Broker'
        Log To Console          Success
    ELSE
        Fail
    END
    VerifyPickList              Relationship Type           --None--                    Broker                      Sub-Producer
    ClickText                   Next                        anchor=Cancel
    ${list}=                    Create List                 EIL                         Commercial General Liability                            Contractors Pollution Liability     Professional Liability           Excess               Trucking    PD    PD(Surplus)    GL    Motor Cargo
    FOR                         ${index}                    IN RANGE                    10
        Log                     ${index}                    # 0-9
        ${rownum}=              Evaluate                    ${index}+1

        #Log To Console         ${list}[${index}]

        ${text}=                GetAttribute                (//div[text()\='Coverage Product']/parent::div//li/div)[${rownum}]                  data-value
        Log To Console          ${text}
        IF                      "${list}[${index}]"=="${text}"
            Log To Console      Success
        ELSE
            FAIL
        END
    END