*** Settings ***
Library                         QWeb
Library                         QForce
#Library                        QVision
Library                         FakerLibrary
Library                         String
Library                         BuiltIn
Library                         DateTime
Resource                        ../resources/common.robot

*** Variables ***
${billingaddressBS}
${billingaddressState}
${ZipCodeU}


*** Keywords ***
Account click
    # Author = Amol
    [tags]                      Contacts
    ClickText                   Accounts
    VerifyText                  Recently Viewed             anchor=span                 timeout=40s

Validate new Account record fields
    # Author = Amol
    [tags]                      ContactTypes
    ClickText                   Accounts
    VerifyText                  Recently Viewed             anchor=span                 timeout=40s
    ClickText                   New
    UseModal                    On
    VerifyText                  Busisness
    VerifyText                  Broker
    VerifyText                  Insurance Company


Validate account form fields
    # Author = Amol
    [tags]                      Verify Account Fields
    Home
    ClickText                   Accounts
    VerifyText                  Recently Viewed             anchor=span                 timeout=40s
    ClickText                   New
    UseModal                    On
    VerifyText                  Business
    VerifyText                  Broker
    VerifyText                  Insurance Company
    ClickText                   Next                        partial_match=off
    VerifyText                  Account Name
    VerifyText                  Website
    VerifyText                  Description
    VerifyText                  Total Revenues
    VerifyText                  Total CLE
    VerifyText                  Account Owner
    VerifyText                  Account Record Type
    VerifyText                  Parent Account
    VerifyText                  Phone
    VerifyText                  Employees
    VerifyText                  MFiles ID
    VerifyText                  Total Claims Registered
    VerifyText                  Billing Agency Reference ID
    VerifyText                  Account Currency
    VerifyText                  TAM Code
    VerifyText                  NAICS Code
    VerifyText                  NAICS Description
    VerifyText                  Territory
    VerifyText                  Billing Address
    VerifyText                  Mailing Address
    VerifyText                  Billing Country
    VerifyText                  Billing Street
    VerifyText                  Mailing Country
    VerifyText                  Mailing Street
    VerifyText                  Billing City
    VerifyText                  Billing State/Province
    VerifyText                  Billing Zip/Postal Code
    VerifyText                  Mailing same as Billing address?
    VerifyText                  Mailing Country
    VerifyText                  Mailing Street
    VerifyText                  Mailing City
    VerifyText                  Mailing State/Province
    VerifyText                  Mailing Zip/Postal Code

    VerifyAttribute             //label[text()\='Account Name']/parent::div//input      maxlength                 255
    VerifyAttribute             //label[text()\='Account Name']/parent::div//input      type                      text
    VerifyAttribute             //label[text()\='Website']/parent::div//input           maxlength                 255
    VerifyAttribute             //label[text()\='Website']/parent::div//input           type                      text

    VerifyAttribute             //label[text()\='Parent Account']/parent::lightning-grouped-combobox//div/input                               maxlength                255
    VerifyAttribute             //label[text()\='Parent Account']/parent::lightning-grouped-combobox//div/input                               type                     text
    VerifyAttribute             //label[text()\='Phone']/parent::div//input             maxlength                 40
    VerifyAttribute             //label[text()\='Phone']/parent::div//input             type                      text
    # Could Not find Max Length
    VerifyAttribute             //label[text()\='Total Revenues']/parent::div//input    inputmode                 decimal
    VerifyAttribute             //label[text()\='Total Revenues']/parent::div//input    type                      text
    VerifyAttribute             //label[text()\='Employees']/parent::div//input         inputmode                 decimal
    VerifyAttribute             //label[text()\='Employees']/parent::div//input         type                      text
    VerifyAttribute             (//legend[text()\='Billing Address']/parent::fieldset//div/input)[1]              role                        combobox                 anchor=1
    VerifyAttribute             (//legend[text()\='Billing Address']/parent::fieldset//div/input)[1]              type                        text                     anchor=1


    VerifyAttribute             //label[text()\='Billing Country']/parent::div//input                             role                        combobox
    VerifyAttribute             //label[text()\='Billing Country']/parent::div//input                             type                        text
    VerifyAttribute             //label[text()\='Billing Street']/parent::lightning-textarea//textarea            maxlength                   255
    #VerifyAttribute            //label[text()\='Billing Street']/parent::lightning-textarea//textarea            type                        text
    VerifyAttribute             //label[text()\='Billing City']/parent::div//input      maxlength                 40
    VerifyAttribute             //label[text()\='Billing City']/parent::div//input      type                      text
    # Could Not find Max Length
    #VerifyAttribute            //label[text()\='Billing State/Province']/parent::div//input                      maxlength                   40
    VerifyAttribute             //label[text()\='Billing State/Province']/parent::div//input                      type                        text

    VerifyAttribute             //label[text()\='Billing Zip/Postal Code']/parent::div//input                     maxlength                   20
    VerifyAttribute             //label[text()\='Billing Zip/Postal Code']/parent::div//input                     type                        text
    # Could Not find Max Length
    #VerifyAttribute            //span[text()\='Mailing same as Billing address?']/parent::div//input             maxlength                   40
    VerifyAttribute             //span[text()\='Mailing same as Billing address?']/parent::label/parent::lightning-primitive-input-checkbox//input                     type                      checkbox



    VerifyAttribute             (//legend[text()\='Mailing Address']/parent::fieldset//div/input)[1]              role                        combobox
    VerifyAttribute             (//legend[text()\='Mailing Address']/parent::fieldset//div/input)[1]              type                        text


    VerifyAttribute             //label[text()\='Mailing Country']/parent::div//input                             role                        combobox
    VerifyAttribute             //label[text()\='Mailing Country']/parent::div//input                             type                        text
    VerifyAttribute             //label[text()\='Mailing Street']/parent::lightning-textarea//textarea            maxlength                   255
    #VerifyAttribute            //label[text()\='Billing Street']/parent::lightning-textarea//textarea            type                        text
    VerifyAttribute             //label[text()\='Mailing City']/parent::div//input      maxlength                 40
    VerifyAttribute             //label[text()\='Mailing City']/parent::div//input      type                      text
    # Could Not find Max Length
    #VerifyAttribute            //label[text()\='Billing State/Province']/parent::div//input                      maxlength                   40
    VerifyAttribute             //label[text()\='Mailing State/Province']/parent::div//input                      type                        text

    VerifyAttribute             //label[text()\='Mailing Zip/Postal Code']/parent::div//input                     maxlength                   20
    VerifyAttribute             //label[text()\='Mailing Zip/Postal Code']/parent::div//input                     type                        text

    VerifyPicklist              Territory
    ${Territory_value}=         GetPicklist                 Territory
    Log To Console              ${Territory_value}
    log                         ${Territory_value}
    @{Territory_list}=          Create List                 --None--                    Alabama: Entire State     Alaska: Entire State        Arizona: Entire State    Arkansas: Entire State    California: Los Angeles County                          California: Orange County                               California: Alameda, Contra Costa, Sacramento, San Diego, San Francisco, Santa Clara Counties               California: Fresno, Marin, Riverside, San Bernardino, San Mateo, Santa Barbara, Ventura Counties            California: Remainder of State                          Colorado: Entire State                         Connecticut: Entire State                               Delaware: Entire State                         District of Columbia    Florida: Brevard, Hillsborough, Indian River, Martin, Orange, Pinellas, St. Lucie, Seminole, Volusia counties                     Florida: Broward, Dade, Palm Beach counties           Florida: Remainder of State                            Georgia: Cobb, DeKalb, Fulton, Gwinnett counties        Georgia: Remainder of State                        Hawaii: Entire State    Idaho: Entire State         Illinois: Cook, Madison, St. Clair counties             Illinois: Remainder of State                            Indiana: Entire State       Iowa: Entire State          Kansas: Entire State        Kentucky: Entire State                          Louisiana: Entire State                             Maine: Entire State         Maryland: Entire State      Massachusetts: Remainder of State                       Massachusetts: Suffolk, Norfolk, Middlesex counties    Michigan: Entire State      Minnesota: Entire State     Mississippi: Entire State                         Missouri: Remainder of State                       Missouri: St. Louis, St. Louis City, Jackson, Johnson counties                     Montana: Entire State    Nebraska: Entire State    Nevada: Entire State    New Hampshire: Entire State    New Jersey: Bergen, Camden, Essex, Union counties    New Jersey: Remainder of State    New Mexico: Entire State    New York: Bronx, Kings, New York, Queens, Richmond counties    New York: Remainder of State    North Carolina: Entire State    North Dakota: Entire State    Ohio: Entire State    Oklahoma: Entire State    Oregon: Entire State    Pennsylvania: Philadelphia County    Pennsylvania: Remainder of State    Rhode Island: Entire State    South Carolina: Entire State    South Dakota: Entire State    Tennessee: Entire State    Texas: Brazoria, Chambers, Fort Bend, Galveston, Jefferson, Starr counties    Texas: Cameron, Hidalgo, Nueces, Orange, San Patricio, Willacy counties    Texas: Harris, Houston counties    Texas: Remainder of State    Utah: Entire State    Vermont: Entire State    Virginia: Entire State    Washington: Entire State    West Virginia: Entire State    Wisconsin: Entire State    Wyoming: Entire State
    Log To Console              ${Territory_list}
    Log                         ${Territory_list}
    Lists Should Be Equal       ${Territory_value}          ${Territory_list}           ignore_order=false

    VerifyAttribute             //label[text()\='Description']/parent::lightning-textarea//textarea               maxlength                   32000
    VerifyAttribute             //*[@name\="TAM_Code__c"]                               maxlength                 20
    VerifyAttribute             //*[@name\="NAICS_Code__c"]                             maxlength                 20
    VerifyAttribute             //*[@name\="NAICS_Description__c"]                      maxlength                 80
    #VerifyAttribute            //*[@name\="Total_Claims_Registered__c"]                type                      text
    VerifyText                  Cancel                      partial_match=false
    VerifyText                  Save & New                  partial_match=false
    VerifyText                  Save                        partial_match=false

Creating a new Account
    # Author = Amol
    [tags]                      Lead
    Home
    ClickText                   Accounts
    VerifyText                  Recently Viewed             anchor=span                 timeout=40s
    ClickElement                //div[text()\="New"]

    UseModal                    On
    VerifyText                  New Account
    ClickText                   Next                        anchor=span                 timeout=20s


    ## Entering data in the Account
    ${currTime}=                Get Current Date            result_format=%-d%-m%Y%-H%f
    ${fname}=                   FakerLibrary.first_name
    ${lname}=                   FakerLibrary.last_name
    ${name1}=                   Set Variable                ${fname} ${lname}
    Set Global Variable         ${name1}
    ${random_email}=            Set Variable                ${name1}@gmail.com
    Set Global Variable         ${random_email}
    ${uniqueName}=              Set Variable                ${name1}${currTime}
    Set Global Variable         ${uniqueName}
    Log To Console              ${uniqueName}
    ${pdf_insuredname}=         Set Variable                ${uniqueName}
    Set Global Variable         ${pdf_insuredname}
    ${description}=             Generate Random String      15
    Set Global Variable         ${description}
    ${Total_Revenues}=          Generate Random String      6                           123456789
    Set Global Variable         ${Total_Revenues}


    ${TAM_Code}=                Generate Random String      10
    Set Global Variable         ${TAM_Code}
    ${NAICS_Code}=              Generate Random String      4
    Set Global Variable         ${NAICS_Code}
    ${NAICS_Description}=       Generate Random String      15
    Set Global Variable         ${NAICS_Description}
    ${Total_Claims_Registered}=                             Generate Random String      4                         1234567890
    Set Global Variable         ${Total_Claims_Registered}
    ${totalcle}=                Set Variable                3534
    Set Global Variable         ${totalcle}


    ${Billing_Agency_Reference_ID}=                         FakerLibrary.Random Number
    Set Global Variable         ${Billing_Agency_Reference_ID}
    ${previousaccountname}=     Set Variable                Nathan123
    Set Global Variable         ${previousaccountname}
    ${accrecordtype}=           Set Variable                Business
    Set Global Variable         ${accrecordtype}
    ${parentaccount}=           Set Variable                Akshay Verma
    Set Global Variable         ${parentaccount}
    ${phone}=                   Generate Random String      10                          1234567890
    Log To Console              ${phone}
    Set Global Variable         ${phone}
    ${rev}=                     Generate Random String      6                           123456789
    Set Global Variable         ${rev}

    ${employee}=                Set Variable                4
    Set Global Variable         ${employee}

    ${billingaddress}=          Set Variable                902 Alabama
    #${billingaddress}=         Set Variable                FakerLibrary.Street
    Set Global Variable         ${billingaddress}

    VerifyText                  Account Name
    TypeText                    Account Name                ${uniqueName}
    TypeText                    Website                     ${random_email}
    TypeText                    Description                 ${description}
    TypeText                    Total Revenues              ${Total_Revenues}
    TypeText                    TAM Code                    ${TAM_Code}
    TypeText                    NAICS Code                  ${NAICS_Code}
    TypeText                    NAICS Description           ${NAICS_Description}
    TypeText                    Total Claims Registered     ${Total_Claims_Registered}
    TypeText                    Total CLE                   ${totalcle}
    TypeText                    Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}
    TypeText                    Phone                       ${phone}
    TypeText                    Employees                   ${employee}


    VerifyField                 Account Record Type         ${accrecordtype}
    TypeText                    //input[@placeholder\='Search Accounts...']             Akshay Verma
    ClickElement                //ul[@role\='group']        delay=2s


    # --------------------------Setting Address from lsit in every run ---------------------------------

    Run Keyword                 Generate Dynamic Address
    Log To Console              Using dynamic Billing Street: ${billingaddressBS}
    TypeText                    Billing Street              ${billingaddressBS}
    PickList                    Billing Country             United States
    sleep                       2s
    PickList                    Billing State/Province      ${billingaddressState}
    sleep                       2s
    TypeText                    Billing City                ${billingaddressState}
    TypeText                    Billing Zip/Postal Code     ${ZipCodeU}
    ClickText                   Mailing same as Billing address?

    # --------------------------Setting Address from lsit in every run ---------------------------------


    ClickText                   Save                        partial_match=false         anchor=Cancel
    Sleep                       5s
    UseModal                    Off
    VerifyText                  ${uniqueName}               timeout=60s                 anchor=Account Name
    Log To Console              Account Created.


Verify Account Created Fields
    # Author = Amol
    [Tags]                      VerifyAccount
    Home
    Account click
    VerifyText                  Recently Viewed             timeout=120s
    # VerifyText                ${uniqueName}               anchor=Details
    # ClickText                 ${uniqueName}               anchor=Details

    #ClickElement               (//th[@data-label\='Account Name']//a)[1]
    ClickElement                //a[@title\='${uniqueName}']
    VerifyField                 Account Name                ${uniqueName}
    VerifyField                 Website                     ${random_email}
    VerifyField                 Description                 ${description}

    # Verify Total Revenues
    ${trev}=                    GetFieldValue               Total Revenues
    ${trev1}=                   Remove String               ${trev}                     $                         ,
    Log To Console              ${rev}
    ${rev1}=                    set Variable                USD${SPACE}${Total_Revenues}.00
    Log To Console              ${rev1}
    Log To Console              ${trev1}
    IF                          '${trev1}' == '${rev1}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END

    VerifyField                 TAM Code                    ${TAM_Code}
    VerifyField                 NAICS Code                  ${NAICS_Code}
    #VerifyField                NAICS Description           ${NAICS_Description}
    #VerifyField                Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}
    VerifyField                 Employees                   ${employee}


    #phone no validation
    ${pno}=                     GetFieldValue               Phone
    ${pno1}=                    Remove String               ${pno}                      -                         (                           )                        ${SPACE}
    Log To Console              ${pno1}
    ${phone2}=                  Remove String               ${phone}                    -                         (                           )                        ${SPACE}
    IF                          '${phone2}' == '${pno1}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot


    #Verifying address
    ${Address}=                 Catenate                    ${billingaddressBS}${billingaddressState},            ${billingaddressState}      ${ZipCodeU}United States
    Log To Console              ${Address}
    ${sf_address}=              GetFieldValue               Billing Address
    ${words}=                   Remove String               ${sf_address}               \n
    Log To Console              ${words}
    IF                          '${Address}' == '${words}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot

    ${b_add1}=                  GetFieldValue               Billing Address
    ${b_add2}=                  Remove String               ${b_add1}                   \n
    ${m_add1}=                  GetFieldValue               Mailing Address
    ${m_add2}=                  Remove String               ${m_add1}                   \n
    Log To Console              ${b_add2}
    Log To Console              ${m_add2}
    IF                          '${b_add2}' == '${m_add2}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot

Validate if account was created when user had Cancel
    [Documentation]             Validate if account was created when user had Cancel

    ${Arg}=                     IsText                      ${uniqueName}
    IF                          "${Arg}" == "True"

        Fail                    Account creation was cancel and account was created. Failing the test case

    END


Validate Account Elements
    # Author = Amol
    [Tags]                      VerifyAccount
    Home
    ClickText                   Accounts
    VerifyText                  Recently Viewed             anchor=span
    #ClickElement               (//th[@data-label\='Account Name']//a)[1]
    #ClickElement               (//a[@data-refid\='recordId'])[1]\
    ClickElement                //a[@title\='${uniqueName}']
    VerifyText                  Details
    #VerifyText                 Submission                  anchor=Details
    VerifyText                  Insurance Items             anchor=Details
    # VerifyText                Policies                    anchor=Details
    VerifyText                  Contact                     anchor=Details
    # VerifyText                Notes                       anchor=Details
    VerifyText                  Sanction                    anchor=Details              partial_match=false
    # VerifyText                Document                    anchor=Details
    # VerifyText                M-Files                     anchor=Details              partial_match=false
    VerifyText                  Sfiles                      anchor=Details              partial_match=false


    VerifyText                  View Account Hierarchy
    ClickText                   Show more actions
    ClickText                   Generate Loss Run Doc
    UseModal                    On
    ClickText                   Cancel
    UseModal                    Off

    # VerifyText                View Document
    # VerifyText                Export Attorney
    # VerifyText                Attorney Import
    VerifyText                  Follow
    VerifyText                  Edit

Editing the Account    
    # Author = Amol
    [Tags]                      EditingAccount
    [Documentation]             Editing the Account

    Home
    ClickText                   Accounts
    #ClickElement               (//th[@data-label\='Account Name']//a)[1]
    ClickElement                //a[@title\='${uniqueName}']
    ClickText                   Edit                        anchor=View Account Hierarchy                         partial_match=false
    # ClickElement              (//span[text()\='Show more actions']/parent::button)[1]
    # ClickElement              //span[text()\='Edit']/parent::a                        Delay=3s
    UseModal                    On
    #TypeText                   Account Name                A
    PressKey                    Account Name                {CONTROL + A + DELETE}

    PressKey                    Website                     {CONTROL + A + DELETE}
    # PressKey                  SIC Code                    {CONTROL + A + DELETE}
    # PressKey                  SIC Description             {CONTROL + A + DELETE}
    # PressKey                  Number of Attorneys         {CONTROL + A + DELETE}
    PressKey                    Total CLE                   {CONTROL + A + DELETE}
    # PressKey                  Previous Account Name       {CONTROL + A + DELETE}
    PressKey                    Account Owner               {CONTROL + A + DELETE}

    #VerifyText                 Parent Account
    PressKey                    Phone                       {CONTROL + A + DELETE}
    PressKey                    Total Revenues              {CONTROL + A + DELETE}
    PressKey                    Employees                   {CONTROL + A + DELETE}

    ${currTime}=                Get Current Date            result_format=%-d%-m%Y%-H%f
    ${name2}=                   Name Male
    ${uniquename1}=             Set Variable                ${name2}${currTime}
    Set Global Variable         ${uniquename1}
    TypeText                    Account Name                ${uniquename1}
    TypeText                    Website                     Gibbson@gmail.com
    # TypeText                  SIC Code                    12313
    # TypeText                  SIC Description             Testing Editing
    # TypeText                  Number of Attorneys         72
    TypeText                    Total CLE                   12
    # TypeText                  Previous Account Name       Martin Garris
    #VerifyField                Account Owner               Copado-LGO Automation-User
    #VerifyField                Account Record Type         ${accrecordtype}
    #TypeText                   Parent Account              ${parentaccount}
    #ClickElement               (//li[@role\='presentation'])[1]


    TypeText                    Phone                       1234567121

    TypeText                    Total Revenues              78923
    TypeText                    Employees                   16
    TypeText                    Billing Address             743 Spring Street
    ClickText                   743 Spring Street Northeast
    Log Screenshot

    ClickText                   Save                        partial_match=false
    UseModal                    Off
    #VerifyField                Account Name                ${uniquename1}
    Log Screenshot



    # Delete Account Click
    #                           # Author = Amol
    #                           [Tags]                      Delete Account
    #                           Home
    #                           ClickText                   Accounts
    #                           VerifyText                  Recently Viewed             anchor=span
    #                           ClickElement                (//a[@data-refid\='recordId'])[1]
    #                           ClickElement                (//span[text()\='Show more actions']/parent::button)[1]
    #                           ClickElement                //span[text()\='Delete']/parent::a
    #                           ClickText                   Delete                      anchor=Cancel


Creating a new Account with Save and new
    # Author = Amol
    [tags]                      Lead
    Home
    ClickText                   Account
    VerifyText                  Recently Viewed             anchor=span                 timeout=40s
    ClickElement                //div[text()\="New"]

    UseModal                    On
    VerifyText                  New Account
    # ClickText                 Business
    # Log To Console            Buisness Clicked
    ClickText                   Next                        anchor=span                 timeout=20s
    ## Entering data in the Account
    ${currTime}=                Get Current Date            result_format=%-d%-m%Y%-H%f
    ${name1}=                   Name Male
    Set Global Variable         ${name1}
    ${random_email}=            Set Variable                ${name1}@gmail.com
    Set Global Variable         ${random_email}
    ${uniqueName}=              Set Variable                ${name1}${currTime}
    Set Global Variable         ${uniqueName}
    Log To Console              ${uniqueName}
    # ${sic}=                   Generate Random String      10                          123456789
    # Set Global Variable       ${sic}
    # ${sicdescription}=        Set Variable                My Description
    # Set Global Variable       ${sicdescription}
    # ${noofattorneys}=         Set Variable                5
    # Set Global Variable       ${noofattorneys}
    ${totalcle}=                Set Variable                3534
    Set Global Variable         ${totalcle}
    ${TAM_Code}                 Generate Random String      10
    Set Global Variable         ${TAM_Code}
    ${NAICS_Code}               Generate Random String      4
    Set Global Variable         ${NAICS_Code}
    ${NAICS_Description}        Generate Random String      15
    Set Global Variable         ${NAICS_Description}
    ${Total_Claims_Registered}                              Generate Random String      4
    Set Global Variable         ${Total_Claims_Registered}
    ${description}=             Generate Random String      15
    Set Global Variable         ${description}
    ${Total_Revenues}=          FakerLibrary.Postcode
    Set Global Variable         ${Total_Revenues}
    ${Billing_Agency_Reference_ID}=                         FakerLibrary.Random Number
    Set Global Variable         ${Billing_Agency_Reference_ID}
    ${previousaccountname}=     Set Variable                Nathan123
    Set Global Variable         ${previousaccountname}
    ${accrecordtype}=           Set Variable                Business
    Set Global Variable         ${accrecordtype}
    ${parentaccount}=           Set Variable                Akshay Verma
    Set Global Variable         ${parentaccount}
    ${phone}=                   Generate Random String      10                          1234567890
    Log To Console              ${phone}
    Set Global Variable         ${phone}
    ${rev}=                     Generate Random String      6                           123456789
    Set Global Variable         ${rev}

    ${employee}=                Set Variable                4
    Set Global Variable         ${employee}

    ${billingaddress}=          Set Variable                902 Alabama
    Set Global Variable         ${billingaddress}

    VerifyText                  Account Name
    TypeText                    Account Name                ${uniqueName}
    TypeText                    Website                     ${random_email}
    TypeText                    TAM Code                    ${TAM_Code}
    TypeText                    NAICS Code                  ${NAICS_Code}
    TypeText                    NAICS Description           ${NAICS_Description}
    TypeText                    Description                 ${description}
    TypeText                    Total Revenues              ${Total_Revenues}
    TypeText                    Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}

    #TypeText                   Total Claims Registered     ${Total_Claims_Registered}
    # TypeText                  SIC Code                    ${sic}
    # TypeText                  SIC Description             ${sicdescription}
    # TypeText                  Number of Attorneys         ${noofattorneys}
    TypeText                    Total CLE                   ${totalcle}
    #TypeText                   Previous Account Name       ${previousaccountname}
    # ${Account_owner}=         GetText                     Account Owner
    # Log To Console            ${Account_owner}
    # VerifyField               Account Owner               Automation-user Copado-FEI
    # VerifyField               Account Record Type         ${accrecordtype}
    VerifyText                  Business                    anchor=Account Record Type
    #ComboBox                   Parent Account              ${parentaccount}            delay=2s
    TypeText                    //input[@placeholder\='Search Accounts...']             Akshay Verma
    #ClickElement               (//li[@role\='presentation'])[1]                        delay=2s
    ClickElement                //ul[@role\='group']        delay=2s
    TypeText                    Phone                       ${phone}
    TypeText                    Total Revenues              ${rev}
    TypeText                    Employees                   ${employee}
    TypeText                    Billing Address             ${billingaddress}
    ClickText                   902 Alabama Drive
    ClickText                   Mailing same as Billing address?
    # TypeText                  Billing Address             234 Greene
    # ClickText                 234 Greene Avenue


    ClickText                   Save & New                  partial_match=false
    VerifyText                  New Account
    ClickText                   Next                        anchor=Cancel

    ## Entering data in the Account
    ${currTime}=                Get Current Date            result_format=%-d%-m%Y%-H%f
    ${name1}=                   Name Male
    Set Global Variable         ${name1}
    ${random_email}=            Set Variable                ${name1}@gmail.com
    Set Global Variable         ${random_email}
    ${uniqueName2}=             Set Variable                ${name1}${currTime}
    Set Global Variable         ${uniqueName2}
    Log To Console              ${uniqueName2}
    # ${sic}=                   Generate Random String      10                          123456789
    # Set Global Variable       ${sic}
    # ${sicdescription}=        Set Variable                My Description
    # Set Global Variable       ${sicdescription}
    # ${noofattorneys}=         Set Variable                5
    # Set Global Variable       ${noofattorneys}
    ${totalcle}=                Set Variable                3534
    Set Global Variable         ${totalcle}
    ${TAM_Code}                 Generate Random String      10
    Set Global Variable         ${TAM_Code}
    ${NAICS_Code}               Generate Random String      4
    Set Global Variable         ${NAICS_Code}
    ${NAICS_Description}        Generate Random String      15
    Set Global Variable         ${NAICS_Description}
    ${Total_Claims_Registered}                              Generate Random String      4
    Set Global Variable         ${Total_Claims_Registered}
    ${description}=             Generate Random String      15
    Set Global Variable         ${description}
    ${Total_Revenues}=          FakerLibrary.Postcode
    Set Global Variable         ${Total_Revenues}
    ${Billing_Agency_Reference_ID}=                         FakerLibrary.Random Number
    Set Global Variable         ${Billing_Agency_Reference_ID}
    ${previousaccountname}=     Set Variable                Nathan123
    Set Global Variable         ${previousaccountname}
    ${accrecordtype}=           Set Variable                Business
    Set Global Variable         ${accrecordtype}
    ${parentaccount}=           Set Variable                Akshay Verma
    Set Global Variable         ${parentaccount}
    ${phone}=                   Generate Random String      10                          1234567890
    Log To Console              ${phone}
    Set Global Variable         ${phone}
    ${rev}=                     Generate Random String      6                           123456789
    Set Global Variable         ${rev}

    ${employee}=                Set Variable                4
    Set Global Variable         ${employee}

    ${billingaddress}=          Set Variable                902 Alabama
    Set Global Variable         ${billingaddress}

    VerifyText                  Account Name
    TypeText                    Account Name                ${uniqueName2}
    TypeText                    Website                     ${random_email}
    TypeText                    TAM Code                    ${TAM_Code}
    TypeText                    NAICS Code                  ${NAICS_Code}
    TypeText                    NAICS Description           ${NAICS_Description}
    TypeText                    Description                 ${description}
    TypeText                    Total Revenues              ${Total_Revenues}
    TypeText                    Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}

    #TypeText                   Total Claims Registered     ${Total_Claims_Registered}
    # TypeText                  SIC Code                    ${sic}
    # TypeText                  SIC Description             ${sicdescription}
    # TypeText                  Number of Attorneys         ${noofattorneys}
    TypeText                    Total CLE                   ${totalcle}
    #TypeText                   Previous Account Name       ${previousaccountname}
    # ${Account_owner}=         GetText                     Account Owner
    # Log To Console            ${Account_owner}
    # VerifyField               Account Owner               Automation-user Copado-FEI
    #VerifyField                Account Record Type         ${accrecordtype}
    VerifyText                  Business                    anchor=Account Record Type
    #ComboBox                   Parent Account              ${parentaccount}            delay=2s
    TypeText                    //input[@placeholder\='Search Accounts...']             Akshay Verma
    #ClickElement               (//li[@role\='presentation'])[1]                        delay=2s
    ClickElement                //ul[@role\='group']        delay=2s
    TypeText                    Phone                       ${phone}
    TypeText                    Total Revenues              ${rev}
    TypeText                    Employees                   ${employee}
    TypeText                    Billing Address             ${billingaddress}
    ClickText                   902 Alabama Drive
    ClickText                   Mailing same as Billing address?
    # TypeText                  Billing Address             234 Greene
    # ClickText                 234 Greene Avenue

    ClickText                   Save                        partial_match=false
    Sleep                       5sec
    UseModal                    Off
    ClickText                   Accounts
    VerifyText                  Recently Viewed             anchor=span                 timeout=60s
    ${acc_1}=                   GetText                     //th[@aria-label\='Account Name']/ancestor::table//tbody/tr[1]/th[1]//a
    Log To Console              ${acc_1}
    ${acc_2}=                   GetText                     //th[@aria-label\='Account Name']/ancestor::table//tbody/tr[2]/th[1]//a
    Log To Console              ${acc_2}

    IF                          "${acc_1}" == "${uniquename2}"
        Log To Console          Success
    ELSE
        Fail
    END

    IF                          "${acc_2}" == "${uniquename}"
        Log To Console          Success
    ELSE
        Fail
    END

    # VerifyText                ${uniqueName}
    # VerifyText                ${uniquename2}
    # Log To Console            ${uniquename2}

Creation of Account Cancel 
    # Author = Amol
    [tags]                      Lead
    Home
    ClickText                   Account
    VerifyText                  Recently Viewed             anchor=span                 timeout=40s
    ClickElement                //div[text()\="Ne"]

    UseModal                    On
    VerifyText                  New Account
    # ClickText                 Business
    # Log To Console            Buisness Clicked
    ClickText                   Next                        anchor=span                 timeout=20s


    ## Entering data in the Account
    ${currTime}=                Get Current Date            result_format=%-d%-m%Y%-H%f
    ${name1}=                   Name Male
    Set Global Variable         ${name1}
    ${random_email}=            Set Variable                ${name1}@gmail.com
    Set Global Variable         ${random_email}
    ${uniqueName}=              Set Variable                ${name1}${currTime}
    Set Global Variable         ${uniqueName}
    # ${sic}=                   Generate Random String      10                          123456789
    # Set Global Variable       ${sic}
    # ${sicdescription}=        Set Variable                My Description
    # Set Global Variable       ${sicdescription}
    # ${noofattorneys}=         Set Variable                5
    # Set Global Variable       ${noofattorneys}
    ${totalcle}=                Set Variable                3534
    Set Global Variable         ${totalcle}
    ${TAM_Code}                 Generate Random String      10
    Set Global Variable         ${TAM_Code}
    ${NAICS_Code}               Generate Random String      4
    Set Global Variable         ${NAICS_Code}
    ${NAICS_Description}        Generate Random String      15
    Set Global Variable         ${NAICS_Description}
    ${Total_Claims_Registered}                              Generate Random String      4
    Set Global Variable         ${Total_Claims_Registered}
    ${description}=             Generate Random String      15
    Set Global Variable         ${description}
    ${Total_Revenues}=          FakerLibrary.Postcode
    Set Global Variable         ${Total_Revenues}
    ${Billing_Agency_Reference_ID}=                         FakerLibrary.Random Number
    Set Global Variable         ${Billing_Agency_Reference_ID}
    ${previousaccountname}=     Set Variable                Nathan123
    Set Global Variable         ${previousaccountname}
    ${accrecordtype}=           Set Variable                Business
    Set Global Variable         ${accrecordtype}
    ${parentaccount}=           Set Variable                Akshay Verma
    Set Global Variable         ${parentaccount}
    ${phone}=                   Generate Random String      10                          1234567890
    Log To Console              ${phone}
    Set Global Variable         ${phone}
    ${rev}=                     Generate Random String      6                           123456789
    Set Global Variable         ${rev}

    ${employee}=                Set Variable                4
    Set Global Variable         ${employee}

    ${billingaddress}=          Set Variable                902 Alabama
    Set Global Variable         ${billingaddress}

    VerifyText                  Account Name
    TypeText                    Account Name                ${uniqueName}
    TypeText                    Website                     ${random_email}
    TypeText                    TAM Code                    ${TAM_Code}
    TypeText                    NAICS Code                  ${NAICS_Code}
    TypeText                    NAICS Description           ${NAICS_Description}
    TypeText                    Description                 ${description}
    TypeText                    Total Revenues              ${Total_Revenues}
    TypeText                    Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}

    #TypeText                   Total Claims Registered     ${Total_Claims_Registered}
    # TypeText                  SIC Code                    ${sic}
    # TypeText                  SIC Description             ${sicdescription}
    # TypeText                  Number of Attorneys         ${noofattorneys}
    TypeText                    Total CLE                   ${totalcle}
    #TypeText                   Previous Account Name       ${previousaccountname}
    # ${Account_owner}=         GetText                     Account Owner
    # Log To Console            ${Account_owner}
    # VerifyField               Account Owner               Automation-user Copado-FEI
    #VerifyField                Account Record Type         ${accrecordtype}
    VerifyText                  Business                    anchor=Account Record Type
    #ComboBox                   Parent Account              ${parentaccount}            delay=2s
    TypeText                    //input[@placeholder\='Search Accounts...']             Akshay Verma
    #ClickElement               (//li[@role\='presentation'])[1]                        delay=2s
    ClickElement                //ul[@role\='group']        delay=2s
    TypeText                    Phone                       ${phone}
    TypeText                    Total Revenues              ${rev}
    TypeText                    Employees                   ${employee}
    TypeText                    Billing Address             ${billingaddress}
    ClickText                   902 Alabama Drive
    ClickText                   Mailing same as Billing address?
    # TypeText                  Billing Address             234 Greene
    # ClickText                 234 Greene Avenue

    ClickText                   Mailing same as Billing address?

    ClickText                   Cancel                      partial_match=false
    UseModal                    Off



    # Follow Edit and Delete Account Click
    #                           [Tags]                      Account
    #                           Home
    #                           ClickText                   Accounts
    #                           VerifyText                  Recently Viewed             anchor=span
    #                           ClickElement                (//a[@data-refid\='recordId'])[1]
    #                           Editing the Account
    #                           Delete Account Click



