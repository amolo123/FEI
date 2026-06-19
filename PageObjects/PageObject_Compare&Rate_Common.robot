*** Settings ***
Library                        QWeb
Library                        QForce
Library                        FakerLibrary
Library                        String
Library                        BuiltIn
Library                        DateTime
Resource                       ../resources/common.robot
Resource                       ../tests/ECC/InsuredInfo_ECC.robot
Resource                       Freberg_Common.robot


Library                        ../libraries/MailLib.py     ${tenant_id}                ${client_id_mail}        ${client_secret_mail}

Library                        ../libraries/graph.py
Resource                       ../resources/graph.resource

*** Variables ***


*** Keywords ***

Click On Endorsement
    #Author=Amol Gaymukhe
    ClickElement               //lightning-icon[@title\='Endorsements & Subjectivities']

Clone Quote Click
    #Author=Amol Gaymukhe
    [Documentation]            Clone Quote Click

    ClickElement               //button[@title\='clone']
    #VerifyText                Success                     anchor=Rate Successfully    timeout=45s
    Log To Console             ----- Clone quote Successfully ------

Click on New Quote  
    #Author=Amol Gaymukhe
    [Documentation]            Click on new quote

    ClickElement               (//button[text()\='New Quote'])
    VerifyText                 Success                     anchor=Rate Successfully    timeout=45s
    Log To Console             ----- Compare and rate quote fields validated Successfully ------


Click on Edit Quote
    #Author=Amol Gaymukhe
    [Documentation]            Click on new quote

    ClickElement               //button[@title\='Edit']
    ClickText                  Confirm                     anchor=Cancel
    Log To Console             ----- Edit Quote Successfully ------

Click on Rate Quote
    #Author=Amol Gaymukhe
    [Documentation]            Click on rate quote

    ClickElement               //button[text()\='Rate']
    Sleep                      5s
    ${Con}=                    IsText                      Confirmation                anchor=Confirm
    IF                         "${Con}" == "True"
        ClickText              Confirm                     anchor=Cancel
        VerifyText             Success                     anchor=Rating sucessfully!                           timeout=60s
    ELSE
        VerifyText             Success                     anchor=Rating sucessfully!                           timeout=60s
    END
    Sleep                      30s
    #RefreshPage
    Log To Console             ----- Rate Quote Successfully ------

Click on Rate Quote after amendment
    #Author=Amol Gaymukhe
    [Documentation]            Click on rate quote

    ClickElement               (//button[text()\='Rate'])[last()]
    #ClickText                 Confirm                     anchor=Cancel
    VerifyText                 Success                     anchor=Rating sucessfully!                           timeout=60s
    Log To Console             ----- Rate Quote Successfully ------




Click on Finalize Quote
    #Author=Amol Gaymukhe
    [Documentation]            Click on Finalize quote

    ClickElement               //lightning-icon[@title\='Finalize Quote']
    VerifyText                 Success                     anchor=Finalize quote sucessfully!                   timeout=60s
    Log To Console             ----- Finalize quote Successfully ------



Click on Finalize Quote after amendment
    #Author=Amol Gaymukhe
    [Documentation]            Click on Finalize quote

    ClickElement               (//lightning-icon[@title\='Finalize Quote'])[last()]
    VerifyText                 Success                     anchor=Finalize quote sucessfully!                   timeout=60s
    Log To Console             ----- Finalize quote Successfully ------


Verify Retroactive date Message when it is Blank
    #Author=Amol Gaymukhe
    [Documentation]            Enter Retroactive Date
    ClickElement               //lightning-icon[@title\='Finalize Quote']
    VerifyText                 Error                       anchor=Retroactive Date should not be blank when Retroactive Date Option is other then occurence          timeout=60s
    Log To Console             ----- Retroactive date Message validated Successfully ------

Enter Retroactive date
    #Author=Amol Gaymukhe
    [Documentation]            Enter Retroactive Date

    ClickElement               //input[contains(@name,'-PL Retroactive Date')]
    ClickText                  Previous Month
    ClickText                  16                          partial_match=false
    #TypeText                  //input[contains(@name,'-PL Retroactive Date')]         5//10/2024
    Log To Console             ----- Retroactive date Entered Successfully ------
    Click On Save
    Sleep                      10s

Click On Save
    #Author=Amol Gaymukhe
    # ClickElement             //button[@title\='Save']
    # UseModal                 On
    # ClickText                Confirm                     anchor=Cancel
    # UseModal                 Off
    # Log To Console           ----- save on quote Successfully ------

    ClickElement               //button[@title\='Save']
    Sleep                      5s
    ${Con}=                    IsText                      Confirmation                anchor=Confirm
    IF                         "${Con}" == "True"
        ClickText              Confirm                     anchor=Cancel
        VerifyText             Success                     anchor=Update records successfully!                  timeout=60s
    ELSE
        VerifyText             Success                     anchor=Update records successfully!                  timeout=60s
    END
    Log To Console             ----- save on quote Successfully ------

Enter Value in Credit Debit Factor
    #Author=Amol Gaymukhe
    TypeText                   //input[contains(@name,'-Qualifications')]              10
    TypeText                   //input[contains(@name,'-Loss Experience')]             10
    TypeText                   //input[contains(@name,'-Other')]                       10
    TypeText                   //input[contains(@name,'-Financial Status')]            10
    Log To Console             ----- Credit Debit Factor Entered Successfully ------


Enter Value in Primary Policy fees and Primary Loss Control Fees
    #Author=Amol Gaymukhe
    TypeText                   //input[contains(@name,'-Primary Policy Fees')]         150
    TypeText                   //input[contains(@name,'-Primary Loss Control Fees')]                            200
    Log To Console             ----- Primary Policy Fees and Loss Control Fees added Successfully ------


Enter Value in Excess Credit Debit Factor
    #Author=Amol Gaymukhe
    TypeText                   //input[contains(@name,'-Catastrophe')]                 10
    TypeText                   //input[contains(@name,'-Underlying Policy Form')]      10
    TypeText                   //input[contains(@name,'-Mgmt')]                        10
    TypeText                   //input[contains(@name,'-Financial Mgmt')]              10
    Log To Console             ----- Enter value in Excess Credit debit factor Successfully ------


Close Quote
    #Author=Amol Gaymukhe
    [Documentation]            Closing the Quote
    [Arguments]                ${no}
    RefreshPage
    ClickElement               (//lightning-button-menu[@variant\='border-filled'])[${no}]
    #ClickElement              (//lightning-button-menu[@variant\='border-filled'])[2]                          timeout=10s
    ClickText                  Close Quote
    PickList                   Closed Reason               Another version bound
    ClickText                  Yes                         anchor=No
    Log To Console             ----- Close Quote Successfull -----

Enter Value in Credit Debit Factor after amendment
    #Author=Amol Gaymukhe
    TypeText                   (//input[contains(@name,'-Qualifications')])[4]         10
    TypeText                   (//input[contains(@name,'-Loss Experience')])[4]        10
    TypeText                   (//input[contains(@name,'-Other')])[4]                  10
    TypeText                   (//input[contains(@name,'-Financial Status')])[4]       10


Generate Primary or Excess Document
    #Author=Amol Gaymukhe
    [Documentation]            Generating Document
    [Arguments]                ${type_doc}

    Sleep                      15s
    ClickText                  ${type_doc}
    VerifyText                 Success                     anchor=Document generated successfully!              timeout=60s
    Log To Console             ----- ${type_doc} is successful------
    Sleep                      60s



Generate Factor Summary Document from Dropdown Menu 
    #Author=Amol Gaymukhe
    [Documentation]            Generating Document

    ClickElement               (//lightning-button-menu[@variant\='border-filled'])[1]
    #ClickElement              (//lightning-button-menu[@variant\='border-filled'])[2]                          timeout=10s
    ClickText                  Factor Summary
    UseModal                   On
    VerifyText                 Current Value
    ClickElement               (//lightning-icon[@icon-name\='utility:close'])
    Usemodal                   Off
    Log To Console             ----- Factor Summary Document is successful------

Generate Specimen Policy Document from Dropdown Menu 
    #Author=Amol Gaymukhe
    [Documentation]            Generating Document
    [Arguments]                ${type}
    #RefreshPage
    ClickElement               (//lightning-button-menu[@variant\='border-filled'])[1]
    #ClickElement              (//lightning-button-menu[@variant\='border-filled'])[2]                          timeout=10s
    ClickText                  Generate Specimen Policy
    UseModal                   On
    VerifyText                 Select Layer Type
    IF                         '${type}'=='Primary'
        ClickElement           //input[@value\='Primary']
    ELSE
        ClickElement           //input[@value\='Excess']
    END
    ClickText                  Continue                    anchor=Cancel
    Usemodal                   Off

    VerifyText                 Success                     anchor=Generate document is success!                 timeout=90s
    Log To Console             ----- Specimen Policy Document is successful------

Generate Rating Summary Document from Dropdown Menu  
    #Author=Amol Gaymukhe
    [Documentation]            Generating Document
    [Arguments]                ${type}
    #RefreshPage
    ClickElement               (//lightning-button-menu[@variant\='border-filled'])[1]
    #ClickElement              (//lightning-button-menu[@variant\='border-filled'])[2]                          timeout=10s
    ClickText                  Generate Rating Summary
    UseModal                   On
    VerifyText                 Select Layer Type
    IF                         '${type}'=='Primary'
        ClickElement           //input[@value\='Primary']
    ELSE
        ClickElement           //input[@value\='Excess']
    END
    ClickText                  Continue                    anchor=Cancel
    Usemodal                   Off
    VerifyText                 Success                     anchor=Generate document is success!                 timeout=60s
    Log To Console             ----- RAting Summary Document is successful------

Generate Calclog Document from Dropdown Menu 
    #Author=Amol Gaymukhe
    [Documentation]            Generating Document
    #RefreshPage
    ClickElement               (//lightning-button-menu[@variant\='border-filled'])[1]
    ClickText                  Generate Calc log
    VerifyText                 Success                     anchor=Generate Cal log is success!                  timeout=60s
    Log To Console             ----- CalcLog Document generation is successful------

Select Endorsements
    #Author=Amol Gaymukhe
    [Documentation]            Selecting Endorsements

    ClickElement               //lightning-icon[@title\='Endorsements & Subjectivities']
    UseModal                   On
    ClickText                  Or Select a Category
    ClickText                  Exclusions

    ClickElement               //span[text()\='Select Item 1']
    ClickElement               //span[text()\='Select Item 2']
    ClickElement               //button[@title\='Add']
    VerifyText                 Success                     anchor=The data is saved successfully
    ClickText                  Save                        anchor=Return Quote Process
    ClickText                  Return Quote Process
    Log To Console             ----- Endorsements selected successful------



Select Endorsements after Amendment
    #Author=Amol Gaymukhe
    [Documentation]            Selecting Endorsements

    ClickElement               (//lightning-icon[@title\='Endorsements & Subjectivities'])[last()]
    UseModal                   On
    ClickText                  Or Select a Category
    ClickText                  Exclusions

    ClickElement               //span[text()\='Select Item 1']
    ClickElement               //span[text()\='Select Item 2']
    ClickElement               //button[@title\='Add']
    VerifyText                 Success                     anchor=The data is saved successfully
    ClickText                  Save                        anchor=Return Quote Process
    ClickText                  Return Quote Process
    Log To Console             ----- Endorsements selected successful------



Enter Tria Selection Yes
    #Author=Amol Gaymukhe
    [Documentation]            Tria Selection Yes
    ClickElement               //button[contains(@name,'-TRIA selection')]
    ClickElement               //lightning-base-combobox-item[@data-value\='Yes']
    Log To Console             --------Enter Tria Selection Yes Successfully-----------

Enter Tria Selection No
    #Author=Akshay Verma
    [Documentation]            Tria Selection No
    ClickElement               //button[contains(@name,'-TRIA selection')]
    ClickElement               //lightning-base-combobox-item[@data-value\='No']
    Log To Console             --------Enter Tria Selection No Successfully-----------

Enter Excess Tria Selection Yes
    #Author=Amol Gaymukhe
    [Documentation]            Tria Selection Yes
    ClickElement               //button[contains(@name,'-Excess TRIA selection')]
    ClickElement               //lightning-base-combobox-item[@data-value\='Yes']

Enter Excess Tria Selection No    
    #Author=Akshay Verma
    [Documentation]            Tria Selection No
    ClickElement               //button[contains(@name,'-Excess TRIA selection')]
    ClickElement               //lightning-base-combobox-item[@data-value\='No']


Check Tria Premium After Yes    
    #Author=Amol Gaymukhe
    [Documentation]            Check Tria Premium after Yes

    ${tria_premium}=           GetInputValue               //input[contains(@name,'-Tria Premium')]
    Log To Console             ${tria_premium}
    IF                         "${tria_premium}" == "$250.00"
        Log To Console         Success Premium is $250.00
    ELSE
        Fail
    END

Check Tria Premium After No    
    #Author=Amol Gaymukhe
    [Documentation]            Check Tria Premium after No

    ${tria_premium}=           GetInputValue               //input[contains(@name,'-Tria Premium')]
    Log To Console             ${tria_premium}
    IF                         '${tria_premium}' == '$0.00'
        Log To Console         Success Tria Premium is $0.00
    ELSE
        Fail
    END
Check Tria Premium and Excess Tria Premium After No
    #Author=Amol Gaymukhe
    [Documentation]            Check Tria Premium and Excess Tria premium after No

    ${tria_premium}=           GetInputValue               //input[contains(@name,'-Tria Premium')]
    Log To Console             ${tria_premium}
    IF                         '${tria_premium}' == '$0.00'
        Log To Console         Success Tria Premium is $0.00
    ELSE
        Fail
    END

    ${excess_tria_premium}=    GetInputValue               //input[contains(@name,'-Excess Tria Premium')]
    Log To Console             ${excess_tria_premium}
    IF                         '${excess_tria_premium}' == '$0.00'
        Log To Console         Success Excess Tria Premium is $0.00
    ELSE
        Fail
    END


Check Tria Premium and Excess Tria Premium After Yes
    #Author=Amol Gaymukhe
    ${tria_premium}=           GetInputValue               //input[contains(@name,'-Tria Premium')]
    Log To Console             ${tria_premium}
    IF                         '${tria_premium}' == '$250.00'
        Log To Console         Success Tria Premium is $250.00
    ELSE
        Fail
    END

    ${excess_tria_premium}=    GetInputValue               //input[contains(@name,'-Excess Tria Premium')]
    Log To Console             ${excess_tria_premium}
    IF                         '${excess_tria_premium}' == '$250.00'
        Log To Console         Success Excess Tria Premium is $250.00
    ELSE
        Fail
    END

Check Tria Premium Yes and Excess Tria Premium No          
    #Author=Akshay Verma
    ${tria_premium}=           GetInputValue               //input[contains(@name,'-Tria Premium')]
    Log To Console             ${tria_premium}
    IF                         '${tria_premium}' == '$250.00'
        Log To Console         Success Tria Premium is $250.00
    ELSE
        Fail
    END

    ${excess_tria_premium}=    GetInputValue               //input[contains(@name,'-Excess Tria Premium')]
    Log To Console             ${excess_tria_premium}
    IF                         '${excess_tria_premium}' == '$0.00'
        Log To Console         Success Excess Tria Premium is $0.00
    ELSE
        Fail
    END
Check Tria Premium No and Excess Tria Premium Yes          
    #Author=Akshay Verma
    ${tria_premium}=           GetInputValue               //input[contains(@name,'-Tria Premium')]
    Log To Console             ${tria_premium}
    IF                         '${tria_premium}' == '$0.00'
        Log To Console         Success Tria Premium is $0.00
    ELSE
        Fail
    END

    ${excess_tria_premium}=    GetInputValue               //input[contains(@name,'-Excess Tria Premium')]
    Log To Console             ${excess_tria_premium}
    IF                         '${excess_tria_premium}' == '$250.00'
        Log To Console         Success Excess Tria Premium is $250.00
    ELSE
        Fail
    END


Rate Correction Quote
    #Author=Amol Gaymukhe
    [Documentation]            Correction quote
    RefreshPage
    Sleep                      10s
    RefreshPage
    ClickElement               (//button[text()\='Rate']/parent::lightning-button)[3]
    VerifyText                 Success                     anchor=Rating sucessfully!                           timeout=60s


Click on Finalize Quote after Cancel and Replace
    #Author=Amol Gaymukhe
    [Documentation]            Click on Finalize quote

    ClickElement               (//lightning-icon[@title\='Finalize Quote'])[3]
    VerifyText                 Success                     anchor=Finalize quote sucessfully!                   timeout=60s

Click On Bind
    #Author=Amol Gaymukhe
    ClickElement               //button[@title\='Bind']
    Usemodal                   On
    VerifyText                 Bind Quote
    ClickElement               //span[text()\='Bind']
    ClickText                  Bind                        anchor=Cancel
    Usemodal                   Off
    VerifyText                 Success                     anchor=Bind quote sucessfully!
    Sleep                      120s
    RefreshPage
    Log To Console             ----- Bind is successful------


Click On Bind After Cancel and Replace
    [Documentation]            Click On Bind

    ClickElement               //button[@title\='Bind']
    Usemodal                   On
    VerifyText                 Bind Quote
    ClickElement               (//button[text()\='Bind'])[last()]
    ClickText                  Bind                        anchor=Cancel
    Usemodal                   Off
    VerifyText                 Success                     anchor=Bind quote sucessfully!
Click On Bind after amendment
    #Author=Amol Gaymukhe
    ClickElement               //button[@title\='Bind']
    Usemodal                   On
    VerifyText                 Bind Quote
    ClickElement               (//button[text()\='Bind'])[last()]
    ClickText                  Bind                        anchor=Cancel
    Usemodal                   Off
    VerifyText                 Success                     anchor=Bind quote sucessfully!
    Log To Console             ----- Bind is successful------

Send Mail On Submission Page
    #Author=Amol
    [Documentation]            Sending Mail From Submission Page
    [Tags]                     Validating
    [Arguments]                ${Mailtype}
    ClickText                  Send Mail
    UseModal                   On
    ClickElement               //select

    # #ClickText               Binder Transmittal
    IF                         "${Mailtype}"=="90 Day Clearance"
        DropDown               Select a Template:          [[1]]
    ELSE IF                    "${Mailtype}"=="Endorsement Email"
        DropDown               Select a Template:          [[2]]
    ELSE IF                    "${Mailtype}"=="FEI Quote Declaration Email Template"
        DropDown               Select a Template:          [[3]]
    ELSE IF                    "${Mailtype}"=="Indication Email"
        DropDown               Select a Template:          [[4]]
    ELSE IF                    "${Mailtype}"=="Policy Email"
        DropDown               Select a Template:          [[5]]
    ELSE IF                    "${Mailtype}"=="Quote Email"
        DropDown               Select a Template:          [[6]]
    ELSE IF                    "${Mailtype}"=="Second Sub notification"
        DropDown               Select a Template:          [[7]]
    ELSE IF                    "${Mailtype}"=="SOA Email"
        DropDown               Select a Template:          [[8]]
    END
    ${subjectline}=            GetInputValue               Subject:                    timeout=45s
    Log To Console             ${subjectline}
    Set Global Variable        ${subjectline}
    ClickText                  Send                        anchor=Cancel
    Sleep                      40s
    ${body}=                   Get Email Content           ${client_id_mail}           ${client_secret_mail}    ${tenant_id}             QA.Testing.Inbox@innovisk.global              ${subjectline}
    #Log To Console            ${body}
    Set Global Variable        ${body}
    Log To Console             --------Send Email for ${Mailtype} is successfull------

Enter Data In Flat Premium
    #Author=Amol Gaymukhe
    TypeText                   //input[contains(@name,'-Flat Premium')]                3000

Click on Loss Detail
    [Arguments]                ${Loss_Detail_name}         ${Claim_type}               ${StatusType}            ${CoverageProduct}       ${TotalLosses}              ${LossYear}
    #Author=Akshay Verma
    [Documentation]            Click on Loss Detail
    UseModal                   On
    VerifyText                 Loss Detail Name
    TypeText                   Loss Detail Name            ${Loss_Detail_name}
    TypeText                   Claims Count                ${Claim_type}
    PickList                   Status                      ${StatusType}
    PickList                   Coverage Product            ${CoverageProduct}
    TypeText                   Total Losses                ${TotalLosses}
    TypeText                   Loss Year                   ${LossYear}


Add Free Form Endorsement 
    #Author=Amol Gaymukhe
    [Documentation]            Click On Bind

    ClickText                  Free Form Endorsements      anchor=Endorsements
    ClickElement               //button[text()\='New']
    TypeText                   Endorsement Name            Test Endorsement 123
    ClickElement               //div[@part\='rich-text-editor-textarea']/div
    TypeText                   //div[@part\='rich-text-editor-textarea']/div           Test comment
    ClickText                  Save                        anchor=Cancel
    ClickText                  Save                        anchor=Return Quote Process
    ClickText                  Return Quote Process

Validate premium is increased after flat premium  
    #Author=Amol Gaymukhe

    ${bef_var_cleaned}=        Replace String              ${bef_var_pf}               ,                        ''
    ${af_var_cleaned}=         Replace String              ${af_var_pf}                ,                        ''
    ${bef_num}=                Evaluate                    float('${bef_var_cleaned}')
    ${af_num}=                 Evaluate                    float('${af_var_cleaned}')
    IF                         ${bef_num} >= ${af_num}
        Log To Console         Premium is not increased
        Fail
    ELSE
        Log To Console         Premium is increased -- Success
    END

Check Primary Quote Premium after flat input
    #Author=Amol Gaymukhe
    ${praf_qprem}=             GetInputValue               (//input[contains(@name,'-Primary Quote Premium')])[last()]
    ${af_var_pf}=              Remove String               ${praf_qprem}               $                        ,
    Log To Console             ${af_var_pf}
    Set Global Variable        ${af_var_pf}

Check Primary Quote Premium before flat input
    #Author=Amol Gaymukhe
    ${prbef_qprem}=            GetInputValue               (//input[contains(@name,'-Primary Quote Premium')])[last()]
    ${bef_var_pf}=             Remove String               ${prbef_qprem}              $
    Log To Console             ${bef_var_pf}
    Set Global Variable        ${bef_var_pf}

Select Endorsement on Amendment
    #Author=Amol Gaymukhe
    [Documentation]            Selecting Endorsements on Amendments

    ClickElement               (//lightning-icon[@title\='Endorsements & Subjectivities'])[last()]
    UseModal                   On
    ClickElement               //input[@name\='enter-search']
    TypeText                   //input[@name\='enter-search']                          Additional
    PressKey                   //input[@name\='enter-search']                          {ENTER}

    ClickElement               //span[text()\='Select Item 1']
    ClickElement               //button[@title\='Add']
    VerifyText                 Success                     anchor=The data is saved successfully
    UseTable                   S.No.
    ${rno}=                    GetTableRow                 Additional Insured - Controlling Interest
    ${exactrow}=               Evaluate                    ${rno}-1
    Log To Console             ${exactrow}

    TypeText                   (//input[@name\='additionalPremium'])[${exactrow}]      2000
    ClickText                  Save                        anchor=Return Quote Process
    ClickText                  Return Quote Process
    Log To Console             ----- Endorsements selected successful------

Check Premium before adding additional premium endorsement
    #Author=Amol Gaymukhe
    ${prbef_adden}=            GetInputValue               (//input[contains(@name,'-Primary Technical Premium')])[last()]
    ${bef_var}=                Remove String               ${prbef_adden}              $
    Log To Console             ${bef_var}
    Set Global Variable        ${bef_var}


Check Premium after adding additional premium endorsement  
    #Author=Amol Gaymukhe
    ${praf_adden}=             GetInputValue               (//input[contains(@name,'-Primary Technical Premium')])[last()]
    ${af_var}=                 Remove String               ${praf_adden}               $
    Log To Console             ${af_var}
    Set Suite Variable         ${af_var}

Check after additional premium endorsement the premium is increased
    #Author=Amol Gaymukhe
    ${bef_var_cleaned}=        Replace String              ${bef_var}                  ,                        ''
    ${af_var_cleaned}=         Replace String              ${af_var}                   ,                        ''
    ${bef_num}=                Evaluate                    float('${bef_var_cleaned}')
    ${af_num}=                 Evaluate                    float('${af_var_cleaned}')
    IF                         ${bef_num} >= ${af_num}
        Log To Console         Premium is not increased
        Fail
    ELSE
        Log To Console         Premium is increased -- Success
    END

Enter Quote Option
    #Author=Amol Gaymukhe
    [Documentation]            Enter Quote option
    Log To Console             Enter Quote Option
    #ClickElement              //input[contains(@name,'-PL Retroactive Date')]
    # TypeText                 //input[contains(@name,'-Quote Option')]                22

Click on Rate after Amendment
    #Author=Amol Gaymukhe
    [Documentation]            Click on rate quote
    ClickElement               (//lightning-button//button[text()\='Rate'])[last()]
    VerifyText                 Success                     anchor=Rating sucessfully!                           timeout=60s
    Sleep                      30s

Click on Finalize after Amendment
    #Author=Amol Gaymukhe
    [Documentation]            Click on Finalize quote

    ClickElement               (//lightning-icon[@title\='Finalize Quote'])[last()]
    VerifyText                 Success                     anchor=Finalize quote sucessfully!                   timeout=60s

Click on Rate after on Amendment
    #Author=Amol Gaymukhe
    [Documentation]            Click on rate quote

    ClickElement               (//button[text()\='Rate'])[last()]
    #ClickText                 Confirm                     anchor=Cancel
    #VerifyText                Success                     anchor=Rating sucessfully!                           timeout=45s
    Log To Console             ----- Rate Quote Successfully ------
