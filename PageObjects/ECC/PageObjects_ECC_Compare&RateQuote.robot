*** Settings ***
Library                    QWeb
Library                    QForce
Library                    FakerLibrary
Library                    String
Library                    BuiltIn
Library                    DateTime
Resource                   ../../resources/common.robot
Resource                   PageObjects_ECC_InsuredInfo.robot
Resource                   ../Freberg_Common.robot


Library                    ../../libraries/MailLib.py                              ${tenant_id}                ${client_id_mail}        ${client_secret_mail}

Library                    ${CURDIR}/../../libraries/graph.py
Resource                   ${CURDIR}/../../resources/graph.resource

*** Variables ***


*** Keywords ***

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
    Log To Console         ----- All Endorsements validated Successfully ------

Verify already added Endorsements for ECC

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

Verify Default Endorsements for ECC

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


Select Endorsements after Amendment and Additional Premium
    #Author=Amol Gaymukhe
    [Documentation]        Selecting Endorsements

    ClickElement           (//lightning-icon[@title\='Endorsements & Subjectivities'])[last()]
    UseModal               On
    TypeText               //input[@name\='enter-search']                          Governmental Entity Endorsement
    PressKey               //input[@name\='enter-search']                          {Enter}
    ClickElement           //span[text()\='Select Item 1']
    ClickElement           //button[@title\='Add']
    VerifyText             Success                     anchor=The data is saved successfully
    UseTable               S.No.
    ${rno}=                GetTableRow                 Governmental Entity Endorsement
    ${exactrow}=           Evaluate                    ${rno}-1
    Log To Console         ${exactrow}

    TypeText               (//input[@name\='additionalPremium'])[${exactrow}]      2000
    ClickText              Save                        anchor=Return Quote Process
    ClickText              Return Quote Process
    Log To Console         ----- Endorsements selected successful------

Select Endorsements after Amendment and Additional Premium with arg
    #Author=Amol Gaymukhe
    [Documentation]        Selecting Endorsements
    [Arguments]            ${Endorsement_Name}  
    ClickElement           (//lightning-icon[@title\='Endorsements & Subjectivities'])[last()]
    UseModal               On
    TypeText               //input[@name\='enter-search']                          ${Endorsement_Name}    #Governmental Entity Endorsement
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




Select Endorsements after Amendment and Free Form Endorsement
    #Author=Amol Gaymukhe
    [Documentation]        Selecting Endorsements

    ClickElement           (//lightning-icon[@title\='Endorsements & Subjectivities'])[last()]
    UseModal               On
    ClickText              Free Form Endorsements
    ClickElement           //button[text()\='New']
    TypeText               *Endorsement Name           Freeform Endorsement Test                               Governmental Entity Endorsement
    ClickElement           (//div[@aria-label\='Endorsement Wording']//div[@part\='rich-text-editor-textarea'])[2]
    TypeText               (//div[@role\='textbox'])[1]                            Test
    ClickText              Save                        anchor=Cancel
    ClickText              Save                        anchor=Return Quote Process
    ClickText              Return Quote Process        anchor=Save
    Sleep                  10s

    Log To Console         -----Free Form              Endorsements selected successful------

Select Endorsements after Amendment and Additional Premium for excess                  
    #Author=Amol Gaymukhe
    [Documentation]        Selecting Endorsements

    ClickElement           (//lightning-icon[@title\='Endorsements & Subjectivities'])[last()]
    UseModal               On
    TypeText               //input[@name\='enter-search']                          EXS-578-0712
    PressKey               //input[@name\='enter-search']                          {Enter}
    ClickElement           //span[text()\='Select Item 1']
    ClickElement           //button[@title\='Add']
    VerifyText             Success                     anchor=The data is saved successfully
    UseTable               S.No.
    ${rno}=                GetTableRow                 EXS-578-0712
    ${exactrow}=           Evaluate                    ${rno}-1
    Log To Console         ${exactrow}

    TypeText               (//input[@name\='additionalPremium'])[${exactrow}]      2000
    ClickText              Save                        anchor=Return Quote Process
    ClickText              Return Quote Process
    Log To Console         ----- Endorsements selected successful------

Enter Primary Loss Control Fees
    #Author=Amol Gaymukhe
    TypeText               //input[contains(@name,'-Primary Loss Control Fees')]                               450


Enter Primary Policy Fees   
    #Author=Amol Gaymukhe
    TypeText               //input[contains(@name,'-Primary Policy Fees')]         250

Verify Primary SL Fees
    #Author=Amol Gaymukhe
    ${sl_fees}=            GetInputValue               //input[contains(@name,'-Primary SL Fees')]
    Log To Console         ${sl_fees}
    IF                     '${sl_fees}' == '$60.00'
        Log To Console     SL Fees Verified Successfully
    ELSE
        Log To Console     SL Fees is not present
        Fail
    END

Carrier Referral Or Internal Referral for ECC 
    #Author=Amol Gaymukhe
    [Documentation]        Check Internal/Carrier Referral Mail
    [Arguments]            ${refer_type}
    ClickText              Refer                       anchor=New Quote
    UseModal               On
    PickList               Refer Type                  ${refer_type}
    IF                     '${refer_type}' == 'Carrier Referral'
        MultiPickList      Referral Reason             Premium                     action=Move to Chosen
        TypeText           Comments                    This is a Test ${refer_type} by Automation
    ELSE
        MultiPickList      Referral Reason             UW authority                action=Move to Chosen
        TypeText           Comments                    This is a Test ${refer_type} by Automation
    END
    ClickText              Ok                          anchor=Cancel
    VerifyText             Success !                   anchor=Your request is submitted successfully.




Approve the Referral
    #Author=Amol
    [Documentation]        Approve the referral

    ClickText              Activity                    anchor=Emails
    ClickText              Approve                     anchor=Reject
    TypeText               Comments                    Approve Carrier
    ClickText              Approve                     anchor=Cancel
    ClickElement           //a[text()\='Underwriter Workbench']
    RefreshPage
    VerifyText             This Submission's referral has been approved to Proceed


Approve With Modification 
    #Author=Amol
    [Documentation]        Approve the referral

    ClickText              Activity                    anchor=Emails
    ClickText              Approve with modification                               anchor=Reject
    UseModal               On
    TypeText               *Modification Required      Change commision and Approve Carrier
    ClickText              Approve with modification                               anchor=Cancel
    ClickElement           //a[text()\='Underwriter Workbench']
    RefreshPage
    VerifyText             This Submission's referral has been approved to Proceed


Reject the Referral
    #Author=Amol
    [Documentation]        Approve the referral

    ClickText              Activity                    anchor=Emails
    ClickText              Reject                      anchor=Approve
    TypeText               Comments                    Reject Carrier
    ClickText              Reject                      anchor=Cancel
    ClickElement           //a[text()\='Underwriter Workbench']
    RefreshPage
    VerifyText             This Submission's referral has been rejected


Get Quote Letter Dynamic Document ECC
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
    ${premium2}=           Remove String               ${premium}                  $                           .00
    ${PDF_Premium}=        Set Variable                ${premium2}
    Set Global Variable    ${PDF_Premium}

Click on Bind for OCP/RRP
    #Author=Akshay Verma
    ClickElement           //button[@title\='Bind']
    Usemodal               On
    VerifyText             Bind Quote
    #ClickElement          //span[text()\='Bind']
    ClickText              Bind                        anchor=Cancel
    Usemodal               Off
    VerifyText             Success                     anchor=Bind quote sucessfully!
    Log To Console         ----- Bind is successful------

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