Create a Broker
    # Author = Amol
    [tags]                      Broker

    ${currTime}=                Get Current Date            result_format=%-d%-m%Y%-H%f
    ${fname}=                   FakerLibrary.first_name
    ${lname}=                   FakerLibrary.last_name
    ${name1}=                   Set Variable                ${fname} ${lname}
    Set Global Variable         ${name1}
    ${random_email}=            Set Variable                ${name1}@gmail.com
    Set Global Variable         ${random_email}
    ${uniqueName}=              Set Variable                ${name1}${currTime}
    Set Global Variable         ${uniqueName}
    Log To Console              ${uniqueName}
    ${pdf_insuredname}=         Set Variable                ${uniqueName}
    Set Global Variable         ${pdf_insuredname}
    ${description}=             Generate Random String      15
    Set Global Variable         ${description}
    ${Total_Revenues}=          Generate Random String      6                           123456789
    Set Global Variable         ${Total_Revenues}
    # ${sic}=                   Generate Random String      10                          123456789
    # Set Global Variable       ${sic}
    # ${sicdescription}=        Set Variable                My Description
    # Set Global Variable       ${sicdescription}
    # ${noofattorneys}=         Set Variable                5
    # Set Global Variable       ${noofattorneys}

    ${TAM_Code}=                Generate Random String      10
    Set Global Variable         ${TAM_Code}
    ${NAICS_Code}=              Generate Random String      4
    Set Global Variable         ${NAICS_Code}
    ${NAICS_Description}=       Generate Random String      15
    Set Global Variable         ${NAICS_Description}
    ${Total_Claims_Registered}=                             Generate Random String      4                         1234567890
    Set Global Variable         ${Total_Claims_Registered}
    ${totalcle}=                Set Variable                3534
    Set Global Variable         ${totalcle}


    ${Billing_Agency_Reference_ID}=                         FakerLibrary.Random Number
    Set Global Variable         ${Billing_Agency_Reference_ID}
    ${previousaccountname}=     Set Variable                Nathan123
    Set Global Variable         ${previousaccountname}
    ${accrecordtype}=           Set Variable                Business
    Set Global Variable         ${accrecordtype}
    ${parentaccount}=           Set Variable                Akshay Verma
    Set Global Variable         ${parentaccount}
    ${phone}=                   Generate Random String      10                          1234567890
    Log To Console              ${phone}
    Set Global Variable         ${phone}
    ${rev}=                     Generate Random String      6                           123456789
    Set Global Variable         ${rev}

    ${employee}=                Set Variable                4
    Set Global Variable         ${employee}

    ${billingaddress}=          Set Variable                902 Alabama
    #${billingaddress}=         Set Variable                FakerLibrary.Street
    Set Global Variable         ${billingaddress}

    VerifyText                  Account Name
    TypeText                    Account Name                ${uniqueName}
    TypeText                    FEIN                        ${currTime}
    PickList                    Home State                  AK
    TypeText                    Home License                ${description}
    TypeText                    Principal Name              ${Total_Revenues}
    TypeText                    Agency Licensing Contact    ${TAM_Code}
    # TypeText                  Broker Agreement Effective Date                         ${NAICS_Code}
    # TypeText                  Broker Agreement Expiration Date                        ${NAICS_Description}
    PickList                    Trading Type                Retailer
    TypeText                    (//input[@placeholder\='Search Accounts...'])[1]        Test AKS
    #ClickText                  Test AKS 123                partial_match=true
    ClickElement                (//ul[@role\='group'])//li[@role\='presentation'][1]
    sleep                       2s

    TypeText                    Phone                       ${phone}
    Sleep                       10s
    TypeText                    Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}
    TypeText                    Billing Address             902 Alabama
    ClickText                   902 Alabama Drive           partial_match=true
    ClickText                   Save                        anchor=Save & New           partial_match=false


Creating an account with WY state
    # Author = Amol
    [tags]                      Lead
    Creating a new Account
    #ClickText                  Edit                        anchor=Export Attorney
    ClickElement                //button[@name\='Edit']
    PickList                    Billing State/Province      Wyoming
    TypeText                    Billing Zip/Postal Code     82007
    ClickText                   Save                        anchor=Save & New           partial_match=False

Creating an account with NY state
    # Author = Amol
    [tags]                      Lead
    Creating a new Account
    ClickText                   Edit
    PickList                    Billing State/Province      New York
    TypeText                    Billing Zip/Postal Code     10007
    ClickText                   Save                        anchor=Save & New

Creation of Account unchecked Mailing same as Billing address
    # Author = Akshay Verma
    [tags]                      Lead
    Home
    ClickText                   Accounts
    VerifyText                  Recently Viewed             anchor=span                 timeout=40s
    ClickText                   New

    UseModal                    On
    VerifyText                  New Account
    # ClickText                 Business
    # Log To Console            Buisness Clicked
    ClickText                   Next                        anchor=span                 timeout=20s


    ## Entering data in the Account
    ${currTime}=                Get Current Date            result_format=%-d%-m%Y%-H%f
    ${fname}=                   FakerLibrary.first_name
    ${lname}=                   FakerLibrary.last_name
    ${name1}=                   Set Variable                ${fname} ${lname}
    Set Global Variable         ${name1}
    ${random_email}=            Set Variable                ${name1}@gmail.com
    Set Global Variable         ${random_email}
    ${uniqueName}=              Set Variable                ${name1}${currTime}
    Set Global Variable         ${uniqueName}
    Log To Console              ${uniqueName}
    ${pdf_insuredname}=         Set Variable                ${uniqueName}
    Set Global Variable         ${pdf_insuredname}
    ${description}=             Generate Random String      15
    Set Global Variable         ${description}
    ${Total_Revenues}=          Generate Random String      6                           123456789
    Set Global Variable         ${Total_Revenues}
    # ${sic}=                   Generate Random String      10                          123456789
    # Set Global Variable       ${sic}
    # ${sicdescription}=        Set Variable                My Description
    # Set Global Variable       ${sicdescription}
    # ${noofattorneys}=         Set Variable                5
    # Set Global Variable       ${noofattorneys}

    ${TAM_Code}=                Generate Random String      10
    Set Global Variable         ${TAM_Code}
    ${NAICS_Code}=              Generate Random String      4
    Set Global Variable         ${NAICS_Code}
    ${NAICS_Description}=       Generate Random String      15
    Set Global Variable         ${NAICS_Description}
    ${Total_Claims_Registered}=                             Generate Random String      4                         1234567890
    Set Global Variable         ${Total_Claims_Registered}
    ${totalcle}=                Set Variable                3534
    Set Global Variable         ${totalcle}


    ${Billing_Agency_Reference_ID}=                         FakerLibrary.Random Number
    Set Global Variable         ${Billing_Agency_Reference_ID}
    ${previousaccountname}=     Set Variable                Nathan123
    Set Global Variable         ${previousaccountname}
    ${accrecordtype}=           Set Variable                Business
    Set Global Variable         ${accrecordtype}
    ${parentaccount}=           Set Variable                Akshay Verma
    Set Global Variable         ${parentaccount}
    ${phone}=                   Generate Random String      10                          1234567890
    Log To Console              ${phone}
    Set Global Variable         ${phone}
    ${rev}=                     Generate Random String      6                           123456789
    Set Global Variable         ${rev}

    ${employee}=                Set Variable                4
    Set Global Variable         ${employee}

    ${billingaddress}=          Set Variable                902 Alabama
    #${billingaddress}=         Set Variable                FakerLibrary.Street
    Set Global Variable         ${billingaddress}

    VerifyText                  Account Name
    TypeText                    Account Name                ${uniqueName}
    TypeText                    Website                     ${random_email}
    TypeText                    Description                 ${description}
    TypeText                    Total Revenues              ${Total_Revenues}
    TypeText                    TAM Code                    ${TAM_Code}
    TypeText                    NAICS Code                  ${NAICS_Code}
    TypeText                    NAICS Description           ${NAICS_Description}
    TypeText                    Total Claims Registered     ${Total_Claims_Registered}
    TypeText                    Total CLE                   ${totalcle}
    TypeText                    Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}
    TypeText                    Phone                       ${phone}
    TypeText                    Employees                   ${employee}


    VerifyField                 Account Record Type         ${accrecordtype}
    #ComboBox                   Parent Account              ${parentaccount}            delay=2s
    TypeText                    //input[@placeholder\='Search Accounts...']             Akshay Verma
    #ClickElement               (//li[@role\='presentation'])[1]                        delay=2s
    ClickElement                //ul[@role\='group']        delay=2s
    # TypeText                  Phone                       ${phone}
    # TypeText                  Total Revenues              ${rev}
    # TypeText                  Employees                   ${employee}
    TypeText                    Billing Address             ${billingaddress}
    # ComboBox                  Search Address              902 Alabama Drive
    ClickText                   902 Alabama Drive           partial_match=true
    ClickText                   Mailing same as Billing address?
    # TypeText                  Billing Address             234 Greene
    # ClickText                 234 Greene Avenue
    ClickText                   Mailing same as Billing address?
    ClickText                   Save                        partial_match=false
    Sleep                       5s
    UseModal                    Off

