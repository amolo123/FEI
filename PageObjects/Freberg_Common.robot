*** Settings ***
Library                         QWeb
Library                         QForce
Library                         String
Library                         Collections
Library                         DateTime
Library                         OperatingSystem
Library                         BuiltIn

Library                         ../libraries/MailLib.py     ${tenant_id}                ${client_id_mail}           ${client_secret_mail}

Library                         ../libraries/graph.py
Resource                        ../resources/graph.resource
Library                         ../libraries/read_docx.py

*** Variables ***
${broker_contact}               Automation FEI

*** Keywords ***

Verify Selected Coverage Product
    [Documentation]             Keyword used for validating the selected Coverage Products
    [Arguments]                 ${expected_selected_coverage_product}
    TRY
    #VerifyElementText          //span[text()\='Selected']/following-sibling::div//*[text()\='${expected_selected_coverage_product}']          ${expected_selected_coverage_product}
        VerifyElementText       //span[text()\='Selected']/parent::div//span[text()\='${expected_selected_coverage_product}']                  ${expected_selected_coverage_product}
    EXCEPT
        Fail                    Could not find '${expected_selected_coverage_product}' in the list of selected coverage product
    END

Open Area if closed
    [Documentation]             Open Area if closed
    [Arguments]                 ${area}

    ${section_closed}=          GetAttribute                //span[text()\='${area}']/ancestor::button              aria-expanded

    IF                          '${section_closed}' == 'false'
        ScrollText              ${area}
        ClickText               ${area}
    END

Expand Aria
    [Documentation]             Keyword used for expending an aria
    ...                         Example: Subjectivities
    [Arguments]                 ${aria_name}
    ${expanded}                 GetAttribute                //span[contains(text(), '${aria_name}')]/parent::button                            aria-expanded

    ScrollTo                    //span[contains(text(), '${aria_name}')]/parent::button

    IF                          '${expanded}' == 'false'
        ClickElement            //span[contains(text(), '${aria_name}')]/parent::button
    END

    Log To Console              Validate that the aria ${aria_name}, is expanded.

    Verify Attribute            //span[contains(text(), '${aria_name}')]/parent::button                             aria-expanded              true

Verify Close reason list 
    VerifyPickList              Closed Reason
    ${Closed_Reason}=           GetPicklist                 Closed Reason
    Log To Console              ${Closed_Reason}
    ${Closed_Reason_List}=      Create List                 Berkley Renewal             Broker segmentation         Broker withdrew request    No Activity                 Not a fit – GL             Not a fit – PL              Not a fit – Pollution      Not a fit – Products       Not a fit – Truck           Price not competitive       Quote no longer needed      Requested information not received                   Storage tank age            Not Quoted – Assigned to Wrong Program              Closed Wrong program                         Referred – Declined by Carrier               Other                       Loss history    Non-renewed    Canceled    Second submission/duplicate submission
    Log To Console              ${Closed_Reason_List}
    Lists Should Be Equal       ${Closed_Reason}            ${Closed_Reason_List}       ignore_order=true


Verify Workflow reason list 
    VerifyPickList              Workflow Status
    ${Workflow_Status}=         GetPicklist                 Workflow Status
    Log To Console              ${Workflow_Status}

    @{Workflow_Status_List}=    Create List                 --None--                    Add'I Info Requested        BOR in Progress            Bound                       Companion auto             Endorsement Request -RSP Only                          Indication Provided        Initial Review              In Rating                   Internal Review             Not Quoted                  PD Registration-RSP only                             Pending UXS Clearance                               Quote Referred        Quote Released         Received                    Renewal In Process                           RSP Review-RSP Only    Underwriter Review- New for UW    UXS Requested
    Log To Console              ${Workflow_Status_List}
    Lists Should Be Equal       ${Workflow_Status_List}     ${Workflow_Status}          ignore_order=true


Add Coverage Products 
    [Documentation]             Clicking on Underwriter Analysis
    [Tags]                      Regression
    [Arguments]                 ${coverage_product}
    VerifyText                  Coverage Product
    MultiPickList               Coverage Product            ${coverage_product}         action=Move to Selected
    Log To Console              ----Coverage products are selected---

