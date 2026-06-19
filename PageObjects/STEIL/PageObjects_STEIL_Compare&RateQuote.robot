*** Settings ***
Library                 QWeb
Library                 QForce
Library                 FakerLibrary
Library                 String
Library                 BuiltIn
Library                 DateTime
Resource                ../../resources/common.robot
Resource                PageObjects_STEIL_InsuredInfo.robot
Resource                ../Freberg_Common.robot
Library                 ../../libraries/MailLib.py                              ${tenant_id}             ${client_id_mail}        ${client_secret_mail}

Library                 ${CURDIR}/../../libraries/graph.py
Resource                ${CURDIR}/../../resources/graph.resource


*** Variables ***


*** Keywords ***

Verify Fields On Compare and Rate quote
    #Author=Amol Gaymukhe
    [Documentation]     VerifyFields on Compare and Rate Quote
    VerifyText          Quote Data
    VerifyText          Effective Date
    VerifyText          Attachment Point
    VerifyText          Expiration Date
    VerifyText          Approval Status
    VerifyText          Default Primary Commission %
    VerifyText          Primary Commission %
    VerifyText          Primary Commission
    VerifyText          Default Excess Commission %
    VerifyText          Excess_Commission %
    VerifyText          Excess Commission
    VerifyText          Minimum Earned Premium
    VerifyText          Limits and Deductibles
    VerifyText          TRIA selection

    VerifyText          Credit/Debit Information
    VerifyText          Qualifications ( - )
    VerifyText          Loss Experience ( - )
    VerifyText          Other ( - )
    VerifyText          Financial Status ( - )
    VerifyText          Pricing
    VerifyText          Primary Technical Premium
    VerifyText          Primary Quote Premium
    VerifyText          Primary Look Ahead Premium
    VerifyText          Primary Policy Fees
    VerifyText          Primary Loss Control Fees
    VerifyText          Primary State Fees
    VerifyText          Primary Total Price
    VerifyText          Clearing house Fee
    VerifyText          Tria Premium
    VerifyText          Excess Credit/Debit Information
    VerifyText          Excess Pricing
    VerifyText          Excess Quote Premium
    VerifyText          Excess Look Ahead Premium
    VerifyText          Excess Policy Fees
    VerifyText          Excess State Fees
    VerifyText          Excess Total Price
    VerifyText          Excess Clearinghouse Fees
    VerifyText          Excess Technical Premium
    VerifyText          Excess Tria Premium
    VerifyText          STEIL Limits
    VerifyText          STEIL Deductible
    VerifyText          Defense Limit




Select All Categories
    #Author=Amol Gaymukhe
    [Documentation]     Select All Categories


    UseModal            On
    ClickText           Or Select a Category
    ClickText           Frequently Used

    ClickText           Or Select a Category
    ClickText           Other

    ClickText           Or Select a Category
    ClickText           Exclusions

    ClickText           Or Select a Category
    ClickText           State

    ClickText           Or Select a Category
    ClickText           Additional Premium

    ClickText           Or Select a Category
    ClickText           CGL - ISO

    ClickText           Or Select a Category
    ClickText           Mandatory

    ClickText           Or Select a Category
    ClickText           Excess                      anchor=Mandatory

    ClickText           Or Select a Category
    ClickText           State Specific



Verify All Endorsements

    #Author=Amol Gaymukhe
    [Documentation]     Check the Endorsements For ECC
    [Arguments]         ${type_EN}


    #ClickElement       //lightning-icon[@title\='Endorsements']
    Import Variables    ${CURDIR}/endorsements.py                               ${type_EN}
    Log To Console      ${CURDIR}

    FOR                 ${index}                    IN RANGE                    ${amountEndorsements}
        Log             ${index}                    # 0-9
        ${rownum}=      Evaluate                    ${index}+1

        Log To Console                              ${list}[${index}]
        UseTable        Endorsement Category
        ${text}=        GetCellText                 r${rownum}c2
        Log To Console                              ${text}
        IF              "${list}[${index}]"=="${text}"
            Log To Console                          Success
        ELSE
            FAIL
        END
    END