Verify Billing and Mailling address
    # Author = Akshay verma
    [Tags]                      VerifyAccount
    Home
    Account click
    VerifyText                  Recently Viewed             timeout=120s
    # VerifyText                ${uniqueName}               anchor=Details
    # ClickText                 ${uniqueName}               anchor=Details

    # ClickElement              (//th[@data-label\='Account Name']//a)[1]
    ClickElement                //a[@title\='${uniqueName}']


    VerifyField                 Account Name                ${uniqueName}
    VerifyField                 Website                     ${random_email}
    VerifyField                 Description                 ${description}

    # Verify Total Revenues
    ${trev}=                    GetFieldValue               Total Revenues
    ${trev1}=                   Remove String               ${trev}                     $                         ,
    Log To Console              ${rev}
    ${rev1}=                    set Variable                USD${SPACE}${Total_Revenues}.00
    Log To Console              ${rev1}
    Log To Console              ${trev1}
    IF                          '${trev1}' == '${rev1}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END

    VerifyField                 TAM Code                    ${TAM_Code}
    VerifyField                 NAICS Code                  ${NAICS_Code}
    #VerifyField                NAICS Description           ${NAICS_Description}
    #VerifyField                Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}
    VerifyField                 Employees                   ${employee}


    #phone no validation
    ${pno}=                     GetFieldValue               Phone
    ${pno1}=                    Remove String               ${pno}                      -                         (                           )                        ${SPACE}
    Log To Console              ${pno1}
    ${phone2}=                  Remove String               ${phone}                    -                         (                           )                        ${SPACE}
    IF                          '${phone2}' == '${pno1}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot


    #Verifying address
    ${Address}=                 Set Variable                902 Alabama DriveHerndon, Virginia 20170United States
    ${sf_address}=              GetFieldValue               Billing Address
    ${words}=                   Remove String               ${sf_address}               \n
    Log To Console              ${words}
    IF                          '${Address}' == '${words}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot

    ${b_add1}=                  GetFieldValue               Billing Address
    ${b_add2}=                  Remove String               ${b_add1}                   \n
    ${m_add1}=                  GetFieldValue               Mailing Address
    ${m_add2}=                  Remove String               ${m_add1}                   \n
    Log To Console              ${b_add2}
    Log To Console              ${m_add2}
    IF                          '${b_add2}' != '${m_add2}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot


Verify Follow and Edit Button
    # Author = Akshay verma
    [Tags]                      VerifyAccount
    Home
    Account click
    VerifyText                  Recently Viewed             timeout=120s
    # VerifyText                ${uniqueName}               anchor=Details
    # ClickText                 ${uniqueName}               anchor=Details

    #ClickElement               (//th[@data-label\='Account Name']//a)[1]
    ClickElement                //a[@title\='${uniqueName}']

    VerifyField                 Account Name                ${uniqueName}
    VerifyField                 Website                     ${random_email}
    VerifyField                 Description                 ${description}

    # Verify Total Revenues
    ${trev}=                    GetFieldValue               Total Revenues
    ${trev1}=                   Remove String               ${trev}                     $                         ,
    Log To Console              ${rev}
    ${rev1}=                    set Variable                USD${SPACE}${Total_Revenues}.00
    Log To Console              ${rev1}
    Log To Console              ${trev1}
    IF                          '${trev1}' == '${rev1}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END

    VerifyField                 TAM Code                    ${TAM_Code}
    VerifyField                 NAICS Code                  ${NAICS_Code}
    #VerifyField                NAICS Description           ${NAICS_Description}
    #VerifyField                Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}
    VerifyField                 Employees                   ${employee}


    #phone no validation
    ${pno}=                     GetFieldValue               Phone
    ${pno1}=                    Remove String               ${pno}                      -                         (                           )                        ${SPACE}
    Log To Console              ${pno1}
    ${phone2}=                  Remove String               ${phone}                    -                         (                           )                        ${SPACE}
    IF                          '${phone2}' == '${pno1}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot


    #Verifying address
    ${Address}=                 Set Variable                902 Alabama DriveHerndon, Virginia 20170United States
    ${sf_address}=              GetFieldValue               Billing Address
    ${words}=                   Remove String               ${sf_address}               \n
    Log To Console              ${words}
    IF                          '${Address}' == '${words}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot

    ${b_add1}=                  GetFieldValue               Billing Address
    ${b_add2}=                  Remove String               ${b_add1}                   \n
    ${m_add1}=                  GetFieldValue               Mailing Address
    ${m_add2}=                  Remove String               ${m_add1}                   \n
    Log To Console              ${b_add2}
    Log To Console              ${m_add2}
    IF                          '${b_add2}' != '${m_add2}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot

    VerifyText                  Follow
    VerifyText                  Edit

