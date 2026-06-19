*** Settings ***
Library                QWeb
Library                QForce
#Library               QVision
Library                FakerLibrary
Library                String
Library                BuiltIn
Library                DateTime

Resource               ../../resources/common.robot
Resource               ../../PageObjects/PageObjects_Account.robot
Resource               ../../PageObjects/PageObjects_HomePage.robot
Resource               ../../PageObjects/EIL/PageObjects_EIL_InsuredInfo.robot
Resource               ../../PageObjects/EIL/PageObjects_EIL_SubmissionInit.robot
Resource               ../../PageObjects/EIL/PageObjects_EIL_SubmissionInfo.robot

Resource               ../../PageObjects/EIL/PageObjects_EIL_UnderwritingAnalysis.robot
Resource               ../../PageObjects/EIL/PageObjects_EIL_Compare&RateQuote.robot
Resource               ../../resources/ReadPDF.robot
Resource               ../../PageObjects/PageObjects_PolicyPage.robot


*** Keywords ***
Read Doc Quote Letter Static Document EIL
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Quote Letter
    [Tags]             smoke                       regression
    #Log To Console    ${read_doc}
    Should Contain     ${read_doc}                 Quote prepared
    Should Contain     ${read_doc}                 Schedule of Forms and Endorsements
    Should Contain     ${read_doc}                 If Declining TRIA Coverage:
    Should Contain     ${read_doc}                 If Accepting TRIA Coverage:
    Should Contain     ${read_doc}                 Broker Resources
    Should Contain     ${read_doc}                 By: Authorized Representative
    Should Contain     ${read_doc}                 Bind Request Form
    Should Contain     ${read_doc}                 Surplus Lines Tax Filing


Read Doc Quote Letter Dynamic Document EIL 
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Quote Letter
    [Tags]             smoke                       regression
    Should Contain     ${read_doc}                 ${PDF_InsuredName}
    Should Contain     ${read_doc}                 ${br_name}
    Should Contain     ${read_doc}                 ${PDF_ValidUntil}  
    Should Contain     ${read_doc}                 ${from2}
    ${var}=            Set Variable                $
    ${final_var}=      Set Variable                ${var}${PDF_Premium}
    Should Contain     ${read_doc}                 ${final_var}
    Log To Console     ${read_doc}



Read Policy Letter Static Document EIL
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Policy Letter
    [Tags]             smoke
    Should Contain     ${read_doc}                 Policy Number
    Should Contain     ${read_doc}                 Carrier
    Should Contain     ${read_doc}                 Coverages
    Should Contain     ${read_doc}                 Named Insured
    Should Contain     ${read_doc}                 Policy Period
    Should Contain     ${read_doc}                 Program Administrator
    Should Contain     ${read_doc}                 Date Issued
    Should Contain     ${read_doc}                 Common Policy Declarations
    Should Contain     ${read_doc}                 Additional Charges
    Should Contain     ${read_doc}                 By: Authorized Representative
    Should Contain     ${read_doc}                 Coverage Part Declarations
    Should Contain     ${read_doc}                 Schedule of Forms and Endorsements



Read Policy Letter Dynamic Document EIL
    #Author=Amol Gaymukhe
    [Documentation]    Read Dynamic data of Policy Letter
    [Tags]             smoke                       regression
    Should Contain     ${read_doc}                 ${PDF_InsuredName}
    Should Contain     ${read_doc}                 ${PolicyNo}
    ${var}=            Set Variable                $
    ${final_var}=      Set Variable                ${var}${PDF_Premium}
    Should Contain     ${read_doc}                 ${final_var}
    Should Contain     ${read_doc}                 ${from2}
    Should Contain     ${read_doc}                 ${to2}

Read Binder Letter Static Document EIL
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Policy Letter
    [Tags]             smoke
    Log To Console     ${read_doc}
    Should Contain     ${read_doc}                 Binding Acknowledgement
    #Should Contain    ${read_doc}                 Outstanding Subjectivities
    Should Contain     ${read_doc}                 Limits of Insurance
    Should Contain     ${read_doc}                 Deductibles
    Should Contain     ${read_doc}                 Retroactive Date(s)
    Should Contain     ${read_doc}                 Pricing
    Should Contain     ${read_doc}                 Schedule of Forms and Endorsements
    Should Contain     ${read_doc}                 By: Authorized Representative



Read Binder Letter Dynamic Document EIL
    #Author=Amol Gaymukhe
    [Documentation]    Read Dynamic data of Policy Letter
    [Tags]             smoke                       regression
    ${todays_date}=    Get Current Date
    Should Contain     ${read_doc}                 ${PDF_InsuredName}
    Should Contain     ${read_doc}                 ${PolicyNo}
    Should Contain     ${read_doc}                 ${br_name}
    ${var}=            Set Variable                $
    ${final_var}=      Set Variable                ${var}${PDF_Premium}
    Should Contain     ${read_doc}                 ${final_var}
    Should Contain     ${read_doc}                 ${from2}
    Should Contain     ${read_doc}                 ${to2}
