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
Resource               ../../PageObjects/Trucking/PageObjects_Trucking_SubmissionConsole.robot
Resource               ../../PageObjects/Trucking/PageObjects_Trucking_UnderwrittingConsole.robot
Resource               ../../PageObjects/Trucking/PageObjects_Trucking_QuoteConsole.robot
Resource               ../../resources/ReadPDF.robot

Resource               ../../PageObjects/PageObjects_PolicyPage.robot




*** Keywords ***
Read Doc Quote Letter Primary Static Document Trucking
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Quote Letter
    [Tags]             smoke                       regression
    Log To Console     ${read_doc}
    Should Contain     ${read_doc}                 THIS QUOTE is valid through
    Should Contain     ${read_doc}                 To:
    Should Contain     ${read_doc}                 Attention:
    Should Contain     ${read_doc}                 Applicant:
    Should Contain     ${read_doc}                 Quote Ref:
    Should Contain     ${read_doc}                 STANDARD TERMS AND CONDITIONS OF THIS QUOTATION:
    Should Contain     ${read_doc}                 CARRIER:
    Should Contain     ${read_doc}                 Coverage Name
    Should Contain     ${read_doc}                 Limits and Exposures
    Should Contain     ${read_doc}                 Symbol
    Should Contain     ${read_doc}                 Premiums
    Should Contain     ${read_doc}                 Commercial General Liability
    Should Contain     ${read_doc}                 Motor Truck Cargo Legal Liability and Owner’s Forms
    Should Contain     ${read_doc}                 Confidentiality Notice
    Should Contain     ${read_doc}                 Quote Conditions
    Should Contain     ${read_doc}                 BINDING INSTRUCTIONS
    Should Contain     ${read_doc}                 MVR Guidelines


Read Doc Quote Letter Primary Dynamic Document Trucking
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Quote Letter
    [Tags]             smoke                       regression
    Should Contain     ${read_doc}                 ${PDF_InsuredName}
    Should Contain     ${read_doc}                 ${br_name}
    Log To Console     ${to1}
    Should Contain     ${read_doc}                 ${re1}
    Should Contain     ${read_doc}                 Effective Date: ${from1}
    Should Contain     ${read_doc}                 Expiration Date: ${to1}
    Should Contain     ${read_doc}                 $${pri_premium}



Read Doc Quote Letter Excess Static Document Trucking
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Quote Letter
    [Tags]             smoke                       regression
    Log To Console     ${read_doc}
    Should Contain     ${read_doc}                 Freberg Environmental
    Should Contain     ${read_doc}                 To:
    Should Contain     ${read_doc}                 Attention:
    Should Contain     ${read_doc}                 Applicant:
    Should Contain     ${read_doc}                 Quote Ref:
    Should Contain     ${read_doc}                 STANDARD TERMS AND CONDITIONS OF THIS QUOTATION:
    Should Contain     ${read_doc}                 WE WILL NEED THIS COMPLETED FORM IN ORDER TO BIND THIS ACCOUNT.
    Should Contain     ${read_doc}                 Coverage Forms and Endorsements:
    Should Contain     ${read_doc}                 Service of Suit
    Should Contain     ${read_doc}                 WE ARE REQUIRED BY THE TERRORISM RISK INSURANCE ACT
    Should Contain     ${read_doc}                 PLEASE FILL OUT THE ATTACHED SELECTION OR REJECTION OF TERRORISM COVERAGE
    Should Contain     ${read_doc}                 Policyholder/Applicant’s Signature
    Should Contain     ${read_doc}                 NOTE TO PRODUCER:
    Should Contain     ${read_doc}                 BROKER NOTICE:
    Should Contain     ${read_doc}                 BINDING COVERAGE:
    Should Contain     ${read_doc}                 Surplus Lines Agency Name:


Read Doc Quote Letter Excess Dynamic Document Trucking
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Quote Letter
    [Tags]             smoke                       regression
    Should Contain     ${read_doc}                 ${PDF_InsuredName}
    Should Contain     ${read_doc}                 ${br_name}
    Log To Console      ${read_doc}  
    Should Contain     ${read_doc}                 ${re1}
    Should Contain     ${read_doc}                 ${to1}
    Should Contain     ${read_doc}                 $${exc_premium}

Read Doc Quote Letter PD(Surplus) Static Document Trucking
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Quote Letter
    [Tags]             smoke                       regression
    Should Contain     ${read_doc}                 THIS QUOTE is valid through
    Should Contain     ${read_doc}                 To:
    Should Contain     ${read_doc}                 Attention:
    Should Contain     ${read_doc}                 Applicant:
    Should Contain     ${read_doc}                 Quote Ref:
    Should Contain     ${read_doc}                 STANDARD TERMS AND CONDITIONS OF THIS QUOTATION:
    Should Contain     ${read_doc}                 CARRIER:
    Should Contain     ${read_doc}                 Coverage Name
    Should Contain     ${read_doc}                 Limits and Exposures
    Should Contain     ${read_doc}                 Symbol
    Should Contain     ${read_doc}                 Premium
    Should Contain     ${read_doc}                 Trucker/Motor Carrier Special Endorsements to be attached:
    Should Contain     ${read_doc}                 Confidentiality Notice
    Should Contain     ${read_doc}                 Freberg Environmental
    Should Contain     ${read_doc}                 Quote Conditions
    Should Contain     ${read_doc}                 BROKER NOTICE:
    Should Contain     ${read_doc}                 BINDING COVERAGE:
    Should Contain     ${read_doc}                 Surplus Lines Agency Name:
    Should Contain     ${read_doc}                 MVR Guidelines


Read Doc Quote Letter PD(Surplus) Dynamic Document Trucking
    #Author=Amol Gaymukhe
    [Documentation]    Read Static data of Quote Letter
    [Tags]             smoke                       regression
    Should Contain     ${read_doc}                 ${PDF_InsuredName}
    Should Contain     ${read_doc}                 ${br_name}
    Log To Console     ${to1}
    Should Contain     ${read_doc}                 ${re1}
    Should Contain     ${read_doc}                 ${from1}
    Should Contain     ${read_doc}                 ${to1}
    Should Contain     ${read_doc}                 $${pd_premium}
