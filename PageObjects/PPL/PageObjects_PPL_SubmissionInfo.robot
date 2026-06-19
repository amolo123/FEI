*** Settings ***
Library                         QWeb
Library                         QForce
Library                         FakerLibrary
Library                         String
Library                         BuiltIn
Library                         DateTime
Resource                        ../../resources/common.robot
Resource                        ../Freberg_Common.robot

*** Variables ***


*** Keywords ***
Validate Submission Info Elements for PPL
    #Author=Vighanesh surve

    VerifyText                  Underwriter
    VerifyText                  CSR
    VerifyText                  Account Name
    VerifyText                  Type
    VerifyText                  Primary Policy
    VerifyText                  Exces Policy
    #Validating Picklist Value
    Verify Workflow reason list

    VerifyText                  Writing Company

    #Validating Picklist Value
    VerifyPickList              PL Form Type
    ${PL_Form_Type}=            GetPicklist                 PL Form Type
    Log To Console              ${PL_Form_Type}
    @{PL_Form_Type_List}=       Create List                 New Forms                   Old Forms
    Log To Console              ${PL_Form_Type_List}
    Lists Should Be Equal       ${PL_Form_Type_List}        ${PL_Form_Type}             ignore_order=true

    #Validating Picklist Value
    VerifyPickList              *Stage
    ${Stage}=                   GetPicklist                 *Stage
    Log To Console              ${Stage}
    @{Stage_List}=              Create List                 --None--                    New                         Prospect                    Qualified                   Unqualified               Declined    Closed Won     Closed Lost                 Eligibility Approved    Renewal
    Log To Console              ${Stage_List}
    Lists Should Be Equal       ${Stage_List}               ${Stage}                    ignore_order=true

    VerifyText                  Carrier Commission %
    #VerifyText                 28
    VerifyText                  Product

    #Validated Close reason list
    Verify Close reason list

    VerifyText                  Decline Comment
    ${Decline_Comment}=         FakerLibrary.Text
    TypeText                    Decline Comment             ${Decline_Comment}
    VerifyText                  Coverage Product
    VerifyText                  Available
    VerifyText                  Application Type
    VerifyText                  Current Carrier

    VerifyText                  Charge CO SL Tax
    VerifyCheckbox              Charge CO SL Tax
    #VerifyCheckboxStatus       unchecked                   enabled
    # Sleep                     2s
    # ClickCheckbox             Charge CO SL Tax            on
    # Sleep                     2s
    # ClickCheckbox             Charge CO SL Tax            off

    VerifyText                  Enquiron?
    # ClickCheckbox             Enquiron?                   on
    # Sleep                     2s
    # ClickCheckbox             Enquiron?                   off
    VerifyText                  Premium Data
    VerifyText                  Key Dates
    VerifyText                  Premium Data
    VerifyText                  Target Premium
    ${Target_Premium}=          FakerLibrary.Random Number
    TypeText                    Target Premium              ${Target_Premium}
    VerifyText                  Indicated Premium
    ${Indicated_Premium}=       FakerLibrary.Random Number
    TypeText                    Indicated Premium           ${Indicated_Premium}
    VerifyText                  Total Bound Premium
    ${Total_Bound_Premium}=     FakerLibrary.Random Int
    TypeText                    Total Bound Premium         ${Total_Bound_Premium}
    VerifyText                  Expiring Premium
    ${Expiring_Premium}=        FakerLibrary.Random Int
    TypeText                    Expiring Premium            ${Expiring_Premium}
    Verifytext                  Loss Detail
    VerifyText                  Broker Account
    UseModal                    On
    VerifyText                  Key Dates
    VerifyText                  Effective Date
    VerifyText                  Received Date
    VerifyText                  Expiration Date
    VerifyText                  Close Date
    VerifyText                  Quote Due Date

    #Verify Dates
    ${received_date}=           GetInputValue               //input[@name\='Received_Date__c']

    ${pdf_dateofproposal}=      Set Variable                ${received_date}
    Set Global Variable         ${pdf_dateofproposal}

    ${effective_date}=          GetInputValue               //input[@name\='Effective_Date__c']

    ${expiration_Date}=         GetInputValue               //input[@name\='Expiration_Date__c']


    ${cur_data}=                Get Current Date            result_format=%b %-d, %Y
    ${comp_effective_date}=     Get Current Date            increment=5 day             result_format=%b %-d, %Y
    ${comp_xpiration_Date}=     Get Current Date            increment=1827 day          result_format=%b %-d, %Y


    IF                          "${received_date}"== "${cur_data}" and "${effective_date}"=="${comp_effective_date}" and "${effective_date}"=="${comp_effective_date}"
        Log To Console          Success
    ELSE
        Fail
    END
    Log To Console              ----- Received date, Efective data, Expiration date     Validated Successfully -----

    #Verify Broker
    UseTable                    Broker Name
    ${Broker_name}=             GetCellText                 r2/c?Broker Name
    ${primary_broker}=          GetCellText                 r2/c?Primary Broker?
    ${relationship_type}=       GetCellText                 r2/c?Relationship Type
    ${BrokerEmail}=             GetCellText                 r2/c?Broker Email
    ${Agency}=                  GetCellText                 r2/c?Agency
    ${Broker_City}=             GetCellText                 r2/c?Broker City
    ${Broker_state}=            GetCellText                 r2/c?Broker State

    Log To Console              ${primary_broker}           ${Broker_name}              ${relationship_type}
    Log To Console              ${Agency}                   ${Broker_City}              ${Broker_state}
    Log To Console              ${BrokerEmail}
    ${pdf_brokername}=          Set Variable                ${Broker_name}
    Set Global Variable         ${pdf_brokername}

    IF                          "${Broker_name}"=="${EMPTY}" and "${primary_broker}"=="${EMPTY}" and "${relationship_type}"=="${EMPTY}"
        Fail
    ELSE
        Log To Console          Success
    END
    Log To Console              ----- Broker date, Primary Broker, Relationship Type    Validated Successfully -----

    # Verify coverage product

    Verify Selected Coverage Product                        EIL
    Verify Selected Coverage Product                        PremOps GL