Verify already added Endorsements for STEIL

    [Documentation]     Verify already added Endorsements for ECC

    VerifyText          PN-0001 00107
    VerifyText          OFAC

    VerifyText          PN-0002-1215
    VerifyText          Trade or Economic Sanctions Endorsement

    Verifytext          ECC-326-0621
    VerifyText          Service of Suit

    VerifyText          UST-022-1019
    VerifyText          Minimum Earned Premium Endorsement

    Verifytext          UST-029-0120
    VerifyText          No Coverage for Electronic Data

    VerifyText          UST-039-0219
    VerifyText          Financial Assurance Amendatory Endorsement

    VerifyText          UST-322-0821
    VerifyText          Claims Notice Document


Verify Default Endorsements for STEIL

    #Author=Amol Gaymukhe
    [Documentation]     Verify Default Endorsements
    [Arguments]         ${type_EN}


    #ClickElement       //lightning-icon[@title\='Endorsements']
    Import Variables    ${CURDIR}/endorsements.py                               ${type_EN}
    Log To Console      ${CURDIR}

    FOR                 ${index}                    IN RANGE                    ${amountEndorsements}
        Log             ${index}                    # 0-9
        ${rownum}=      Evaluate                    ${index}+1

        Log To Console                              ${list}[${index}]
        UseTable        Additional Premium
        ${text}=        GetCellText                 r${rownum}c3
        Log To Console                              ${text}
        IF              "${list}[${index}]"=="${text}"
            Log To Console                          Success
        ELSE
            FAIL
        END
    END
    Log To Console      ----- All Endorsements validated Successfully ------

Verify Quote option is required to finalize
    #Author=Amol Gaymukhe
    [Documentation]     Enter Retroactive Date
    Log To Console      Verify Quote option is required to finalize
    # ClickElement      //lightning-icon[@title\='Finalize Quote']
    # VerifyText        Error                       anchor=Quote Option is required to finalize          timeout=60s


Select Endorsement on Amendment ECC-557-0712
    #Author=Amol Gaymukhe
    [Documentation]     Selecting Endorsements on Amendments

    ClickElement        (//lightning-icon[@title\='Endorsements & Subjectivities'])[last()]
    UseModal            On
    ClickElement        //input[@name\='enter-search']
    TypeText            //input[@name\='enter-search']                          ECC-557-0712
    PressKey            //input[@name\='enter-search']                          {ENTER}

    ClickElement        //span[text()\='Select Item 1']
    ClickElement        //button[@title\='Add']
    VerifyText          Success                     anchor=The data is saved successfully
    UseTable            S.No.
    ${rno}=             GetTableRow                 //last
    Log To Console      ${rno}
    ${exactrow}=        Evaluate                    ${rno}-5
    Log To Console      ${exactrow}

    TypeText            (//input[@name\='additionalPremium'])[${exactrow}]      2000
    ClickText           Save                        anchor=Return Quote Process
    VerifyText          Success                     anchor=The data is saved successfully                timeout=60s
    ClickText           Return Quote Process
    Log To Console      ----- Endorsements selected successful------


Select Endorsements after Amendment and Additional Premium with arg
    #Author=Amol Gaymukhe
    [Documentation]     Selecting Endorsements
    [Arguments]         ${Endorsement_Name}
    ClickElement        (//lightning-icon[@title\='Endorsements & Subjectivities'])[last()]
    UseModal            On
    TypeText            //input[@name\='enter-search']                          ${Endorsement_Name}
    PressKey            //input[@name\='enter-search']                          {Enter}
    ClickElement        //span[text()\='Select Item 1']
    ClickElement        //button[@title\='Add']
    VerifyText          Success                     anchor=The data is saved successfully
    UseTable            S.No.
    ${rno}=             GetTableRow                 ${Endorsement_Name}
    ${exactrow}=        Evaluate                    ${rno}-1
    Log To Console      ${exactrow}

    TypeText            (//input[@name\='additionalPremium'])[${exactrow}]      2000
    ClickText           Save                        anchor=Return Quote Process
    ClickText           Return Quote Process
    Log To Console      ----- Endorsements selected successful------



