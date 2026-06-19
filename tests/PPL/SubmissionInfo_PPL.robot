*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_InsuredInfo.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_SubmissionInfo.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_SubmissionInit.robot
Resource                        ../../PageObjects/PPL/PageObjects_PPL_Compare&RateQuote.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot



Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify the field on Submission Info for PPL
    # Author = Vighanesh Surve
    #TC=
    [Documentation]             field on Submission_Info for PPL
    [Tags]                      Smoke_Test_PPL              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for PPL
    Validate Submission Init on Submission info page for PPL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Validate Submission Info Elements for PPL
    Validate Save Info Elements for PPL
    Click Edit Button on Submission Info
    Validate NEXT Underwriter Analysis Info Elements for PPL
    VerifyText                  Retroactive Date            timeout=10s
    Logout

Verify Decline and Reopen button on Submission Info
    # Author = Vighanesh Surve
    #TC=
    [Documentation]             Save Button on Submission_Info for PPL
    [Tags]                      Smoke_Test_PPL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Validate Save Info Elements for PPL
    Verify Decline and Reopen
    Sleep                       5s
    Verify Close and Reopen
    Logout

Verify the functionality of Create a submission only with EIL, Premops GL & CPL coverage on Submission Info tab 
    # Author = Akshay Verma
    #TC=98039
    [Documentation]             Create a submission only with EIL, Premops GL & CPL coverage
    [Tags]                      Smoke_Test_PPL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Add Coverage Products       Contractors Pollution Liability
    Select Application Type
    Save On Submission Info
    Logout

Verify the functionality of Create a submission only with EIL, Premops GL,CPL & PL coverage on Submission Info tab 
    # Author = Akshay Verma
    #TC=98040
    [Documentation]             Create a submission only with EIL, Premops GL,CPL & PL coverage
    [Tags]                      Smoke_Test_PPL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Professional Liability
    Select Application Type
    Save On Submission Info
    Logout

Verify the functionality of Create a submission only with EIL, Premops GL,CPL,PL & Excess coverage on Submission Info tab 
    # Author = Akshay Verma
    #TC=98041
    [Documentation]             Create a submission only with EIL, Premops GL,CPL,PL & Excess coverage
    [Tags]                      Smoke_Test_PPL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Excess
    Select Application Type
    Save On Submission Info
    Logout

Verify the functionality of PL Form Type on Submission Info tab 
    # Author = Akshay Verma
    #TC=98044
    [Documentation]             Create a submission only with EIL, Premops & PL coverage
    [Tags]                      Smoke_Test_PPL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Add Coverage Products       Professional Liability
    Select Application Type
    Save On Submission Info
    Logout

Verify the functionality of Previous: Insured Info Button on Submission Info tab & Next: Underwriter Analysis Button 
    # Author = Akshay Verma
    #TC=98042,98043
    [Documentation]             Previous: Insured Info Button & Next: Underwriter Analysis Button
    [Tags]                      Smoke_Test_PPL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Professional Liability
    ClickText                   Save                        anchor=Submission Header
    VerifyText                  Success                     anchor=Update records successfully!
    ClickText                   PREVIOUS:Insured Info       anchor=Submission Header
    ClickText                   NEXT:Submission Info        anchor=Insured Info
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Logout

Verify the functionality of Loss Detail 
    # Author = Akshay Verma
    #TC=98045
    [Documentation]             Previous: Insured Info Button & Next: Underwriter Analysis Button
    [Tags]                      Smoke_Test_PPL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for PPL
    Select broker Contact Source
    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Save On Submission Info
    Go Back To Insured Info and come back to submission Info
    Add Coverage Products       Professional Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Select Application Type
    Save On Submission Info
    ClickElement                //button[text()\='New']
    Validating Picklist Value for CoverageProduct
    Click on Loss Detail        Testing Data                2                           Open    Commercial General Liability      1M      2023
    ClickText                   Save
    VerifyText                  Success
    Logout