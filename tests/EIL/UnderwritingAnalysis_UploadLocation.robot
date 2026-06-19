*** Settings ***
Resource                        ../../resources/common.robot
Resource                        ../../PageObjects/PageObjects_Account.robot
Resource                        ../../PageObjects/PageObjects_HomePage.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInfo.robot
Resource                        ../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot

Resource                        ../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot
Resource                        ../../resources/Upload_CSV_file.robot
Resource                        ../../PageObjects/PageObject_Compare&Rate_Common.robot


Library                         RetryFailed                 global_retries=${retry_count}
Suite Setup                     Setup Browser
Suite Teardown                  QWeb.CloseAllBrowsers


*** Test Cases ***

Verify the Edit location,add base premium and export_import loaction on Underwriter Ananysis for EIL
    # Author = Amol Gaymukhe
    #TC=97984
    [Documentation]             Edit location,add base premium and export_import loaction on Underwriter Ananysis for EIL
    [Tags]                      Smoke_Test_EIL              Smoke_Test

    Creating a new Account
    Enter data on Insured info Page for EIL
    Validate Submission Init on Submission info page for EIL
    Select broker Contact Source
    Sleep                       10s
    Change Underwriter and CSR
    VerifyText                  Submission Name
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Sleep                       5s
    VerifyText                  EIL Retro Date
    ClickText                   Submission Info
    sleep                       5s
    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header
    Sleep                       10s
    
    ScrollText                  Locations and Assets        timeout=2s

    Add Industry Classifications                            search_for_classifications=Truss                        search_by_industry=Manufacturing

    Edit Record In EIL Asset Locations                      Location 1

    PickList                    Select EIL Classification                               321214 - Truss Manufacturing
    PickList                    Basic Premiums              USD 5,000.00

    ClickText                   Save                        anchor=Cancel
    UseModal                    Off
    VerifyText                  The EIL Asset Location is updated

    Add Industry Classifications                            search_for_classifications=Wood Window and Door         search_by_industry=Manufacturing

    New EIL Asset Location      location_name=Location Two                              address=2300 Ahtanum Rd, Yakima, WA 98903, USA          EIL_classification=321911 - Wood Window and Door Manufacturing    basic_premiums=USD 6,000.00
    ClickText                   Export File
    SwitchWindow                2

    ClickText                   More Actions
    ClickText                   Export
    UseModal                    On
    ClickText                   Details OnlyExport only the detail rows. Use this to do further calculations or for uploading to other systems.

    DropDown                    Format                      Comma Delimited .csv        timeout=2s
    QWeb.ClickText              Export                      partial_match=False
    UseModal                    Off

    #CloseWindow
    SwitchWindow                1

    ClickText                   Upload File
    VerifyText                  Upload Files
    ClickText                   Upload Files

    Upload CSV file             test.csv
    Sleep                       10s
    UseModal                    On
    VerifyText                  Upload Files
    Log To Console              Clicking on Done
    ClickText                   Done                        timeout=120s
    Log To Console              Click Done Sucessfull
    #ClickElement               //*[text()\='Done']
    VerifyText                  File Uploaded Successfully
    ClickText                   Ok                          timeout=120s
    UseModal                    Off
    #Logout