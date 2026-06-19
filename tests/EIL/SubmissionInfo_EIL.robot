*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_Compare&RateQuote.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot


Resource                        ../../PageObjects/Freberg_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify the field on Submission Info for EIL
    # Author = Vighanesh Surve
    #TC=
    [Documentation]             field on Submission_Info for EIL
    [Tags]                      Smoke_Test_EIL              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for EIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Validate Submission Info Elements for EIL
    Validate Save Info Elements for EIL
    ClickText                   NEXT:Underwriter Analysis >
    VerifyText                  Retroactive Date            timeout=10s
    Logout

Verify Decline and Reopen button on Submission Info
    # Author = Vighanesh Surve
    #TC=
    [Documentation]             Save Button on Submission_Info for EIL
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    #Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    Validate Save Info Elements for EIL
    Verify Decline and Reopen
    Sleep                       10s
    Verify Close and Reopen
    Logout
    
Verify the functionality of Create a submission only with EIL & CGL coverage on Submission Info tab 
    # Author = Akshay Verma
    #TC=97973
    [Documentation]             Create a submission only with EIL & CGL coverage
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    #Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    VerifyText                  Submission Name
    Add Coverage Products       Commercial General Liability
    Select Application Type
    Save On Submission Info
    Logout

Verify the functionality of Create a submission only with EIL, CGL & CPL coverage on Submission Info tab 
    # Author = Akshay Verma
    #TC=97974
    [Documentation]             Create a submission only with EIL, CGL & CPL coverage
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    #Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    VerifyText                  Submission Name
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Select Application Type
    Save On Submission Info
    Logout

Verify the functionality of Create a submission only with EIL ,CGL,CPL & PL coverage on Submission Info tab 
    # Author = Akshay Verma
    #TC=97975
    [Documentation]             Create a submission only with EIL, CGL , CPL & PL coverage
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    #Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    VerifyText                  Submission Name
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Professional Liability
    Select Application Type
    Save On Submission Info
    Logout

Verify the functionality of Create a submission only with EIL,CGL,CPL,PL & Excess coverage on Submission Info tab 
    # Author = Akshay Verma
    #TC=97976
    [Documentation]             Create a submission only with EIL, CGL , CPL , PL ,PL & Excess coverage
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    #Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    VerifyText                  Submission Name
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Excess
    Select Application Type
    Save On Submission Info
    Logout

Verify the functionality of PL Form Type on Submission Info tab 
    # Author = Akshay Verma
    #TC=97979
    [Documentation]             Create a submission only with EIL & PL coverage
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    #Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    VerifyText                  Submission Name
    Add Coverage Products       Professional Liability
    Select Application Type
    Save On Submission Info
    Logout

Verify the functionality of Previous: Insured Info Button on Submission Info tab & Next: Underwriter Analysis Button 
    # Author = Akshay Verma
    #TC= 97977,97978
    [Documentation]             Previous: Insured Info Button & Next: Underwriter Analysis Button
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    #Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    Sleep                       10s
    VerifyText                  Submission Name
    Change Underwriter and CSR
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    ClickText                   Save                        anchor=Submission Header
    VerifyText                  Success                     anchor=Update records successfully!
    Edit after save
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    ClickText                   Save                        anchor=Submission Header
    VerifyText                  Success                     anchor=Update records successfully!
    ClickText                   PREVIOUS:Insured Info       anchor=Submission Header
    ClickText                   NEXT:Submission Info        anchor=Insured Info
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Logout

Verify the functionality of Loss Detail 
    # Author = Akshay Verma
    #TC=97980
    [Documentation]             Previous: Insured Info Button & Next: Underwriter Analysis Button
    [Tags]                      Smoke_Test_EIL              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for EIL
    #Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    VerifyText                  Submission Name
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Save On Submission Info
    Go Back To Insured Info and come back to submission Info
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    Select Application Type
    Save On Submission Info
    ClickElement                //button[text()\='New']
    Validating Picklist Value for CoverageProduct
    Click on Loss Detail        Testing Data                2                           Open    Commercial General Liability         1M      2023
    ClickText                   Save
    VerifyText                  Success