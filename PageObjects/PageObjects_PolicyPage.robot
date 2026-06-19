*** Settings ***
Library                         QWeb
Library                         QForce
Library                         FakerLibrary
Library                         String
Library                         BuiltIn
Library                         DateTime
Resource                        ../PageObjects/Freberg_Common.robot



*** Keywords ***


Generate Document on Policy
    #Author=Amol Gaymukhe
    [Documentation]             Close and Reopen
    [Arguments]                 ${doc_type}

    Sleep                       15s
    ${value}=                   Set Variable                1
    Log To Console              ${value}
    FOR                         ${value}                    IN RANGE                    3
        ClickText               Policy Document
        Sleep                   5s
        #ClickElement           //span[text()\='Close this window']
        ClickElement            //span[text()\='Cancel and close']
        RefreshPage
        ${value}=               Set Variable                ${value}+1
    END

    # CssSelectors              on
    # ClickText                 option[value\='CompletePolicy']                         value
    # Log To Console            ${value}
    # CssSelectors              off

    # DropDown                  Document Type               Policy                      timeout=30s
    # ClickElement              //select
    # VerifyText                Binder


    ClickText                   Policy Document
    UseModal                    On
    VerifyText                  Generate Policy Document
    DropDown                    Document Type               ${doc_type}                 timeout=30s
    ClickText                   Generate                    anchor=Cancel
    VerifyText                  Success                     anchor=Document has been generated sucessfully!         timeout=120s
    Sleep                       60s
    UseModal                    Off



Change Policy
    #Author = Amol Gaymukhe
    [Documentation]             Change Policy
    [Arguments]                 ${change_policy_type}

    ClickText                   Change Policy
    UseModal                    On
    VerifyText                  New Endorsement
    DropDown                    Endorsement Type            ${change_policy_type}


Select Amendment Input
    #Author = Amol Gaymukhe
    ${amendment_date}=          Get Current Date            increment=15 day            result_format=%b %-d, %Y
    Log To Console              ${amendment_date}
    #TypeText                   Cancellation Date*          ${amendment_date}
    TypeText                    Endorsement Effective Date                              ${amendment_date}
    ClickText                   Confirm                     anchor=Back
    Sleep                       30s


Select Midterm Cancellation Input 
    #Author = Amol Gaymukhe
    [Documentation]             Midterm Cancellation Input

    ${Midterm_date}=            Get Current Date            increment=15 day            result_format=%b %-d, %Y
    Log To Console              ${Midterm_date}
    TypeText                    Cancellation Date*          ${Midterm_date}
    ClickText                   Confirm                     anchor=Back
    Sleep                       10s
    VerifyText                  Cancelled                   anchor=Policy Status



Select Flat Cancellation Input
    #Author = Amol Gaymukhe
    [Documentation]             Flat Cancellation Input

    ${flatcanc_date}=           Get Current Date            increment=15 day            result_format=%b %-d, %Y
    Log To Console              ${flatcanc_date}
    TypeText                    Cancellation Date*          ${flatcanc_date}
    ClickText                   Confirm                     anchor=Back
    Sleep                       15s
    VerifyText                  Cancelled                   anchor=Policy Status

Select Reinstatment Input
    #Author = Amol Gaymukhe
    [Documentation]             Reinstatment Input

    ClickText                   Confirm                     anchor=Back
    Sleep                       15s
    VerifyText                  Bound                       anchor=Policy Status

Select ERP Input
    #Author = Amol Gaymukhe
    [Documentation]             ERP Input

    Usemodal                    On
    TypeText                    *Additional Premium         350
    MultiPickList               *Select Coverage Parts      Professional Liability      action=Move to
    ClickText                   Confirm                     anchor=Back
    Sleep                       15s
    #VerifyText                 Bound                       anchor=Policy Status

Select ERP Input For STEIL
    #Author = Amol Gaymukhe
    [Documentation]             ERP Input

    Usemodal                    On
    TypeText                    *Additional Premium         350
    MultiPickList               *Select Coverage Parts      STEIL                       action=Move to
    ClickText                   Confirm                     anchor=Back
    Sleep                       15s

Select Extension Input
    #Author = Amol Gaymukhe
    [Documentation]             Extension Input
    ClickText                   Confirm                     anchor=Back
    Sleep                       15s
    VerifyText                  Bound                       anchor=Policy Status

