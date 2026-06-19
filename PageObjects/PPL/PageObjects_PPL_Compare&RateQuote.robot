*** Settings ***
Library                    QWeb
Library                    QForce
Library                    FakerLibrary
Library                    String
Library                    BuiltIn
Library                    DateTime
Resource                   ../../resources/common.robot
Resource                   ../../PageObjects/PPL/PageObjects_PPL_InsuredInfo.robot
Resource                   ../Freberg_Common.robot

Library                    ../../libraries/MailLib.py                              ${tenant_id}              ${client_id_mail}        ${client_secret_mail}

Library                    ${CURDIR}/../../libraries/graph.py
Resource                   ${CURDIR}/../../resources/graph.resource


*** Variables ***


*** Keywords ***

Select All Categories
    #Author=Amol Gaymukhe
    [Documentation]        Select All Categories


    UseModal               On
    ClickText              Or Select a Category
    ClickText              Frequently Used

    ClickText              Or Select a Category
    ClickText              Other

    ClickText              Or Select a Category
    ClickText              Exclusions

    ClickText              Or Select a Category
    ClickText              State

    ClickText              Or Select a Category
    ClickText              Additional Premium

    ClickText              Or Select a Category
    ClickText              CGL - ISO

    ClickText              Or Select a Category
    ClickText              Mandatory

    ClickText              Or Select a Category
    ClickText              Excess                      anchor=Mandatory

    ClickText              Or Select a Category
    ClickText              State Specific

    ClickText              Or Select a Category
    ClickText              EIL Endorsements



Verify All Endorsements

    #Author=Amol Gaymukhe
    [Documentation]        Check the Endorsements For ECC
    [Arguments]            ${type_EN}


    #ClickElement          //lightning-icon[@title\='Endorsements']
    Import Variables       ${CURDIR}/endorsements.py                               ${type_EN}
    Log To Console         ${CURDIR}

    FOR                    ${index}                    IN RANGE                    ${amountEndorsements}
        Log                ${index}                    # 0-9
        ${rownum}=         Evaluate                    ${index}+1

        Log To Console     ${list}[${index}]
        UseTable           Endorsement Category
        ${text}=           GetCellText                 r${rownum}c2
        Log To Console     ${text}
        IF                 "${list}[${index}]"=="${text}"
            Log To Console                             Success
        ELSE
            FAIL
        END
    END