Add Exposure
    [Documentation]             Adding Explosure
    [Arguments]                 ${exposure_name}

    ClickElement                (//c-exposure-section-lwc//button)[2]
    UseModal                    On                          //div[@class\='slds-modal__container']

    TypeText                    //span[text()\='Search Exposures']/parent::div//lightning-input                     ${exposure_name}           timeout=5s
    Log To Console              ${exposure_name}
    UseTable                    Exposure Name
    VerifyTable                 r1c2                        ${exposure_name}            timeout=2s
    ClickElement                //td/div[@class\='slds-checkbox']
    ClickText                   Add
    UseModal                    Off

Check Industry Classifications
    [Documentation]             Used for adding an exposure during the underwriting Analysis
    [Arguments]                 ${search_by_industry_Check}

    ScrollText                  Locations and Assets

    TRY
        ClickElement            //span[text()\='Selected EIL Classifications']/ancestor::div[@part\='title']/following-sibling::*//button
        Log                     New Button found
    EXCEPT
        Fail                    Unable to click on New for Industry Classifications
        Log                     Unable to click on New for Industry Classifications
    END

    # ClickText                 New                         anchor=1                    partial_match=false         parent=lightning-button
    UseModal                    On                          modal_xpath=//div[@class\='slds-modal__container']
    VerifyText                  Industry Classifications

    # TypeText                  Search for Classifications                              ${search_for_classifications}\n
    # VerifyNoElement           //Spinner

    ClickText                   or Search by Industry       anchor=close

    TRY
        ClickText               ${search_by_industry_Check}
        log                     ${search_by_industry_Check}
    EXCEPT
        Fail                    Unable to select the industry: '${search_by_industry_Check}'
        Log                     Unable to select the industry: '${search_by_industry_Check}'
    END

    VerifyNoElement             //Spinner

    #loop Changes
    Log To Console              ${CURDIR}
    Import Variables            ${CURDIR}/EILClassificationvariables.py                 ${search_by_industry_Check}

    FOR                         ${index}                    IN RANGE                    ${Total}
        Log                     ${index}                    # 0-9
        ${rownum}=              Evaluate                    ${index}+1

        Log To Console          ${list}[${index}]
        UseTable                Facility Description
        ${text}=                GetCellText                 r${rownum}c2
        Log To Console          ${text}
        Log To Console          ${list}[${index}]
        Scroll Text             ${text}
        IF                      "${list}[${index}]"=="${text}"
            Log To Console      Success
        ELSE
            FAIL
        END
    END

    ClickText                   close
    UseModal                    off
    Sleep                       10s

Add Industry Classifications
    [Documentation]             Used for adding an exposure during the underwriting Analysis
    [Arguments]                 ${search_for_classifications}                           ${search_by_industry}
    ScrollText                  Locations and Assets

    TRY
        ClickElement            //span[text()\='Selected EIL Classifications']/ancestor::div[@part\='title']/following-sibling::*//button
    EXCEPT
        Fail                    Unable to click on New for Industry Classifications
    END

    # ClickText                 New                         anchor=1                    partial_match=false         parent=lightning-button
    UseModal                    On                          modal_xpath=//div[@class\='slds-modal__container']
    VerifyText                  Industry Classifications

    TypeText                    Search for Classifications                              ${search_for_classifications}\n
    VerifyNoElement             //Spinner

    ClickText                   or Search by Industry       anchor=close

    TRY
        ClickText               ${search_by_industry}
    EXCEPT
        Fail                    Unable to select the industry: '${search_by_industry}'
    END

    VerifyNoElement             //Spinner

    UseTable                    Facility Description
    ClickElement                //*[contains(text(),'${search_for_classifications}')]//ancestor::tr//span[contains(@class,'checkbox')]         timeout=2s

    ClickText                   Add
    VerifyNoElement             //Spinner
    TRY
        ClickText               Return to Analysis page\
    EXCEPT
        ClickText               Close
    END
    UseModal                    Off

    Log To Console              ----- Industry Added Successfully ----
Edit Record In EIL Asset Locations
    [Documentation]             Keyword used to edit the record on the Underwriting Analysis steps
    [Arguments]                 ${unique_value_on_row}
    ScrollText                  Location Name
    #Log To Console             ${unique_value_on_row}
    #UseTable                   Location Name
    #ClickElement               r?${unique_value_on_row}/c12
    ClickElement                (//lightning-primitive-cell-actions//button)[2]
    Sleep                       3s
    ClickText                   Edit                        partial_match=false         anchor=Delete
    UseModal                    On                          modal_xpath=//div[@class\='slds-modal__container']

    Log To Console              ----- EIL asset location Edited Successfully ----

New EIL Asset Location
    [Documentation]             Add new EIL location keyword
    [Arguments]                 ${location_name}            ${address}                  ${EIL_classification}       ${basic_premiums}

    ScrollText                  EIL Asset Locations

    TRY
        ClickElement            //span[text()\='EIL Asset Locations']/ancestor::div[@part\='title']/following-sibling::*//button
    EXCEPT
        Fail                    Unable to click on New for Industry Classifications
    END

    UseModal                    On                          modal_xpath=//div[@class\='slds-modal__container']
    TypeText                    *Location Name              ${location_name}
    ClickElement                //label[text()\='Address']/following-sibling::div//input
    TypeText                    //label[text()\='Address']/following-sibling::div//input                            ${address}
    Sleep                       3s
    ClickElement                //label[text()\='Address']/parent::div/following-sibling::div//span[contains(text(),'${address}')]

    PickList                    Select EIL Classification                               ${EIL_classification}
    PickList                    *Basic Premiums             ${basic_premiums}
    ClickText                   Save                        partial_match=false         anchor=Save & New
    UseModal                    Off
    Log To Console              ----- EIL asset location Added Successfully ----
Update Status Subjectivity
    [Documentation]             Keyword used to update the Subjectivities during the Underwriter Analysis
    [Arguments]                 ${name}                     ${set_status}
    ScrollTo                    Subjectivities
    Expand Aria                 Subjectivities
    UseTable                    ${name}
    ScrollText                  Subjectivities
    ClickCell                   r?${name}/c?Status          partial_match=false
    ClickElement                //*[@data-value\='${set_status}' and @aria-checked\='false']



Update All Subjectivities

    ScrollTo                    Subjectivities
    Expand Aria                 Subjectivities
    UseTable                    Product/Coverage
    ScrollText                  Subjectivities
    ${rowNum}=                  GetTableRow                 //last
    Log To Console              ${rowNum}
    ${sub_row}=                 Evaluate                    ${rowNum}-1
    Log To Console              ${sub_row}

    FOR                         ${index}                    IN RANGE                    ${sub_row}
        ${rownum}=              Evaluate                    ${index}+1
        ClickCell               r${rownum}c6
        Log To Console          -----Clicked on r${rownum}c6------
        ClickElement            //lightning-base-combobox-item[@data-value\='Completed' and @aria-checked\='false']                            timeout=10s
    END



Add New STEIL Tank 
    [Documentation]             Add New Tank keyword
    [Arguments]                 ${Tank_name}                ${Asset_Location}           ${Year}                     ${Placement}               ${Capacity}                 ${Tank_Construction}       ${Piping_Construction}


    TRY
        ClickElement            //span[text()\='Tanks']/ancestor::div[@part\='title']/following-sibling::*//button
    EXCEPT
        Fail                    Unable to click on New for New STEIL Tank
    END

    UseModal                    On                          modal_xpath=//div[@class\='slds-modal__container']
    TypeText                    Tank Name                   ${Tank_name}
    PickList                    Asset Location              ${Asset_Location}           timeout=5s
    TypeText                    Year Installed              ${Year}
    PickList                    Placement                   ${Placement}                timeout=5s
    PickList                    Capacity                    ${Capacity}                 timeout=5s
    PickList                    Tank Construction           ${Tank_Construction}        timeout=5s
    PickList                    Piping Construction         ${Piping_Construction}      timeout=5s

    ClickText                   Save                        partial_match=false         anchor=Save & New
    UseModal                    Off

Validated New Tank Picklist for AST

    [Documentation]             Validating Picklist on New Tank Popup for AST
    [Arguments]                 ${Tank_name}                ${Asset_Location}           ${Year}                     ${Placement}               ${Capacity}                 ${Tank_Construction}       ${Piping_Construction}

    ScrollText                  Tanks

    TRY
        ClickElement            //span[text()\='Tanks']/ancestor::div[@part\='title']/following-sibling::*//button
    EXCEPT
        Fail                    Unable to click on New for New STEIL Tank
    END

    UseModal                    On                          modal_xpath=//div[@class\='slds-modal__container']
    TypeText                    Tank Name                   ${Tank_name}

    PickList                    Asset Location              ${Asset_Location}           timeout=5s
    TypeText                    Year Installed              ${Year}

    #Picklist check for Placement
    VerifyPickList              Placement
    ${Placement_A}=             GetPicklist                 Placement
    Log To Console              ${Placement_A}
    ${Placemente_List}=         Create List                 AST                         UST                         --None--
    Log To Console              ${Placemente_List}
    Lists Should Be Equal       ${Placement_A}              ${Placemente_List}          ignore_order=true
    PickList                    Placement                   ${Placement}                timeout=5s

    #Picklist check for Capacity
    VerifyPickList              Capacity
    ${Capacity_A}=              GetPicklist                 Capacity
    Log To Console              ${Capacity_A}
    ${Capacity_List}=           Create List                 --None--                    0 - 110 Gallons             111 - 550 Gallons          551 - 1,500 Gallons         1,501 - 3,000 Gallons      3,001 - 5,000 Gallons       5,001 - 20,000 Gallons     20,001 - 50,000 Gallons    50,001 - 200,000 Gallons    200,001 - 500,000 Gallons                               500,001 - 1,000,000 Gallons                          1,000,001 - 3,000,000 Gallons
    Log To Console              ${Capacity_List}
    Lists Should Be Equal       ${Capacity_A}               ${Capacity_List}            ignore_order=true
    PickList                    Capacity                    ${Capacity}                 timeout=5s

    #Picklist check for Tank Construction
    VerifyPickList              Tank Construction
    ${Tank_Construction_A}=     GetPicklist                 Tank Construction
    Log To Console              ${Tank_Construction_A}
    ${Tank_Construction_List}=                              Create List                 --None--                    Fiberglass                 Welded Steel                Bare Steel                 Stainless Steel             Plastic                    Other
    Log To Console              ${Tank_Construction_List}
    Lists Should Be Equal       ${Tank_Construction_A}      ${Tank_Construction_List}                               ignore_order=true
    PickList                    Tank Construction           ${Tank_Construction}        timeout=5s

    VerifyPickList              Piping Construction
    ${Piping_Construction_A}=                               GetPicklist                 Piping Construction
    Log To Console              ${Piping_Construction_A}
    ${Piping_Construction_List}=                            Create List                 --None--                    Bare Steel                 Black Iron                  Galvanized Steel           Cathode Protected Steel     Fiberglass                 Fiberglass Coated Steel    Double Walled               Other
    Log To Console              ${Piping_Construction_List}
    Lists Should Be Equal       ${Piping_Construction_A}    ${Piping_Construction_List}                             ignore_order=true
    PickList                    Piping Construction         ${Piping_Construction}      timeout=5s

    ClickText                   Cancel                      partial_match=false         anchor=Save & New
    UseModal                    Off

Validated New Tank Picklist for UST

    [Documentation]             Validating Picklist on New Tank Popup for UST
    [Arguments]                 ${Tank_name}                ${Asset_Location}           ${Year}                     ${Placement}               ${Capacity}                 ${Tank_Construction}       ${Piping_Construction}

    ScrollText                  Tanks

    TRY
        ClickElement            //span[text()\='Tanks']/ancestor::div[@part\='title']/following-sibling::*//button
    EXCEPT
        Fail                    Unable to click on New for New STEIL Tank
    END

    UseModal                    On                          modal_xpath=//div[@class\='slds-modal__container']
    TypeText                    Tank Name                   ${Tank_name}

    PickList                    Asset Location              ${Asset_Location}           timeout=5s
    TypeText                    Year Installed              ${Year}

    #Picklist check for Placement
    VerifyPickList              Placement
    ${Placement_A}=             GetPicklist                 Placement
    Log To Console              ${Placement_A}
    ${Placemente_List}=         Create List                 AST                         UST                         --None--
    Log To Console              ${Placemente_List}
    Lists Should Be Equal       ${Placement_A}              ${Placemente_List}          ignore_order=true
    PickList                    Placement                   ${Placement}                timeout=5s

    #Picklist check for Capacity
    VerifyPickList              Capacity
    ${Capacity_A}=              GetPicklist                 Capacity
    Log To Console              ${Capacity_A}
    ${Capacity_List}=           Create List                 --None--                    Less than 4,000 Gallons     4001 - 15,000 Gallons      15,000+ Gallons             Other
    Log To Console              ${Capacity_List}
    Lists Should Be Equal       ${Capacity_A}               ${Capacity_List}            ignore_order=true
    PickList                    Capacity                    ${Capacity}                 timeout=5s

    #Picklist check for Tank Construction
    VerifyPickList              Tank Construction
    ${Tank_Construction_A}=     GetPicklist                 Tank Construction
    Log To Console              ${Tank_Construction_A}
    ${Tank_Construction_List}=                              Create List                 --None--                    Bare Steel, painted or asphalt                         Fiberglass                 Cathode protected steel     STI-P3                     Fiberglass lined steel     Fiberglass clad steel       Double wall - CPS           Double wall - fiberglass    Double wall - FCS
    Log To Console              ${Tank_Construction_List}
    Lists Should Be Equal       ${Tank_Construction_A}      ${Tank_Construction_List}                               ignore_order=true
    PickList                    Tank Construction           ${Tank_Construction}        timeout=5s

    VerifyPickList              Piping Construction
    ${Piping_Construction_A}=                               GetPicklist                 Piping Construction
    Log To Console              ${Piping_Construction_A}
    ${Piping_Construction_List}=                            Create List                 --None--                    Bare Steel                 Black Iron                  Galvanized Steel           Cathode Protected Steel     Fiberglass                 Fiberglass Coated Steel    Double Walled               Other
    Log To Console              ${Piping_Construction_List}
    Lists Should Be Equal       ${Piping_Construction_A}    ${Piping_Construction_List}                             ignore_order=true
    PickList                    Piping Construction         ${Piping_Construction}      timeout=5s

    ClickText                   Cancel                      partial_match=false         anchor=Save & New
    UseModal                    Off


Add Prior Policies for Excess 

    [Documentation]             Add Prior Policies for Excess on Underwriter Analysis
    [Arguments]                 ${Excess_Prior_Policy_Name}                             ${Policy_Type}              ${Policy_Insurer}          ${Policy_Number}            ${Covered}                 ${Occurrence_Limit}         ${Aggregate_Limit}         ${Per_Employee_Limit}      ${Effective_Date}           ${Expiration_Date}

    ClickElement                (//lightning-icon[@title\='Add Prior Policies'])[last()]                            timeout=5s
    UseModal                    on
    ClickElement                //button[text()\='New']     timeout=5s

    UseModal                    off
    UseModal                    On

    TypeText                    Policy Name                 ${Excess_Prior_Policy_Name}                             timeout=10s

    #Selecting Policy Type, policy Insurer, Policy Number
    # PickList                  Policy Type                 ${Policy_Type}              timeout=5s
    MultiPickList               Policy Type                 ${Policy_Type}              timeout=5s

    TypeText                    //input[@name\='Policy_Insurer__c']                     ${Policy_Insurer}
    # Sleep                     3s
    TypeText                    //input[@name\='Policy_Number__c']                      ${Policy_Number}


    #Validating Picklist and select covered
    VerifyPickList              Covered
    # ${Covered_A}=             GetPicklist                 Covered
    # Log To Console            ${Covered_A}
    # ${Covered_List}=          Create List                 --None--                    Yes                         No
    # Lists Should Be Equal     ${Covered_A}                ${Covered_List}             ignore_order=true

    PickList                    Covered                     ${Covered}                  timeout=5s
    TypeText                    //input[@name\='Occurrence_Limit__c']                   ${Occurrence_Limit}
    TypeText                    //input[@name\='Aggregate_Limit__c']                    ${Aggregate_Limit}
    TypeText                    Per Employee Limit (Workers Comp Only)                  ${Per_Employee_Limit}
    TypeText                    //input[@name\='Effective_Date__c']                     ${Effective_Date}
    TypeText                    //input[@name\='Expiration_Date__c']                    ${Expiration_Date}
    ClickText                   Save                        anchor=Cancel

    UseModal                    Off


    VerifyText                  Return to Quote Process
    ClickText                   Return to Quote Process


Change Underwriter and CSR
    #Author= Amol Gaymukhe

    ${underwriter_exists}=      IsElement                   //label[text()\='Underwriter']/parent::*//input
    ${CSR_exists}=              IsElement                   //label[text()\='CSR']/parent::*//input

    Log To Console              ${underwriter_exists}
    Log To Console              ${CSR_exists}
    IF                          '${underwriter_exists}'=='False' and '${CSR_exists}'=='False'
        ClickElement            (//label[text()\='Underwriter']/parent::*//lightning-button-icon[@class\='slds-pill__remove'])[last()]
        ClickElement            (//label[text()\='CSR']/parent::*//lightning-button-icon[@class\='slds-pill__remove'])[last()]

        ClickElement            //label[text()\='Underwriter']/parent::c-generate-element-lwc//input
        TypeText                //label[text()\='Underwriter']/parent::c-generate-element-lwc//input                Automation-user
        Sleep                   4s
        ClickElement            (//label[text()\='Underwriter']/parent::c-generate-element-lwc//li)[1]

        ClickElement            //label[text()\='CSR']/parent::c-generate-element-lwc//input
        TypeText                //label[text()\='CSR']/parent::c-generate-element-lwc//input                        Copado-LGO
        Sleep                   4s
        ClickElement            (//label[text()\='CSR']/parent::c-generate-element-lwc//li)[1]

    ELSE
        ClickElement            //label[text()\='Underwriter']/parent::c-generate-element-lwc//input
        TypeText                //label[text()\='Underwriter']/parent::c-generate-element-lwc//input                Automation-user
        Sleep                   4s
        ClickElement            (//label[text()\='Underwriter']/parent::c-generate-element-lwc//li)[1]

        ClickElement            //label[text()\='CSR']/parent::c-generate-element-lwc//input
        TypeText                //label[text()\='CSR']/parent::c-generate-element-lwc//input                        Copado-LGO
        Sleep                   4s
        ClickElement            (//label[text()\='CSR']/parent::c-generate-element-lwc//li)[1]
    END




Verify Decline and Reopen
    #Author=Amol Gaymukhe
    [Documentation]             Decline
    sleep                       5s
    ClickText                   Decline
    #VerifyText                 Declination Reason(s)
    Verify Close reason list
    ClickText                   -Select-                    anchor=*Closed Reason
    ClickText                   No Activity                 anchor=Close Submission
    #TypeText                   Comment                     Random Comment
    ClickText                   Yes
    VerifyText                  Submission is declined successfully.
    Sleep                       5sec
    ScrollTo                    Send                        anchor=Cancel
    ClickText                   Send                        anchor=Cancel               delay=2s                    partial_match=false
    Log To Console              ----- Decline Done Successfully -----
    # sleep                     10s
    ClickText                   Reopen                      timeout=10s
    VerifyText                  Carrier Commission %        timeout=10s
    Sleep                       10s


Verify Close and Reopen
    #Author=Amol Gaymukhe
    [Documentation]             Close and Reopen
    ClickText                   Close                       anchor=Decline
    UseModal                    On
    VerifyText                  Close Submission

    ClickElement                (//button[@aria-label\='Closed Reason'])[2]
    ClickText                   No Activity
    ClickText                   Yes                         anchor=No
    Verifytext                  Close Submission is successfully.                       timeout=10s
    Log To Console              ----- Close Done Successfully -----
    sleep                       10s
    ClickText                   Reopen                      timeout=10s
    VerifyText                  Submission is reopened successfully.                    timeout=15s


Expand Subjectivities
    #Author=Amol
    [Documentation]             Expand Subjectivities
    ${subjectivity_flag}=       GetAttribute                //span[@title\='Subjectivities']//ancestor::button      aria-expanded
    Log To Console              ${subjectivity_flag}

    IF                          '${subjectivity_flag}' == 'false'
        ClickElement            //span[text()\='Subjectivities']//parent::button
    ELSE
        Log To Console          Subjectivities Accordian already Opened
    END





    # Click On Bind
    #                           #Author=Amol Gaymukhe
    #                           [Documentation]             Clicking on Bind Button

    #                           ClickElement                //button[@title\='Bind']
    #                           VerifyText                  Bind Quote
    #                           Sleep                       3s

    #                           UseModal                    On
    #                           ClickElement                (//button[@title\='Bind'])[2]
    #                           VerifyText                  Success                     anchor=Bind quote Successfully!                        timeout=45s
    #                           Log To Console              --------------Bind Successfull----------------
    #                           Sleep                       15s


Check Referral Mail 
    #Author=Amol
    [Documentation]             Check Carrier Referral Mail

    ${Text_compare}=            Set Variable                Sandbox: Approval Request
    Log To Console              ${Text_compare}
    ${body}=                    Get Email Content           ${client_id_mail}           ${client_secret_mail}       ${tenant_id}               QA.Testing.Inbox@innovisk.global                       ${Text_compare}
    #Log To Console             ${body}
    Set Global Variable         ${body}
    Should Contain              ${body}                     Please click this link to approve or reject this record.


Check Approved Referral Mail
    #Author=Amol
    [Documentation]             Check Carrier Referral Mail

    ${Text_compare}=            Set Variable                Sandbox: Submission Approved
    Log To Console              ${Text_compare}
    ${body}=                    Get Email Content           ${client_id_mail}           ${client_secret_mail}       ${tenant_id}               QA.Testing.Inbox@innovisk.global                       ${Text_compare}
    #Log To Console             ${body}
    Set Global Variable         ${body}
    Should Contain              ${body}                     has been Approved. You can access the Submission by clicking here: Submission Link


Check Reject Referral Mail
    #Author=Amol
    [Documentation]             Check Carrier Referral Mail

    ${Text_compare}=            Set Variable                Sandbox: Submission Rejected
    Log To Console              ${Text_compare}
    ${body}=                    Get Email Content           ${client_id_mail}           ${client_secret_mail}       ${tenant_id}               QA.Testing.Inbox@innovisk.global                       ${Text_compare}
    #Log To Console             ${body}
    Set Global Variable         ${body}
    Should Contain              ${body}                     has been rejected


Selecting Approval from Notification
    #Author=Amol Gaymukhe

    ClickElement                //div[@class\='unsNotificationsCounter']
    Sleep                       3s
    ClickElement                (//li[@data-aura-class\='unsNotificationsListRow']//span[@class\='notification-text uiOutputText'])[1]
    Sleep                       3s
    VerifyText                  NYFTZ Approval Process


Approve the NYFTZ
    #Author=Amol Gaymukhe

    ClickText                   Approve                     anchor=Reject
    TypeText                    Comments                    Aproving the NYFTZ
    ClickText                   Approve                     anchor=Cancel


Reject the NYFTZ
    #Author=Amol Gaymukhe
    Usemodal                    On
    ClickText                   Reject                      anchor=Approve
    TypeText                    Comments                    Rejecting the NYFTZ
    ClickText                   Reject                      anchor=Cancel
    Usemodal                    Off

Verify Approval on Submission
    #Author=Amol Gaymukhe
    Back
    RefreshPage
    VerifyText                  This Submission's referral has been approved to Proceed


Verify Rejection on Submission 
    Back
    RefreshPage
    VerifyText                  This Submission's referral has been rejected


Get WORD document and attach it to log
    [Documentation]             This keyword will read the downloaded document
    ...                         Will store it in a suite variable ${read_doc}
    ...                         And will attach it to the execution log
    Sleep                       10s

    IF                          "${EXECDIR}"=="/home/executor/execution"
    # normal test run environment
        ${downloads_folder}=    Set Variable                /home/executor/Downloads
    ELSE                        # Live Testing environment
        ${downloads_folder}=    Set Variable                /home/services/Downloads
    END
    Wait Until Keyword Succeeds                             30 sec                      2 sec                       Directory Should Exist     ${downloads_folder}
    @{list_files}               List Files In Directory     ${downloads_folder}         *.docx
    #@{list_files}              List Files In Directory     ${OUTPUT_DIR}               *.docx
    Log To Console              ${list_files}[0]
    Move File                   ${downloads_folder}/${list_files}[0]                    ${OUTPUT_DIR}
    Sleep                       2s
    #File Should Exist          ${downloads_folder}/${list_files}[0]
    #read Docx File             ${downloads_folder}/${list_files}[0]
    Log To Console              ${OUTPUT_DIR}/${list_files}[0]
    ${read_doc}=                read docx file              ${OUTPUT_DIR}/${list_files}[0]
    Log To Console              ${read_doc}
    #${testdoc}=                Get File                    ${OUTPUT_DIR}/${list_files}[0]
    # Attach file to log
    #Copy File                  ${downloads_folder}${list_files}[1]                     ${OUTPUT DIR}
    Set Suite Variable          ${read_doc}

    # Example of custom keyword with robot fw syntax
    # VerifyStage
    #                           [Documentation]             Verifies that stage given in ${text} is at ${selected} state; either selected (true) or not selected (false)
    #                           [Arguments]                 ${text}                     ${selected}=true
    #                           VerifyElement               //a[@title\="${text}" and (@aria-checked\="${selected}" or @aria-selected\="${selected}")]


    # NoData
    #                           VerifyNoText                ${data}                     timeout=3                   delay=2


    # DeleteAccounts
    #                           [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    #                           ClickText                   ${data}
    #                           ClickText                   Delete
    #                           VerifyText                  Are you sure you want to delete this account?
    #                           ClickText                   Delete                      2
    #                           VerifyText                  Undo
    #                           VerifyNoText                Undo
    #                           ClickText                   Accounts                    partial_match=False


    # DeleteLeads
    #                           [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    #                           ClickText                   ${data}
    #                           ClickText                   Delete
    #                           VerifyText                  Are you sure you want to delete this lead?
    #                           ClickText                   Delete                      2
    #                           VerifyText                  Undo
    #                           VerifyNoText                Undo
    #                           ClickText                   Leads                       partial_match=False

Enter Data In Excess Fields

    FOR                         ${index}                    IN RANGE                    10
        ${rownum}=              Evaluate                    ${index}+1
        TypeText                (//b[text()\='Excess']/parent::div/following-sibling::table//input)[${rownum}]      25
        Log To Console          -----${rownum} Entered------
        #ClickElement           //lightning-base-combobox-item[@data-value\='Completed' and @aria-checked\='false']                            timeout=10s
    END

    TypeText                    //b[text()\='Number of at-Fault Losses Last 3 Years ']/parent::div//input           25

Subjectivities for CGL CPL PL and Excess

    [Documentation]             Subjectivities for CGL CPL PL and Excess


    Update Status Subjectivity                              BRF - ECC                   Completed
    Update Status Subjectivity                              ECC OFAC                    Completed
    Update Status Subjectivity                              TRIA - ECC                  Completed
    Update Status Subjectivity                              BRF - UL info               Completed
    Update Status Subjectivity                              BRF - XS                    Completed
    Update Status Subjectivity                              XS OFAC                     Completed



Subjectivities for CGL CPL PL
    [Documentation]             Subjectivities for CGL CPL PL

    Update Status Subjectivity                              BRF - ECC                   Completed
    Update Status Subjectivity                              ECC OFAC                    Completed
    Update Status Subjectivity                              TRIA - ECC                  Completed

Subjectivities for CGL CPL PL Excess and EIL

    [Documentation]             Subjectivities for CGL CPL PL Excess and EIL

    Update Status Subjectivity                              EIL App                     Completed
    Update Status Subjectivity                              EIL OFAC                    Completed
    Update Status Subjectivity                              BRF -EIL                    Completed
    Update Status Subjectivity                              BRF - UL info               Completed
    Update Status Subjectivity                              BRF - XS                    Completed
    Update Status Subjectivity                              XS OFAC                     Completed

Subjectivities for CGL CPL PL Excess and EIL with WY state 

    [Documentation]             Subjectivities for CGL CPL PL Excess and EIL with WY state

    Update Status Subjectivity                              FEE                         Completed
    Update Status Subjectivity                              WY Diligent Effort          Completed
    Update Status Subjectivity                              EIL App                     Completed
    Update Status Subjectivity                              EIL OFAC                    Completed
    Update Status Subjectivity                              BRF -EIL                    Completed
    Update Status Subjectivity                              BRF - UL info               Completed
    Update Status Subjectivity                              BRF - XS                    Completed
    Update Status Subjectivity                              XS OFAC                     Completed
    Update Status Subjectivity                              WY Diligent Effort - XS     Completed

Subjectivities for CGL CPL PL and EIL

    [Documentation]             Subjectivities for CGL CPL PL and EIL


    Update Status Subjectivity                              EIL App                     Completed
    Update Status Subjectivity                              EIL OFAC                    Completed
    Update Status Subjectivity                              BRF -EIL                    Completed

Add Endorsement
    [Documentation]             Add Endorsement
    [Arguments]                 ${Form_NO}                  ${Name}

    UseModal                    On
    TypeText                    Search for Endorsements     ${Form_NO}
    PressKey                    //input[@placeholder\="Search for Endorsements"]        {ENTER}
    ClickElement                (//lightning-datatable)[last()]//thead//input[@type\="checkbox"]
    ClickText                   Add
    ClickText                   Return Quote Process
    VerifyText                  Rate                        timeout=30
    RefreshPage
    Sleep                       5s
    ClickElement                //button[text()\="Rate"]
    VerifyText                  Success                     anchor=Rating sucessfully!                              timeout=45s

    ClickElement                //lightning-icon[@title\='Endorsements & Subjectivities']
    VerifyText                  ${Form_NO}
    VerifyText                  ${Name}

Select broker Contact Source
    #Author=Amol Gaymukhe

    UseModal                    On
    Select Broker Contact       ${broker_contact}
    Set Global Variable         ${broker_contact}

Select Broker Contact
    [Documentation]             Used to select the Broker on the Submission Init Form
    [Arguments]                 ${broker}
    #Author=Amol Gaymukhe
    Sleep                       5s
    UseModal                    On
    VerifyText                  Submission Init Form
    LogScreenshot
    ClickElement                //label[text()\='Broker Contact']/following-sibling::div//input
    TypeText                    //label[text()\='Broker Contact']/following-sibling::div//input                     ${broker}
    Sleep                       3s
    ClickElement                //label[text()\='Broker Contact']/following-sibling::div//span[contains(text(),'${broker}')]
    # QVision.ClickText         ${broker}                   index=2
    ClickText                   Next                        anchor=Cancel
    Log To Console              ----- Broker Contact Selected successfully------        Successfully -----

Subjectivities for OCP
    [Documentation]             Subjectivities for OCP

    Update Status Subjectivity                              BRF - OCP                   Completed
    Update Status Subjectivity                              OCP OFAC                    Completed
    Update Status Subjectivity                              TRIA - OCP                  Completed
    Update Status Subjectivity                              OCP App                     Completed

Subjectivities for RRP
    [Documentation]             Subjectivities for OCP

    Update Status Subjectivity                              RRP OFAC                    Completed



Save Coverage Products and broker name On Submission Page
    #Amol Gaymukhe
    ${Coverage_var}=            GetText                     //span[text()\='Coverage Product Options']/parent::*//lightning-formatted-text
    Set Global Variable         ${Coverage_var}
    ${broker_var}=              GetText                     //td[@data-label\='Broker Name']//lightning-base-formatted-text
    Set Global Variable         ${broker_var}

Save Total Premium Basis On Underwriting Analysis Page 
    #Amol Gaymukhe
    ${TotalPremium_var}=        GetInputValue               //span[text()\='Total Premium Basis']/parent::*//input
    Set Global Variable         ${TotalPremium_var}
    Log To Console              ${TotalPremium_var}

Save Exposures On Underwriting Analysis Page with Arg 
    #Amol Gaymukhe
    [Arguments]                 ${Number}
    @{All_exposures_var}=       Create List

    FOR                         ${index}                    IN RANGE                    ${Number}
        Log                     ${index}                    # 0-9
        ${rownum}=              Evaluate                    ${index}+1

        Log To Console          ${rownum}
        ${value}=               GetInputValue               (//c-exposure-section-lwc//input)[${rownum}]
        Append To List          ${All_exposures_var}        ${value}
    END

    Set Global Variable         @{All_exposures_var}


Get Coverage Product and Broker Contact On Renewal  
    #Amol Gaymukhe
    ${Coverage_Renewal_var}=    GetText                     //span[text()\='Coverage Product Options']/parent::*//lightning-formatted-text
    Set Global Variable         ${Coverage_Renewal_var}
    ${broker_Renewal_var}=      GetText                     //td[@data-label\='Broker Name']//lightning-base-formatted-text
    Set Global Variable         ${broker_Renewal_var}

Compare Submission Info data
    #Amol Gaymukhe
    IF                          '${Coverage_var}'=='${Coverage_Renewal_var}' and '${broker_var}'=='${broker_Renewal_var}'
        Log To Console          PASS
    ELSE
        Fail
    END

Get Save Total Premium Basis On Renewal
    #Amol Gaymukhe
    ${TotalPremium_Renewal_var}=                            GetInputValue               //span[text()\='Total Premium Basis']/parent::*//input
    Set Global Variable         ${TotalPremium_Renewal_var}


Get Exposures On Underwriting Analysis Page On Renewal with Arg 
    #Amol Gaymukhe
    [Arguments]                 ${Number}
    @{All_exposures_Renewal_var}=                           Create List

    FOR                         ${index}                    IN RANGE                    ${Number}
        Log                     ${index}                    # 0-9
        ${rownum}=              Evaluate                    ${index}+1

        Log To Console          ${rownum}
        ${value}=               GetInputValue               (//c-exposure-section-lwc//input)[${rownum}]
        Append To List          ${All_exposures_Renewal_var}                            ${value}
    END


    Set Global Variable         @{All_exposures_Renewal_var}


Get Retro date NAICS EIL asset Location and tank

    ${retro_date_var}=          GetInputValue               //span[text()\='Retro Date']/parent::*//input
    Set Global Variable         ${retro_date_var}

    ${Business_NAICS_Code_var}=                             GetAttribute                //button[@aria-label\='Business NAICS Code']           data-value
    Set Global Variable         ${Business_NAICS_Code_var}

    ${location_var}=            GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[3]
    Set Global Variable         ${location_var}
    ${addres_var}=              GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[4]
    Set Global Variable         ${addres_var}
    ${city_var}=                GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[5]
    Set Global Variable         ${city_var}
    ${state_var}=               GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[6]
    Set Global Variable         ${state_var}
    ${postalcode_var}=          GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[7]
    Set Global Variable         ${postalcode_var}

    ${tankName_var}=            GetText                     (//span[text()\='Tanks']/ancestor::article//td)[3]
    Set Global Variable         ${tankName_var}
    ${assetLocation_var}=       GetText                     (//span[text()\='Tanks']/ancestor::article//td)[4]
    Set Global Variable         ${assetLocation_var}
    ${YearInstalled_var}=       GetText                     (//span[text()\='Tanks']/ancestor::article//td)[5]
    Set Global Variable         ${YearInstalled_var}
    ${placement_var}=           GetText                     (//span[text()\='Tanks']/ancestor::article//td)[6]
    Set Global Variable         ${placement_var}
    ${capacity_var}=            GetText                     (//span[text()\='Tanks']/ancestor::article//td)[7]
    Set Global Variable         ${capacity_var}




Compare Undewritting analysis data
    #Amol Gaymukhe
    IF                          '${TotalPremium_var}'=='${TotalPremium_Renewal_var}'
        Log To Console          PASS
    ELSE
        Fail
    END

    Lists Should Be Equal       ${All_exposures_var}        ${All_exposures_Renewal_var}



Get Retro date NAICS EIL asset Location and tank after renewal
    #Amol Gaymukhe
    ${retro_date_renewal_var}=                              GetInputValue               //span[text()\='Retro Date']/parent::*//input
    Set Global Variable         ${retro_date_renewal_var}

    ${Business_NAICS_Code_renewal_var}=                     GetAttribute                //button[@aria-label\='Business NAICS Code']           data-value
    Set Global Variable         ${Business_NAICS_Code_renewal_var}

    ${location_renewal_var}=    GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[3]
    Set Global Variable         ${location_renewal_var}
    ${addres_renewal_var}=      GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[4]
    Set Global Variable         ${addres_renewal_var}
    ${city_renewal_var}=        GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[5]
    Set Global Variable         ${city_renewal_var}
    ${state_renewal_var}=       GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[6]
    Set Global Variable         ${state_renewal_var}
    ${postalcode_renewal_var}=                              GetText                     (//span[text()\='EIL Asset Locations']/ancestor::article//td)[7]
    Set Global Variable         ${postalcode_renewal_var}

    ${tankName_renewal_var}=    GetText                     (//span[text()\='Tanks']/ancestor::article//td)[3]
    Set Global Variable         ${tankName_renewal_var}
    ${assetLocation_renewal_var}=                           GetText                     (//span[text()\='Tanks']/ancestor::article//td)[4]
    Set Global Variable         ${assetLocation_renewal_var}
    ${YearInstalled_renewal_var}=                           GetText                     (//span[text()\='Tanks']/ancestor::article//td)[5]
    Set Global Variable         ${YearInstalled_renewal_var}
    ${placement_renewal_var}=                               GetText                     (//span[text()\='Tanks']/ancestor::article//td)[6]
    Set Global Variable         ${placement_renewal_var}
    ${capacity_renewal_var}=    GetText                     (//span[text()\='Tanks']/ancestor::article//td)[7]
    Set Global Variable         ${capacity_renewal_var}


Compare Undewritting analysis data for STEIL
    #Amol Gaymukhe
    IF                          '${retro_date_var}'=='${retro_date_renewal_var}' and '${Business_NAICS_Code_var}'=='${Business_NAICS_Code_renewal_var}'
        Log To Console          PASS
    ELSE
        Fail
    END

    IF                          '${location_var}'== '${location_renewal_var}' and '${addres_var}'=='${addres_renewal_var}' and '${city_var}'=='${city_renewal_var}' and '${state_var}'=='${state_renewal_var}' and '${postalcode_var}'=='${postalcode_renewal_var}'
        Log To Console          PASS
    ELSE
        Fail
    END

    IF                          '${tankName_var}'=='${tankName_renewal_var}' and '${assetLocation_var}'=='${assetLocation_renewal_var}' and '${YearInstalled_var}'=='${YearInstalled_renewal_var}' and '${placement_var}'=='${placement_renewal_var}' and '${capacity_var}'=='${capacity_renewal_var}'
        Log To Console          PASS
    ELSE
        Fail
    END


Get product selection business type and broker Contact
    #Amol Gaymukhe
    ${product_var}=             GetElementCount             //span[text()\='Selected']/parent::*//li
    Set Global Variable         ${product_var}

    ${business_type_var}=       GetAttribute                //button[@aria-label\='Business Type']                  data-value
    Set Global Variable         ${business_type_var}


    ${broker_contact}=          GetText                     //label[text()\='Broker Contact']/parent::*//a//span
    Set Global Variable         ${broker_contact}


Get product selection business type and broker Contact after Renewal
    #Amol Gaymukhe
    ${product_renewal_var}=     GetElementCount             //span[text()\='Selected']/parent::*//li
    Set Global Variable         ${product_renewal_var}

    ${business_type_renewal_var}=                           GetAttribute                //button[@aria-label\='Business Type']                 data-value
    Set Global Variable         ${business_type_renewal_var}


    ${broker_contact_renewal_var}=                          GetText                     //label[text()\='Broker Contact']/parent::*//a//span
    Set Global Variable         ${broker_contact_renewal_var}


Compare Submission Info data Trucking
    #Amol Gaymukhe
    IF                          '${product_var}'=='${product_renewal_var}' and '${business_type_var}'=='${business_type_renewal_var}' and '${broker_contact}'=='${broker_contact_renewal_var}'
        Log To Console          PASS
    ELSE
        Fail
    END
    #Log To Console             ${product_var}
    # Log To Console            ${product_renewal_var}
    # Log To Console            ${business_type_var}
    # Log To Console            ${business_type_renewal_var}
    # Log To Console            ${broker_contact}
    # Log To Console            ${broker_contact_renewal_var}
    # Log To Console            ${product_var}