Select Cancel & Replace Input
    #Author = Amol Gaymukhe
    [Documentation]             Cancel & Replace

    ClickElement                //span[text()\='Select Item 1']
    ClickText                   Confirm                     anchor=Back
    Sleep                       2s
    ClickText                   Confirm                     anchor=Cancel
    # ${flatcanc_date}=         Get Current Date            increment=15 day            result_format=%b %-d, %Y
    # Log To Console            ${flatcanc_date}
    # TypeText                  Endorsement Effective Date*                             ${flatcanc_date}
    # ClickText                 Confirm                     anchor=Back
    # Sleep                     15s




Click On renewal
    #Author = Amol Gaymukhe
    [Documentation]             Renewal Input
    ClickText                   Renewal                     anchor=Edit                 partial_match=false
    VerifyText                  Renewal Opportunity is created successfully!            anchor=Success              timeout=120s
    Sleep                       10s


Verify Renewal Status
    #Author = Amol Gaymukhe
    [Documentation]             Renewal Status
    ClickText                   Related                     anchor=Add On Policies
    VerifyText                  Renewal                     anchor=Type



Click On Policy and Download
    #Amol Gaymukhe
    ClickElement                //article[contains(@aria-label,'PolicyForm')]//a
    VerifyText                  View Document
    ClickText                   View Document
    VerifyText                  Success                     anchor=Document has been downloaded sucessfully!


Click On Binder and Download
    #Amol Gaymukhe
    ClickElement                //article[contains(@aria-label,'Binder')]//a
    VerifyText                  View Document
    ClickText                   View Document
    VerifyText                  Success                     anchor=Document has been downloaded sucessfully!



Get Policy No 
    #Amol Gaymukhe
    ${PolicyNo}=                GetText                     //p[text()\='Policy Number']/parent::div//lightning-formatted-text
    Log To Console              ${PolicyNo}
    Set Global Variable         ${PolicyNo}

Select Amendment Input Trucking
    #Author = Amol Gaymukhe
    ${amendment_date1}=         GetText                     //p[text()\='Effective Date']/parent::div//lightning-formatted-text    result_format=datetime
    Log To Console              ${amendment_date1}
    ${to1}=                     Convert Date                ${amendment_date1}          date_format=%m/%d/%Y
    ${to2}=                     Convert Date                ${to1}                      result_format=%b %-d, %Y
    ${to3}=                     Add Time To Date            ${to1}                      7 days
    Log To Console              ${to3}
    ${amendment_date}=          Convert Date                ${to3}                      result_format=%b %-d, %Y
    #TypeText                   Cancellation Date*          ${amendment_date}
    TypeText                    Endorsement Effective Date                              ${amendment_date}
    ClickText                   Confirm                     anchor=Back
    Sleep                       30s


Select Amendment Input Trucking Excess
    #Author = Amol Gaymukhe
    [Arguments]                 ${amendment_date1}
    ${to1}=                     Convert Date                ${amendment_date1}          date_format=%m/%d/%Y
    ${to2}=                     Convert Date                ${to1}                      result_format=%b %-d, %Y
    ${to3}=                     Add Time To Date            ${to1}                      7 days
    Log To Console              ${to3}
    ${amendment_date}=          Convert Date                ${to3}                      result_format=%b %-d, %Y
    #TypeText                   Cancellation Date*          ${amendment_date}
    TypeText                    Endorsement Effective Date                              ${amendment_date}
    ClickText                   Confirm                     anchor=Back
    Sleep                       30s

Select Flat Cancellation Input Trucking
    #Author = Amol Gaymukhe
    # ${amendment_date1}=       GetInputValue               Cancellation Date
    # Log To Console            ${amendment_date1}
    # ${to2}=                   Convert Date                ${amendment_date1}          result_format=%b %-d, %Y
    # ${to3}=                   Add Time To Date            ${to2}                      7 days
    # ${amendment_date}=        Convert Date                ${to3}                      result_format=%b %-d, %Y
    #TypeText                   Cancellation Date*          ${amendment_date}
    ClickText                   Confirm                     anchor=Back
    Sleep                       30s