Verify already added Endorsements for PPL

    [Documentation]        Verify already added Endorsements for ECC

    VerifyText             ECC-1315-0118
    VerifyText             Common Policy Conditions
    Verifytext             1                           anchor=ECC-1315-0118        partial_match=false

    VerifyText             ECC-1316-0118
    VerifyText             Nuclear Energy Liability Exclusion
    Verifytext             2                           anchor=ECC-1316-0118        partial_match=false

    VerifyText             ECC-317-0712
    VerifyText             Deductible Liability Insurance Endorsement
    Verifytext             3                           anchor=ECC-317-0712         partial_match=false

    VerifyText             ECC-1327-0118
    VerifyText             Minimum Earned Premium Endorsement
    Verifytext             4                           anchor=ECC-1327-0118        partial_match=false

    VerifyText             ECC-319-0712
    VerifyText             Automatic Additional Insured Owners Lessees or Contractors
    Verifytext             5                           anchor=ECC-319-0712         partial_match=false

    VerifyText             ECC-320-0712
    VerifyText             Automatic Waiver of Subrogation
    Verifytext             6                           anchor=ECC-320-0712         partial_match=false

    VerifyText             ECC-405-0712
    VerifyText             Transportation at Jobsite Endorsement
    Verifytext             7                           anchor=ECC-405-0712         partial_match=false

    VerifyText             CG 21 07 05 14
    VerifyText             Exclusion - Access or Disclosure of Data
    Verifytext             8                           anchor=CG 21 07 05 14       partial_match=false

    VerifyText             PN-0001 00107
    VerifyText             OFAC
    Verifytext             9                           anchor=PN-0001 00107        partial_match=false

    VerifyText             PN-0002-1215
    VerifyText             Trade or Economic Sanctions Endorsement
    Verifytext             10                          anchor=PN-0002-1215         partial_match=false

    VerifyText             ECC-586-0520
    VerifyText             Virus or Bacteria Exclusion - CGL
    Verifytext             11                          anchor=ECC-586-0520         partial_match=false

    VerifyText             ECC-587-0520
    VerifyText             Virus or Bacteria Exclusion - CPL
    Verifytext             12                          anchor=ECC-587-0520         partial_match=false

    VerifyText             ECC-588-0520
    VerifyText             Virus or Bacteria Exclusion - PL
    Verifytext             13                          anchor=ECC-588-0520         partial_match=false

    # VerifyText           CG 00 67 03 05
    # VerifyText           Exclusion - Violation of Statutes that Govern E-Mails, Fax, Phone Calls

    VerifyText             CG 22 43 04 13
    VerifyText             Exclusion - Engineers, Architects or Surveyors
    Verifytext             14                          anchor=CG 22 43 04 13       partial_match=false

    VerifyText             ECC-1322-0821
    VerifyText             Claims Notice Document
    Verifytext             15                          anchor=ECC-1322-0821        partial_match=false

    VerifyText             ECC-1326-0621
    VerifyText             Service of Suit
    Verifytext             16                          anchor=ECC-1326-0621        partial_match=false

    VerifyText             EXS-211-0712
    VerifyText             Common Policy Conditions Endorsement
    Verifytext             1                           anchor=EXS-211-0712         partial_match=false

    VerifyText             EXS-205-0712
    VerifyText             Nuclear Energy Liability Exclusion
    Verifytext             2                           anchor=EXS-205-0712         partial_match=false

    VerifyText             EXS-207-0117
    VerifyText             Mold and Mildew Exclusion
    Verifytext             3                           anchor=EXS-207-0117         partial_match=false

    VerifyText             EXS-327-0917
    VerifyText             Minimum Premium Endorsement
    Verifytext             4                           anchor=EXS-327-0917         partial_match=false

    VerifyText             EXS-208-0712
    VerifyText             Employment Discrimination & Employment-Related Practices Exclusion
    Verifytext             5                           anchor=EXS-208-0712         partial_match=false

    VerifyText             EXS-203-0821
    VerifyText             Claims Notice Document
    Verifytext             6                           anchor=EXS-203-0821         partial_match=false

    VerifyText             EXS-326-0621
    VerifyText             Service of Suit
    Verifytext             7                           anchor=EXS-326-0621         partial_match=false

    VerifyText             EXS-411-0822
    VerifyText             PFAS Exclusion Endorsement
    Verifytext             8                           anchor=EXS-411-0822         partial_match=false



Verify Default Endorsements for PPL

    #Author=Amol Gaymukhe
    [Documentation]        Verify Default Endorsements
    [Arguments]            ${type_EN}


    #ClickElement          //lightning-icon[@title\='Endorsements']
    Import Variables       ${CURDIR}/endorsements.py                               ${type_EN}
    Log To Console         ${CURDIR}

    FOR                    ${index}                    IN RANGE                    ${amountEndorsements}
        Log                ${index}                    # 0-9
        ${rownum}=         Evaluate                    ${index}+1

        Log To Console     ${list}[${index}]
        UseTable           Additional Premium
        ${text}=           GetCellText                 r${rownum}c3
        Log To Console     ${text}
        IF                 "${list}[${index}]"=="${text}"
            Log To Console                             Success
        ELSE
            FAIL
        END
    END
    Log To Console         ----- All Endorsements validated Successfully ------


Get Quote Letter Dynamic Document EIL
    #Author=Amol
    [Documentation]        Dynamic Document Elements and Setting as Set Global Variable
    # Broker Name
    ${br_name}=            Set Variable                Automation FEI
    # ${PDF_InsuredName}=                              Set Variable                ${uniqueName}
    # Log To Console       ${PDF_InsuredName}
    # Set Global Variable                              ${PDF_InsuredName}
    Set Global Variable    ${br_name}


    #Valid Until Date
    ${validuntil_date}=    Get Current Date            increment= 30 day           result_format=%m/%d/%Y
    Log To Console         ${validuntil_date}
    ${PDF_ValidUntil}=     Set Variable                ${validuntil_date}
    Set Global Variable    ${PDF_ValidUntil}
    #Policy Term
    ${from}=               GetInputValue               //input[contains(@name,'-Effective Date')]
    ${from1}=              Convert Date                ${from}                     date_format=%m/%d/%Y
    ${from2}=              Convert Date                ${from1}                    result_format=%m/%d/%Y
    Log To Console         ${from2}
    Set Global Variable    ${from2}

    ${to}=                 GetInputValue               //input[contains(@name,'-Expiration Date')]
    ${to1}=                Convert Date                ${to}                       date_format=%m/%d/%Y
    ${to2}=                Convert Date                ${to1}                      result_format=%m/%d/%Y
    Log To Console         ${to2}
    Set Global Variable    ${to2}
    ${PDF_PolicyTerm}=     Set Variable                ${from2} to ${to2}
    Log To Console         ${PDF_PolicyTerm}
    Set Global Variable    ${PDF_PolicyTerm}

    #Premium of the quote
    ${premium}=            GetInputValue               //input[contains(@name,'-Primary Technical Premium')]
    Log To Console         ${premium}
    ${premium2}=           Remove String               ${premium}                  $                         .00
    ${PDF_Premium}=        Set Variable                ${premium2}
    Set Global Variable    ${PDF_Premium}


