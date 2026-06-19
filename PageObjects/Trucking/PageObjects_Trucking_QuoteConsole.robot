*** Settings ***
Library                    QWeb
Library                    QForce
#Library                   QVision
Library                    FakerLibrary
Library                    String
Library                    BuiltIn
Library                    DateTime
Resource                   ../../resources/common.robot
Resource                   ../PageObjects_Account.robot
Resource                   ../PageObjects_HomePage.robot
Resource                   ../Freberg_Common.robot

Library                    ../../libraries/dateconvert.py


*** Keywords ***
Validate field on Quote Console page for Trucking
    # Author = Amol Gaymukhe
    [Documentation]        Validating all the elements on Quote Console Page
    [tags]                 Quote Console
    VerifyAll              Transaction Premium, Excess Transaction Premium, PD(Surplus) Transaction Premium, Broker Commission %
    VerifyAll              Excess Broker Commission %, Filing Type
    VerifyAll              Finalize, Refer, Quotes (1), Document Revisions (0)
    VerifyElement          //lightning-icon[@title\='Generate Document']
    VerifyElement          //lightning-icon[@title\='Endorsements & Subjectivities']
    VerifyElement          //lightning-icon[@title\='Close']
    VerifyAll              Fees, State Fees, Stamping Fees, Inspection Fee, MVR Fee, Excess Fees, Excess State Fees, Excess Policy Fees, Excess Stamping Fees
    VerifyAll              PD Fees, PD State Fees, PD Policy Fees, PD Stamping Fees
    VerifyAll              Quote Options, Coverage Product, Occurence Limit, Agg Limit, Deductible, Premium, FreightIQ
    ClickText              FreightIQ
    VerifyText             Model Results
    VerifyAll              Trucking/Physical Damage/GL
    VerifyAll              Trucking, GL, Motor Cargo, EXCESS ONLY, PD SURPLUS ONLY


Click on Finalize Button 
    # Author = Amol Gaymukhe
    [Documentation]        Validating Finalize on Quote Console Page
    [tags]                 Quote Console
    ClickText              Finalize
    VerifyText             Success                     anchor=Finalize quote successfully!                    timeout=35s


Verify Bound Pending 
    # Author = Amol Gaymukhe
    [Documentation]        Validating Finalize on Quote Console Page
    [tags]                 Quote Console
    ClickText              Proceed to Bind
    UseModal               On
    VerifyText             Pay plan
    ClickText              Proceed to Bind             anchor=Cancel
    VerifyText             Success                     anchor=Quote status moved to Bound Pending!            timeout=35s

Select Filing
    # Author = Amol Gaymukhe
    [Documentation]        Validating Filing on Quote Console Page
    [tags]                 Quote Console
    [Arguments]            ${value}
    MultiPickList          Filing Type                 ${value}                    action=Move to Selected


Click On Save 
    # Author = Amol Gaymukhe
    [Documentation]        Validating Save on Quote Console Page
    [tags]                 Quote Console
    ClickText              Save
    VerifyText             Success                     anchor=Update records successfully!                    timeout=35s



Select Filing Review SPOE
    # Author = Amol Gaymukhe
    [Documentation]        Validating all the elements on Underwrtting Console Page
    [tags]                 Underwrtting Console
    [Arguments]            ${SPOE_NAME}
    ClickText              Filing Review
    # VerifyText           Waiver of Subrogation
    ClickText              Complete underwriter review
    VerifyText             SPOE Reviewer Selection
    DropDown               Select the user for SPOE Review:                        ${SPOE_NAME}
    ClickText              Submit


Click On Proceed to Bind for final Bind
    # Author = Amol Gaymukhe
    [Documentation]        Validating Proceed to bind for final Bind on Quote Console Page
    [tags]                 Quote Console
    ClickText              Proceed to Bind
    UseModal               On
    VerifyText             Pay plan
    ClickText              Proceed to Bind             anchor=Cancel
    VerifyText             Success                     anchor=Quote status moved to Bound Pending!            timeout=35s
    Sleep                  10s
    ClickText              Bind
    VerifyText             Success                     anchor=Bind quote successfully!                        timeout=35s


Select Submission from Search
    # Author = Amol Gaymukhe
    [Documentation]        Validating Proceed to bind for final Bind on Quote Console Page
    [tags]                 Quote Console
    TypeText               //button[@aria-label\='Search']                         ${uniqueName}
    TypeText               //label[text()\='Search...']/following::div/input       ${uniqueName}
    ClickElement           //span[text()\='Submission • ']


