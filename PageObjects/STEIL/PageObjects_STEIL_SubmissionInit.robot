*** Settings ***
Library                      QWeb
Library                      QForce
Library                      FakerLibrary
Library                      String
Library                      BuiltIn
Library                      DateTime
Resource                     ../../resources/common.robot
Resource                     ../ECC/PageObjects_ECC_InsuredInfo.robot

*** Keywords ***

Validate Submission Init on Submission info page for STEIL
    #Author=Amol Gaymukhe

    VerifyText               Select Account and Product
    VerifyText               Account Name
    VerifyInputValue         Account Name                ${uniqueName}
    VerifyText               *Product
    VerifyText               STEIL
    VerifyText               Broker Contact

    VerifyPicklist           *Relationship Type          --None--
    VerifyPicklist           *Relationship Type          Broker
    VerifyPicklist           *Relationship Type          Sub-Producer

    VerifyText               Primary Broker?
    #VerifyCheckboxStatus    Checked                     disabled                    anchor= Primary Broker?

    VerifyText               Underwriter
    VerifyText               Received Date
    #validation Pending
    VerifyText               Effective Date
    #validation Pending
    VerifyText               Expiration Date
    #validation Pending
    VerifyText               Submission Init Form

    Log To Console           ----- Submission Init Values Validated Successfully -----

Verify Date 
    #Author=Amol Gaymukhe
    [Documentation]          Used to select the Broker on the Submission Init Form
    Sleep                    5s
    UseModal                 On

    ${received_date}=        GetInputValue               //input[@name\='Received_Date__c']
    ${rdate}=                Remove String               ${received_date}            ,
    Log To Console           ${rdate}



    ${effective_date}=       GetInputValue               //input[@name\='Effective_Date__c']

    ${expiration_Date}=      GetInputValue               //input[@name\='Expiration_Date__c']

    Log To Console           ${received_date}            ${effective_date}           ${expiration_Date}

    ${cur_data}=             Get Current Date            increment=-1 day            result_format=%b %-d, %Y
    Log To Console           ${cur_data}

    Log To Console           ----- Dates On Submission Init Forms Validated Successfully -----












