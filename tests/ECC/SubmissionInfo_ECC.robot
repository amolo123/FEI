*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_InsuredInfo.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_SubmissionInit.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_SubmissionInfo.robot
Resource                        ../../PageObjects/ECC/PageObjects_ECC_Compare&RateQuote.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot

Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  CloseAllBrowsers

*** Test Cases ***

Verify the field on Submission Info for ECC 
    # Author = Vighanesh Surve
    #TC=
    [Documentation]             field on Submission_Info for ECC
    [Tags]                      Smoke_Test_ECC              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for ECC
    #Validate Submission Init on Submission info page for ECC
    Select broker Contact Source
    ClickText                   Next                        anchor=Cancel
    VerifyText                  Submission Name
    Validate Submission Info Elements for ECC
    RefreshPage
    Validate Save Info Elements for ECC
    Go Back To Insured Info and come back to submission Info
    Change Underwriter and CSR
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    Add Coverage Products       Commercial General Liability
    Add Coverage Products       Contractors Pollution Liability
    Add Coverage Products       Excess
    ${Target_Premium}=          FakerLibrary.Random Number
    TypeText                    Target Premium              ${Target_Premium}
    Save On Submission Info
    Click Next To Underwriter Analysis
    VerifyText                  Total Premium Basis         timeout=15s
    LogScreenshot
    Logout

Verify Decline and Reopen on Submission Info
    # Author = Vighanesh Surve
    #TC= 97268,97270
    [Documentation]             Decline Button on Submission_Info for ECC
    [Tags]                      Smoke_Test_ECC              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for ECC
    #Validate Submission Init on Submission info page for ECC
    Select broker Contact Source
    Sleep                       10s
    VerifyText                  Submission Name
    Change Underwriter and CSR
    Validate Save Info Elements for ECC
    Verify Decline and Reopen
    Sleep                       10s
    Verify Close and Reopen
    Logout

Verify the functionality of Create a submission only with PL coverage on Submission Info tab 
    # Author = Vighanesh Surve
    #TC=97271
    [Documentation]             Close Button on Submission_Info for ECC
    [Tags]                      Smoke_Test_ECC              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for ECC
    #Validate Submission Init on Submission info page for ECC
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
    Logout

Verify the functionality of Previous: Insured Info Button on Submission Info tab & Next: Underwriter Analysis Button 
    # Author = Akshay Verma
    #TC= 97765,97766
    [Documentation]             Previous: Insured Info Button & Next: Underwriter Analysis Button
    [Tags]                      Smoke_Test_ECC              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for ECC
    #Validate Submission Init on Submission info page for ECC
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

Verify the functionality of PL Form Type on Submission Info tab 
    # Author = Akshay Verma
    #TC= 97767
    [Documentation]             Create submission for PL_Form_Type
    [Tags]                      Smoke_Test_ECC              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for ECC
    #Validate Submission Init on Submission info page for ECC
    Select broker Contact Source
    Sleep                       10s
    VerifyText                  Submission Name
    Change Underwriter and CSR
    Add Coverage Products       Professional Liability
    Add Coverage Products       Professional Liability
    ClickText                   Save                        anchor=Submission Header
    VerifyText                  Success                     anchor=Update records successfully!
    Logout

Verify the functionality of Loss Detail 
    #Author = Akshay Verma
    #TC=97769
    [Documentation]             Verify the functionality of Loss Detail
    [Tags]                      Smoke_Test_ECC              Smoke_Test
    Creating a new Account
    Enter data on Insured info Page for ECC
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
    Logout