Complete Filing Review SPOE Sign Off Flow
    # Author = Amol Gaymukhe
    [Documentation]        Validating Proceed to bind for final Bind on Quote Console Page
    [tags]                 Quote Console
    ClickText              Filing Review
    ClickText              Sign off SPOE check
    VerifyText             SPOE Sign Off
    ClickElement           //button[text()\='Sign Off']
    Sleep                  10s


Complete FreightIQ Flow
    # Author = Amol Gaymukhe
    [Documentation]        Validating Proceed to bind for final Bind on Quote Console Page
    [tags]                 Quote Console
    RefreshPage
    VerifyText             FreightIQ
    ClickText              FreightIQ
    Sleep                  5s
    ClickElement           //td[text()\='Final Pricing Action']/following-sibling::td//input
    TypeText               //td[text()\='Final Pricing Action']/following-sibling::td//input                  20
    ClickElement           //td[text()\='Manual Pricing-Annualized Expiring Pricing']/following-sibling::td//input
    TypeText               //td[text()\='Manual Pricing-Annualized Expiring Pricing']/following-sibling::td//input    5000


Generate Primary or Excess or PD(Surplus) Document
    #Author=Amol Gaymukhe
    [Documentation]        Generating Document
    [Arguments]            ${type_doc}

    Sleep                  15s
    ClickElement           //lightning-icon[@title\='Generate Document']
    VerifyText             Quote Document
    IF                     "${type_doc}"=="Primary"
        ClickElement       //input[@value\='Primary']
    ELSE IF                "${type_doc}"=="Excess"
        ClickElement       //input[@value\='Excess']
    ELSE IF                "${type_doc}"=="PD(Surplus)"
        ClickElement       //input[@value\='PD(Surplus)']
    END

    ClickText              Continue                    anchor=Cancel
    VerifyText             Success                     anchor=Generate document is success!                   timeout=45s

    Log To Console         ----- ${type_doc} is successful------


Get Quote Letter Dynamic Document Trucking
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
    ${from}=               GetInputValue               Effective Date
    ${from1}=              Mdy To Ymd                  ${from}
    Set Global Variable    ${from1}

    ${to}=                 GetInputValue               Expiration Date
    ${to1}=                Mdy To Ymd                  ${to}
    Set Global Variable    ${to1}

    ${re}=                 GetInputValue               Received Date
    ${re1}=                Mdy To Ymd                  ${re}
    Set Global Variable    ${re1}

Get Premium from Quote Console
    #Author=Amol
    [Documentation]        Dynamic Document Elements and Setting as Set Global Variable
    # Broker Name
    #Premium of the primary quote
    ${premium}=            GetInputValue               (//td[@data-label\='Premium']//lightning-formatted-number)[1]
    Log To Console         ${premium}
    @{characters} =        Split String To Characters                              ${premium}
    Log Many               @{characters}
    Insert Into List       ${characters}               2                           ,
    Log Many               @{characters}
    ${pre}=                Catenate                    @{characters}
    Log To Console         ${pre}
    ${pri_premium}=        Remove String               ${pre}                      ${SPACE}
    Log To Console         ${pri_premium}
    Set Global Variable    ${pri_premium}

    #Premium of the Excess quote
    ${premium}=            GetInputValue               (//td[@data-label\='Premium']//lightning-formatted-number)[2]
    Log To Console         ${premium}
    @{characters} =        Split String To Characters                              ${premium}
    Log Many               @{characters}
    Insert Into List       ${characters}               1                           ,
    Log Many               @{characters}
    ${pre}=                Catenate                    @{characters}
    Log To Console         ${pre}
    ${exc_premium}=        Remove String               ${pre}                      ${SPACE}
    Log To Console         ${exc_premium}
    Set Global Variable    ${exc_premium}

    #Premium of the PD quote
    ${premium}=            GetInputValue               (//td[@data-label\='Premium']//lightning-formatted-number)[3]
    Log To Console         ${premium}
    @{characters} =        Split String To Characters                              ${premium}
    Log Many               @{characters}
    Insert Into List       ${characters}               1                           ,
    Log Many               @{characters}
    ${pre}=                Catenate                    @{characters}
    Log To Console         ${pre}
    ${pd_premium}=         Remove String               ${pre}                      ${SPACE}
    Log To Console         ${pd_premium}
    Set Global Variable    ${pd_premium}

Click on Bind
    #Author=Raj
    [Documentation]        Click on Bind

    ClickText              Bind
    VerifyText             Success                     anchor=Bind quote successfully!                        timeout=35s