Verify Insurance Item Contact Sanction on Account
    # Author = Akshay verma
    [Tags]                      VerifyAccount
    Home
    Account click
    VerifyText                  Recently Viewed             timeout=120s
    # VerifyText                ${uniqueName}               anchor=Details
    # ClickText                 ${uniqueName}               anchor=Details

    #ClickElement               (//th[@data-label\='Account Name']//a)[1]
    ClickElement                //a[@title\='${uniqueName}']

    VerifyField                 Account Name                ${uniqueName}
    VerifyField                 Website                     ${random_email}
    VerifyField                 Description                 ${description}

    # Verify Total Revenues
    ${trev}=                    GetFieldValue               Total Revenues
    ${trev1}=                   Remove String               ${trev}                     $                         ,
    Log To Console              ${rev}
    ${rev1}=                    set Variable                USD${SPACE}${Total_Revenues}.00
    Log To Console              ${rev1}
    Log To Console              ${trev1}
    IF                          '${trev1}' == '${rev1}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END

    VerifyField                 TAM Code                    ${TAM_Code}
    VerifyField                 NAICS Code                  ${NAICS_Code}
    #VerifyField                NAICS Description           ${NAICS_Description}
    #VerifyField                Billing Agency Reference ID                             ${Billing_Agency_Reference_ID}
    VerifyField                 Employees                   ${employee}


    #phone no validation
    ${pno}=                     GetFieldValue               Phone
    ${pno1}=                    Remove String               ${pno}                      -                         (                           )                        ${SPACE}
    Log To Console              ${pno1}
    ${phone2}=                  Remove String               ${phone}                    -                         (                           )                        ${SPACE}
    IF                          '${phone2}' == '${pno1}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot


    #Verifying address
    ${Address}=                 Set Variable                902 Alabama DriveHerndon, Virginia 20170United States
    ${sf_address}=              GetFieldValue               Billing Address
    ${words}=                   Remove String               ${sf_address}               \n
    Log To Console              ${words}
    IF                          '${Address}' == '${words}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot

    ${b_add1}=                  GetFieldValue               Billing Address
    ${b_add2}=                  Remove String               ${b_add1}                   \n
    ${m_add1}=                  GetFieldValue               Mailing Address
    ${m_add2}=                  Remove String               ${m_add1}                   \n
    Log To Console              ${b_add2}
    Log To Console              ${m_add2}
    IF                          '${b_add2}' != '${m_add2}'
        Log To Console          Success
    ELSE
        Fail                    Assertion Failed
    END
    Log Screenshot

    ClickText                   Insurance Items
    VerifyText                  Submissions
    VerifyElement               //span[@title\='Policies'][1]
    VerifyText                  Policies
    VerifyText                  Cases
    VerifyText                  Claim Data
    ClickElement                //a[@data-label\='Contacts']
    VerifyText                  Related Contacts
    VerifyText                  Notes
    VerifyText                  Files
    ClickElement                //a[@data-label\='Sanction']