Validate Save Info Elements for PPL
    #Author=Vighanesh surve
    Verify Selected Coverage Product                        EIL
    Verify Selected Coverage Product                        PremOps GL

    ClickText                   Save                        anchor=Submission Header
    VerifyText                  Success                     anchor=Update records successfully!


Click Edit Button on Submission Info

    ClickElement                //span[text()\='Edit']

Validate NEXT Underwriter Analysis Info Elements for PPL
    [Documentation]             Clicking on Underwriter Analysis
    [Tags]                      Regression
    ScrollTo                    Coverage Product
    Add Coverage Products       PremOps GL
    Log To Console              ----Coverage products are selected---

    #Add value

    ${Target_Premium}=          FakerLibrary.Random Number
    TypeText                    Target Premium              ${Target_Premium}

    Log To Console              ----Sleep before save---
    ClickText                   Save                        anchor=Submission Header
    VerifyText                  Success                     anchor=Update records successfully!                     timeout=10s

    ClickText                   NEXT:Underwriter Analysis >                             anchor=Submission Header

    Log To Console              ----NEXT:Underwriter Analysis > Clicked---


Select Application Type
    [Documentation]             Selection of Document Type

    PickList                    Application Type            FEI New Business Application

Save On Submission Info
    [Documentation]             Clicking Save On Underwriter Analysis
    [Tags]                      Regression
    ClickText                   Save                        anchor=Submission Header
    VerifyText                  Success                     anchor=Update records successfully!

Go Back To Insured Info and come back to submission Info
    [Documentation]             Clicking Save On Underwriter Analysis
    [Tags]                      Regression
    ClickText                   < PREVIOUS:Insured Info     anchor=Submission Header
    ClickText                   NEXT:Submission Info >      anchor=Notes                timeout=5sec

Validating Picklist Value for CoverageProduct
    VerifyPickList              Coverage Product
    ${Coverage_Product}=        GetPicklist                 Coverage Product
    Log To Console              ${Coverage_Product}
    @{Coverage_Product_List}=                               Create List                 --None--                    EIL                         Commercial General Liability                          Contractors Pollution Liability                        Professional Liability             Excess      LawyerGuard          Lawyer Professional Liability           PremOps GL    STEIL         Trucking            PD     PD(Surplus)       GL                        Motor Cargo              Trucking Excess          OCP       RRP         PPL                         D&O          EPL               Fiduciary            MPL           Crime                 Cyber    Professional Indemnity    Private Company Combo    Expired    PCC Excess    MPL v2    Cyber v2    Private Company Combo v2    Excess v2    LawyerGuard_SL    Celerity_PublicDO    PDO Excess    Unsupported Excess
    Log To Console              ${Coverage_Product_List}
    Lists Should Be Equal       ${Coverage_Product_List}    ${Coverage_Product}         ignore_order=true