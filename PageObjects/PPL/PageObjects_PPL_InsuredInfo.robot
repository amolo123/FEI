*** Settings ***
Library                       QWeb
Library                       QForce
#Library                      QVision
Library                       FakerLibrary
Library                       String
Library                       BuiltIn
Library                       DateTime
Resource                      ../../resources/common.robot
Resource                      ../PageObjects_Account.robot
Resource                      ../PageObjects_HomePage.robot



*** Keywords ***

Validate field on Insured Info page for PPL
    # Author = Vighanesh
    [tags]                    Insured Info

    ClickText                 Home                        anchor=FEI Insurance
    ClickElement              //span[text()\='App Launcher']
    TypeText                  //input[@placeholder\='Search apps and items...']     FEI Insurance
    ClickText                 FEI Insurance
    VerifyText                FEI Insurance               anchor=Home
    VerifyText                New                         anchor=Printable View
    ClickText                 New
    ClickElement              //button/span[text()\="Select Product"]
    ClickText                 PPL                         anchor=Product
    ClickText                 Next
    ClickElement              (//input[@placeholder\="Search..."])[1]
    TypeText                  (//input[@placeholder\="Search..."])[1]               ${uniqueName}               anchor=Account Name
    ClickElement              (//li[@role\='presentation']/span)[1]
    sleep                     10s
    ClickElement              (//button[@name\='SaveAccount'])
    VerifyText                Success                     anchor=Account updated

    Log To Console            ----- Account added -----
    # ${Phone_value}=         GetFieldValue               Phone
    # Log To Console          ${Phone_value}
    #VerifyInputValue         Account Name                ${uniqueName}
    VerifyInputValue          Phone                       ${phone}
    VerifyInputValue          Country                     United States
    VerifyInputValue          NAICS Code                  ${NAICS_Code}
    # VerifyInputValue        NAICS Description           ${NAICS_Description}
    VerifyInputValue          Street                      ${billingaddressBS}
    VerifyInputValue          City                        ${billingaddressState}
    VerifyInputValue          PostalCode                  ${ZipCodeU}
    VerifyInputValue          Province                    ${billingaddressState}
    VerifyText                Province
    VerifyPicklist            Province
    ${Province}=              GetPicklist                 Province                  #//*[@name\='Admitted_State__c']
    Log To Console            ${Province}

    @{Province_List}=         Create List                 --None--                  Marshall Islands            Michigan       Minnesota      Missouri    Northern Mariana Islands    Mississippi    Montana    North Carolina    North Dakota    Nebraska    New Hampshire    New Jersey    New Mexico    Nevada    New York    Ohio    Oklahoma    Oregon    Pennsylvania    Puerto Rico    Palau    Rhode Island    South Carolina    South Dakota    Tennessee    Texas    United States Minor Outlying Islands            Utah                 Virginia                            US Virgin Islands      Vermont              Armed Forces Americas               Armed Forces Europe          Alaska        Alabama     Armed Forces Pacific                   Arkansas    American Samoa                     Arizona    California        Colorado         Connecticut            District of Columbia               Delaware         Florida     Federated Micronesia                Georgia          Guam       Hawaii    Iowa    Idaho    Illinois    Indiana    Kansas    Kentucky    Louisiana    Massachusetts    Maryland    Maine    Washington    Wisconsin    West Virginia    Wyoming
    Log To Console            ${Province_List}
    Lists Should Be Equal     ${Province_List}            ${Province}               ignore_order=true

    VerifyText                Business Type
    VerifyPicklist            Business Type
    ${Business_Type}=         GetPicklist                 Business Type
    Log To Console            ${Business_Type}
    @{Business_Type_List}=    Create List                 Individual                Partnership                 Corporation    Association    LLC         Limited Partnership         Other
    Log To Console            ${Business_Type_List}
    Lists Should Be Equal     ${Business_Type_List}       ${Business_Type}          ignore_order=true

    Log To Console            ----- Insured Info field Validate-----

Enter data on Insured info Page for PPL

    # Author = Vighanesh
    [tags]                    Insured Info

    ClickText                 Home                        anchor=FEI Insurance
    ClickElement              //span[text()\='App Launcher']
    TypeText                  //input[@placeholder\='Search apps and items...']     FEI Insurance
    ClickText                 FEI Insurance
    VerifyText                FEI Insurance               anchor=Home
    VerifyText                New                         anchor=Printable View
    ClickText                 New
    ClickElement              //button/span[text()\="Select Product"]
    ClickText                 PPL                         anchor=Product
    ClickText                 Next
    ClickElement              (//input[@placeholder\="Search..."])[1]
    ClickElement              //label[text()\='']
    TypeText                  (//input[@placeholder\="Search..."])[1]               ${uniqueName}               anchor=Account Name
    #ClickElement             (//li[@role\='presentation']/span)[1]
    ClickElement              //span[contains(text(),'${uniqueName}')]
    sleep                     10s
    ClickElement              (//button[@name\='SaveAccount'])
    VerifyText                Success                     anchor=Account updated
    Log To Console            ----- Account added -----
    ClickText                 NEXT:Submission Info >
    Log To Console            ----- Data Entered On PPL Insured info Page ---------------