Select Midterm Cancellation Input Trucking
    #Author = Amol Gaymukhe
    ${amendment_date1}=         GetText                     //p[text()\='Effective Date']/parent::div//lightning-formatted-text    result_format=datetime
    Log To Console              ${amendment_date1}
    ${to1}=                     Convert Date                ${amendment_date1}          date_format=%m/%d/%Y
    ${to2}=                     Convert Date                ${to1}                      result_format=%b %-d, %Y
    ${to3}=                     Add Time To Date            ${to1}                      7 days
    Log To Console              ${to3}
    ${amendment_date}=          Convert Date                ${to3}                      result_format=%b %-d, %Y
    #TypeText                   Cancellation Date*          ${amendment_date}
    TypeText                    Cancellation Date*          ${amendment_date}
    ClickText                   Confirm                     anchor=Back
    Sleep                       30s

Midterm Cancellation Flow Complete Trucking
    #Author = Amol Gaymukhe
    ClickText                   NEXT:Underwriting Console >
    VerifyText                  Excess Rating
    ClickText                   NEXT:Quote Console >

Renewal Flow Complete Trucking
    #Author = Amol Gaymukhe
    ClickText                   NEXT:Underwriting Console >
    VerifyText                  Excess Rating
    ClickText                   Rate                        anchor=Save
    VerifyText                  Success                     anchor=Rated Successfully!                              timeout=30s
    Update All Subjectivities
    Sleep                       5s
    ClickText                   Save                        anchor=Rate
    ClickText                   NEXT:Quote Console >

Add Policy
    #Author = Akshay Verma
    [Documentation]             Add Policy
    [Arguments]                 ${change_Add_policy}

    ClickText                   Add Policy
    UseModal                    On
    VerifyText                  Add Policy
    DropDown                    Policy Type                 ${change_Add_policy}


Send Mail On Policy Page
    #Author=Amol
    [Documentation]             Sending Mail From Submission Page
    [Tags]                      Validating
    [Arguments]                 ${Mailtype}
    ClickText                   Send Email
    UseModal                    On
    ClickElement                //select

    # #ClickText                Binder Transmittal
    IF                          "${Mailtype}"=="90 Day Clearance"
        DropDown                Select a Template:          [[1]]
    ELSE IF                     "${Mailtype}"=="Binder Email"
        DropDown                Select a Template:          [[2]]
    ELSE IF                     "${Mailtype}"=="Endorsement Email"
        DropDown                Select a Template:          [[3]]
    ELSE IF                     "${Mailtype}"=="FEI Quote Declaration Email Template"
        DropDown                Select a Template:          [[4]]
    ELSE IF                     "${Mailtype}"=="Indication Email"
        DropDown                Select a Template:          [[5]]
    ELSE IF                     "${Mailtype}"=="Policy Email"
        DropDown                Select a Template:          [[6]]
    ELSE IF                     "${Mailtype}"=="Quote Email"
        DropDown                Select a Template:          [[7]]
    ELSE IF                     "${Mailtype}"=="Second Sub notification"
        DropDown                Select a Template:          [[8]]
    ELSE IF                     "${Mailtype}"=="SOA Email"
        DropDown                Select a Template:          [[9]]
    END
    ${subjectline}=             GetInputValue               Subject:                    timeout=45s
    Log To Console              ${subjectline}
    Set Global Variable         ${subjectline}
    
    ClickText                   Send                        anchor=Cancel
    Sleep                       40s
    ${body}=                    Get Email Content           ${client_id_mail}           ${client_secret_mail}       ${tenant_id}    QA.Testing.Inbox@innovisk.global              ${subjectline}
    Log To Console              ${body}
    Set Global Variable         ${body}
    Log To Console              --------Send Email for ${Mailtype} is successfull------