# Click on Rate after on Amendment
    #Author=Akshay Verma
    # [Documentation]        Click on rate quote

    # ClickElement           (//button[text()\='Rate'])[last()]
    # #ClickText             Confirm                     anchor=Cancel
    # #VerifyText            Success                     anchor=Rating sucessfully!                            timeout=45s
    # Log To Console         ----- Rate Quote Successfully ------

Verify Fields On Compare and Rate quote
    #Author=Amol Gaymukhe
    [Documentation]        VerifyFields on Compare and Rate Quote
    VerifyText             Quote Data
    VerifyText             Effective Date
    VerifyText             Attachment Point
    VerifyText             Expiration Date
    VerifyText             Approval Status
    VerifyText             Default Primary Commission %
    VerifyText             Primary Commission %
    VerifyText             Primary Commission
    VerifyText             Default Excess Commission %
    VerifyText             Excess_Commission %
    VerifyText             Excess Commission
    VerifyText             Minimum Earned Premium
    VerifyText             Limits and Deductibles
    VerifyText             TRIA selection
    VerifyText             Increase Fire Damage Limit
    VerifyText             Increase Medical Damage Limit
    VerifyText             CPL Retroactive Date Option
    VerifyText             CPL Retroactive Date
    VerifyText             CPL Limit
    VerifyText             CPL Deductible
    VerifyText             PL Retroactive Date Option
    VerifyText             PL Retroactive Date
    VerifyText             PL Limits
    VerifyText             PL Deductible
    VerifyText             Credit/Debit Information
    VerifyText             Qualifications ( - )
    VerifyText             Loss Experience ( - )
    VerifyText             Other ( - )
    VerifyText             Financial Status ( - )
    VerifyText             Pricing
    VerifyText             Primary Technical Premium
    VerifyText             Primary Quote Premium
    VerifyText             Primary Look Ahead Premium
    VerifyText             Primary Policy Fees
    VerifyText             Primary Loss Control Fees
    VerifyText             Primary State Fees
    VerifyText             Primary Total Price
    VerifyText             Clearing house Fee
    VerifyText             Tria Premium
    VerifyText             Excess Credit/Debit Information
    VerifyText             Excess Pricing
    VerifyText             Excess Quote Premium
    VerifyText             Excess Look Ahead Premium
    VerifyText             Excess Policy Fees
    VerifyText             Excess State Fees
    VerifyText             Excess Total Price
    VerifyText             Excess Clearinghouse Fees
    VerifyText             Excess Technical Premium
    VerifyText             Excess Tria Premium
    Log To Console         ----- Compare and rate quote fields validated Successfully ------

Select Endorsements after Amendment and Additional Premium with arg
    #Author=Amol Gaymukhe
    [Documentation]        Selecting Endorsements
    [Arguments]            ${Endorsement_Name}  
    ClickElement           (//lightning-icon[@title\='Endorsements & Subjectivities'])[last()]
    UseModal               On
    TypeText               //input[@name\='enter-search']                           ${Endorsement_Name} 
    PressKey               //input[@name\='enter-search']                          {Enter}
    ClickElement           //span[text()\='Select Item 1']
    ClickElement           //button[@title\='Add']
    VerifyText             Success                     anchor=The data is saved successfully
    UseTable               S.No.
    ${rno}=                GetTableRow                 ${Endorsement_Name}             
    ${exactrow}=           Evaluate                    ${rno}-1
    Log To Console         ${exactrow}

    TypeText               (//input[@name\='additionalPremium'])[${exactrow}]      2000
    ClickText              Save                        anchor=Return Quote Process
    ClickText              Return Quote Process
    Log To Console         ----- Endorsements selected successful------