Generate Dynamic Address

    ${random_street}=           Evaluate                    random.choice(["1200 Alabama Drive VA","1200 Alabama Drive NC","234 Greene Avenue MB", "333, S. Figueroa Street, Los Angeles","500, Post Street (Mason Street), San francisco."," 125 Music Mountain Drive, Pigeon Forge, TN 37863","2341 Collins Ave, Miami Beach, FL 33139","3654 S Lindbergh Blvd, Saint Louis, MO 63127-1204","401 N. Wabash Avenue, Chicago, IL 60611-3583"," 1 Newport Dr, Bar Harbor, Mount Desert Island, ME 04609-1898"])                           modules=random
    Set Global Variable         ${billingaddressBS}         ${random_street}
    ${random_state}=            Evaluate                    random.choice(["Arizona", "California", "Texas", "Oregon", "Alaska"])
    Set Global Variable         ${billingaddressState}      ${random_state}

    IF                          "${billingaddressState}" == "Arizona"
        ${ZipCode}=             Set Variable                86313
        Set Global Variable     ${ZipCodeU}                 ${ZipCode}
    ELSE IF                     "${billingaddressState}" == "California"
        ${ZipCode}=             Set Variable                90002
        Set Global Variable     ${ZipCodeU}                 ${ZipCode}
    ELSE IF                     "${billingaddressState}" == "Texas"
        ${ZipCode}=             Set Variable                75001
        Set Global Variable     ${ZipCodeU}                 ${ZipCode}
    ELSE IF                     "${billingaddressState}" == "Oregon"
        ${ZipCode}=             Set Variable                97920
        Set Global Variable     ${ZipCodeU}                 ${ZipCode}
    ELSE IF                     "${billingaddressState}" == "Alaska"
        ${ZipCode}=             Set Variable                99505
        Set Global Variable     ${ZipCodeU}                 ${ZipCode}
    END