Enter OCP Data
    #Author = Akshay Verma
    [Documentation]             Enter OCP Data
    [Arguments]                 ${Tria_dropdown}

    VerifyText                  Initial Data Entry
    ${OCP_Insured_name}=        First Name Nonbinary
    TypeText                    RRP/OCP Insured Name        ${OCP_Insured_name} Testdata
    ${OCP_Street}=              Street Address
    TypeText                    RRP/OCP Street              ${OCP_Street}
    ${OCP_City}=                City
    TypeText                    RRP/OCP City                ${OCP_City}
    PickList                    State                       CO
    ${OCP_Zipcode}=             Postcode
    TypeText                    RRP/OCP Zip Code            ${OCP_Zipcode}
    ${OCP_Project_Location}=    Street Name
    TypeText                    RRP/OCP Project Location    ${OCP_Project_Location}
    ${Description_of_opertion}=                             Address
    TypeText                    Description of Operations                               ${Description_of_opertion}
    ${Occurence_limit}=         Random Digit
    TypeText                    RRP/OCP Occurrence Limit    ${Occurence_limit}
    ${Aggregate_Limit}=         Random Digit
    TypeText                    RRP/OCP Aggregate Limit     ${Aggregate_Limit}
    ${Deductible}=              Random Digit
    TypeText                    RRP/OCP Deductible          ${Deductible}
    ClickElement                //span[text()\="--None--"]                              anchor=Tria
    Sleep                       2s
    ClickText                   Yes                         anchor=Tria
    ${Rateper_1000_Gross_Receipts}=                         Random Digit Above Two
    TypeText                    RRP/OCP Rate per $1000 Gross Receipts                   ${Rateper_1000_Gross_Receipts}
    ${Estimate_Gross_Receipts}=                             Random Digit Above Two
    TypeText                    RRP/OCP Estimated Gross Receipts                        ${Estimate_Gross_Receipts}
    ${Commission%}=             Random Digit
    TypeText                    Commission %                ${Commission%}
    ${OCP/RRP_Premium}=         Random Digit Above Two
    TypeText                    OCP/RRP Premium             ${OCP/RRP_Premium}
    ${Policy_fee}=              Random Digit Above Two
    TypeText                    Policy Fee                  ${Policy_fee}
    ${State_Fee}=               Random Digit Above Two
    TypeText                    State Fees                  ${State_Fee}

Enter RRP Data
    #Author = Akshay Verma
    [Documentation]             Enter RRP Data
    [Arguments]                 ${Tria_dropdown}

    VerifyText                  Initial Data Entry
    ${RRP_Insured_name}=        First Name Nonbinary
    TypeText                    RRP/OCP Insured Name        ${RRP_Insured_name} Testdata
    ${RRP_Street}=              Street Address
    TypeText                    RRP/OCP Street              ${RRP_Street}
    ${RRP_City}=                City
    TypeText                    RRP/OCP City                ${RRP_City}
    PickList                    State                       CO
    ${RRP_Zipcode}=             Postcode
    TypeText                    RRP/OCP Zip Code            ${RRP_Zipcode}
    ${RRP_Project_Location}=    Street Name
    TypeText                    RRP/OCP Project Location    ${RRP_Project_Location}
    ${Description_of_opertion}=                             Address
    TypeText                    Description of Operations                               ${Description_of_opertion}
    ${Occurence_limit}=         Random Digit
    TypeText                    RRP/OCP Occurrence Limit    ${Occurence_limit}
    ${Aggregate_Limit}=         Random Digit
    TypeText                    RRP/OCP Aggregate Limit     ${Aggregate_Limit}
    ${Deductible}=              Random Digit
    TypeText                    RRP/OCP Deductible          ${Deductible}
    ClickElement                //span[text()\="--None--"]                              anchor=Tria
    Sleep                       2s
    ClickText                   Yes                         anchor=Tria
    ${Involved_Government_Authority_Name}=                  First Name Nonbinary
    TypeText                    Involved Governmental Authority Name                    ${Involved_Government_Authority_Name}TestData
    ${Involved_Government_Authority_Address}=               Address
    TypeText                    Involved Governmental Authority Address                 ${Involved_Government_Authority_Address}
    ${Involved_Government_Authority_City}=                  City
    TypeText                    Involved Governmental Authority City                    ${Involved_Government_Authority_City}
     ${Involved_Government_Authority_State}=                  Street Address
    TypeText                    Involved Governmental Authority State                    ${Involved_Government_Authority_State}
     ${Involved_Government_Authority_Zipcode}=                  Postcode
    TypeText                    Involved Governmental Authority Zip                    ${Involved_Government_Authority_Zipcode}
    ${Rateper_1000_Gross_Receipts}=                         Random Digit Above Two
    TypeText                    RRP/OCP Rate per $1000 Gross Receipts                   ${Rateper_1000_Gross_Receipts}
    ${Estimate_Gross_Receipts}=                             Random Digit Above Two
    TypeText                    RRP/OCP Estimated Gross Receipts                        ${Estimate_Gross_Receipts}
    ${Commission%}=             Random Digit
    TypeText                    Commission %                ${Commission%}
    ${OCP/RRP_Premium}=         Random Digit Above Two
    TypeText                    OCP/RRP Premium             ${OCP/RRP_Premium}
    ${Policy_fee}=              Random Digit Above Two
    TypeText                    Policy Fee                  ${Policy_fee}
    ${State_Fee}=               Random Digit Above Two
    TypeText                    State Fees                  ${State_Fee}