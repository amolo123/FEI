*** Settings ***
Library                         QWeb
Library                         QForce
Library                         FakerLibrary
Library                         String
Library                         BuiltIn
Library                         DateTime
#Resource                       ../../PageObjects_Account.robot

Resource                        ../../../resources/ReadPDF.robot

*** Variables ***
${broker_contact_coburn}        Suppressed Copado Broker

*** Keywords ***

Open Billing Record
    [Documentation]             Open Billing Record
    [Arguments]                 ${QuoteType}

    ClickText                   Billing                     anchor=Details
    UseTable                    Billing Record ID
    ClickText                   BR-                         anchor=${QuoteType}

    # Open Billing Record for Cancal and Replace
    #                           [Documentation]             Open Billing Record
    #                           [Arguments]                 ${QuoteType}

    #                           ClickText                   Billing                   anchor=Details
    #                           UseTable                    Billing Record ID
    #                           ClickText                   BR-                       anchor=Generated
Open Billing Record for Excess
    [Documentation]             Open Billing Record
    [Arguments]                 ${QuoteType}

    ClickText                   Add On Policies             anchor=Related
    ClickText                   P-                          anchor=Policy Name
    ClickText                   Billing                     anchor=Details
    UseTable                    Billing Record ID
    ClickText                   BR-                         anchor=${QuoteType}

Check Non-Premium Billing Record is not created

    [Documentation]             Check Non-Premium Billing Record is not created

    ClickText                   Billing                     anchor=Details
    UseTable                    Billing Record ID
    VerifyNoText                Admendment                  anchor=Quote Type

Download Invoice
    [Documentation]             Download Invoice

    ClickText                   Download Invoice
    VerifyText                  Document has been downloaded sucessfully!             anchor=Success              timeout=60s

Download Suppressed Invoice

    [Documentation]             Download Invoice Suppressed Invoice
    [Arguments]                 ${Sup_Reason}

    ClickText                   Download Invoice
    VerifyText                  Invoice cannot be downloaded for a Suppressed record                              anchor=Error          timeout=60s
    VerifyField                 Invoice Status              Suppressed
    VerifyField                 Status Change Reason        ${Sup_Reason}

Get Details for Billing Record document validation

    [Documentation]             Get Details Billing Record validation

    ${PolicyName}=              GetFieldValue               Policy Name
    Log To Console              ${PolicyName}
    Set Global Variable         ${PolicyName}

    ${Policy_Number}=           GetFieldValue               Policy Number
    Log To Console              ${Policy_Number}
    Set Global Variable         ${Policy_Number}


Navigate to policy Page from Billing record page
    [Documentation]             Navigate to policy Page from Billing record page

    ClickFieldValue             Policy
    VerifyField                 Policy Name                 ${PolicyName}             timeout=15s
    VerifyField                 Policy Number               ${Policy_Number}          timeout=15s

Verify Content on billing record PDF

    [Documentation]             Verify elements on billing record PDF
    [Arguments]                 ${QuoteType}                ${InsuredName}

    ${Invoice_No}=              GetFieldValue               Invoice No.
    ${Invoice_No}=              Convert To String           ${Invoice_No}
    Log To Console              ${Invoice_No}

    #Test PDF File              ${Invoice_No}
    Test PDF File               ${InsuredName}

    IF                          "${QuoteType}" == "New Business"


        Test PDF File           ${Policy_Number}
        Test PDF File           New Busines

    ELSE IF                     "${QuoteType}" == "Admendment"

        Test PDF File           ${Policy_Number}
        Test PDF File           New Busines
    ELSE IF                     "${QuoteType}" == "Flat Cancellation"

        Test PDF File           ${Policy_Number}
        Test PDF File           Flat Cancellation

    ELSE IF                     "${QuoteType}" == "Midterm Cancellation"

        Test PDF File           ${Policy_Number}
        Test PDF File           Midterm
        Test PDF File           Cancellation

    ELSE IF                     "${QuoteType}" == "Reinstatement"

        Test PDF File           ${Policy_Number}
        Test PDF File           Reinstatement

    ELSE IF                     "${QuoteType}" == "Renewal"

        Test PDF File           ${Policy_Number}
        Test PDF File           Renewal

    ELSE IF                     "${QuoteType}" == "Extension"

        Test PDF File           ${Policy_Number}
        Test PDF File           Extension
    ELSE IF                     "${QuoteType}" == "Extended Reporting Period"

        Test PDF File           ${Policy_Number}
        Test PDF File           Extended Reporting Period
    END

    #Static Content

    Test PDF File               Sold To:
    Test PDF File               Bill To:
    # Test PDF File             Policy '#'
    Test PDF File               Total Due:
    # Test PDF File             Invoice "#:"
    Test PDF File               Invoice Date:
    Test PDF File               Due Date:
    # Test PDF File             Endorsement "#"

    Test PDF File               Payment Options:
    Test PDF File               Wire/ACH Remittances
    Test PDF File               or
    Test PDF File               Make Checks Payable to:

    Test PDF File               Bank Name:
    Test PDF File               JP Morgan
    Test PDF File               FEI Premium Trust
    Test PDF File               Account Name:
    Test PDF File               FEI Premium Trust
    # Test PDF File             Lockbox "# 880752"
    # Test PDF File             Routing "#"
    Test PDF File               021000021
    Test PDF File               PO BOX 29650
    # Test PDF File             Account "#"
    Test PDF File               599962787
    Test PDF File               PO BOX 29650
    Test PDF File               Swift Code
    Test PDF File               CHASUS33
    Test PDF File               Phoenix, AZ, 85038-9560

    Test PDF File               For Non-US remittance, please use both Account Number and Swift Code

    Test PDF File               Transaction Type
    Test PDF File               Eff Date:
    Test PDF File               Exp Date:
    Test PDF File               Line Code
    Test PDF File               Trans Date
    Test PDF File               Gross Amount
    Test PDF File               Commission %
    Test PDF File               Broker Commission
    Test PDF File               Net Amount
    Test PDF File               Premium
    Test PDF File               Totals:
    Test PDF File               For Billing Questions,
    Test PDF File               please E-mail:
    Test PDF File               Finance@innovisk.com


Verify Static fields On Billing Record Page

    [Documentation]             Verify feilds on billing record page
    VerifyText                  Billing Record
    VerifyText                  Download Invoice
    VerifyText                  Under Review
    VerifyText                  Delete
    VerifyText                  Unpaid
    VerifyText                  Partially paid
    VerifyText                  Fully paid
    VerifyText                  Overpaid
    VerifyText                  Overpayment in Error
    VerifyText                  Details
    VerifyText                  History
    VerifyText                  Related Records
    VerifyText                  Gross Amounts
    VerifyText                  Gross Premium
    VerifyText                  TRIA Premium
    VerifyText                  Policy Fees
    VerifyText                  State Stamping Fee
    VerifyText                  Surplus Line Tax
    VerifyText                  State Specific Fees
    VerifyText                  State Tax
    VerifyText                  Inspection Fee
    VerifyText                  MVR Fee
    VerifyText                  Total Gross Amount
    VerifyText                  Commissions
    VerifyText                  Broker Commission %
    VerifyText                  Gross Premium Broker Amount
    VerifyText                  TRIA Premium Broker Amount
    VerifyText                  Total Commission
    VerifyText                  Net Amounts
    VerifyText                  Net Amount
    VerifyText                  Net TRIA Premium
    VerifyText                  Total Net Amount
    VerifyText                  Payments Info
    VerifyText                  Original Amount Due
    VerifyText                  Amount Paid
    VerifyText                  Amount Outstanding
    VerifyText                  Payment Status
    VerifyText                  % Paid
    VerifyText                  Invoice Details
    VerifyText                  Invoice No.
    VerifyText                  Invoice Status
    VerifyText                  Invoice Date
    VerifyText                  Status Change Reason
    VerifyText                  Due Date
    VerifyText                  Carrier Name
    VerifyText                  Policy Info
    VerifyText                  Policy
    VerifyText                  Policy Number
    VerifyText                  Quote
    VerifyText                  Quote Type
    VerifyText                  Quote Number
    VerifyText                  Endorsement ref
    VerifyText                  Policy Effective Date
    VerifyText                  Policy Expiry Date
    VerifyText                  Quote Endorsement Effective Date
    VerifyText                  Insured Name
    VerifyText                  LOB
    VerifyText                  Product
    VerifyText                  Underwriter
    VerifyText                  Broker Contact
    VerifyText                  Billing Agency
    VerifyText                  Billing Agency Contacts
    Scroll                      //html
    VerifyText                  All Billing Records Related To Policy
    UseTable                    Billing Record ID
    VerifyText                  Billing Record ID
    VerifyText                  Invoice No.
    VerifyText                  Payment Status
    VerifyText                  Invoice Status
    VerifyText                  Quote Number
    VerifyText                  Quote Type
    VerifyText                  Invoice Date
    VerifyText                  Amount Outstanding
    VerifyText                  System Info
    VerifyText                  Created By
    VerifyText                  Invoice Document Azure Id
    VerifyText                  Owner
    VerifyText                  Last Modified By
    VerifyText                  Currency

Validate Dynamic feilds on Billing Record

    [Documentation]             Validate Dynamic feilds on Billing Record
    [Arguments]                 ${PolicyNumberQ}            ${quoteVal}               ${uniqueNameB}              ${broker_contactB}    ${UniqueLOB}    ${BillingAgency}    ${UniqueProduct}


    ${cur_date}                 Get Current date            increment=1 day           result_format=%-m/%-d/%Y
    ${effective_Date}           Get Current date            increment=5 day           result_format=%-m/%-d/%Y
    ${Expiration_Date}          Get Current date            increment=370 day         result_format=%-m/%-d/%Y

    VerifyField                 Invoice Date                ${cur_date}
    VerifyField                 Due Date                    ${effective_Date}
    VerifyField                 Policy Effective Date       ${effective_Date}
    VerifyField                 Quote Effective Date        ${effective_Date}
    VerifyField                 Policy Expiry Date          ${Expiration_Date}
    VerifyField                 Quote Expiry Date           ${Expiration_Date}

    VerifyField                 Policy Number               ${PolicyNumberQ}
    VerifyText                  ${quoteVal}
    #VerifyText                 Insured Name                ${uniqueNameB}
    VerifyField                 Product                     ${UniqueProduct}
    VerifyField                 LOB                         ${UniqueLOB}
    VerifyText                  ${broker_contactB}
    VerifyText                  ${BillingAgency}

Validate Dynamic feilds on Billing Record for Excess

    [Documentation]             Validate Dynamic feilds on Billing Record
    [Arguments]                 ${EXPolicyNumberQ}          ${quoteVal}               ${uniqueNameB}              ${broker_contactB}    ${UniqueLOB}    ${BillingAgency}    ${UniqueProduct}

    ${cur_date}                 Get Current date            increment=1 day           result_format=%-m/%-d/%Y
    ${effective_Date}           Get Current date            increment=5 day           result_format=%-m/%-d/%Y
    ${Expiration_Date}          Get Current date            increment=370 day         result_format=%-m/%-d/%Y

    VerifyField                 Invoice Date                ${cur_date}
    VerifyField                 Due Date                    ${effective_Date}
    VerifyField                 Policy Effective Date       ${effective_Date}
    VerifyField                 Quote Effective Date        ${effective_Date}
    VerifyField                 Policy Expiry Date          ${Expiration_Date}
    VerifyField                 Quote Expiry Date           ${Expiration_Date}

    VerifyField                 Excess Policy Number        ${EXPolicyNumberQ}
    VerifyText                  ${quoteVal}
    #VerifyField                Insured Name                ${uniqueNameB}
    VerifyField                 Product                     ${UniqueProduct}
    VerifyField                 LOB                         ${UniqueLOB}
    VerifyText                  ${broker_contactB}
    VerifyText                  ${BillingAgency}

Get data to Validate on Billing Record
    [Documentation]             Get data to Validate on Billing Record

    ClickText                   Details
    VerifyField                 Policy Status               Bound
    ClickText                   Related                     anchor=Add On Policies
    UseTable                    Quote Name
    ClickCell                   r1c3

    ${PolicyNumber_BR}=         GetFieldValue               Policy Number
    Set Global Variable         ${PolicyNumber_BR}

    # ${PolicyBR}=              GetFieldValue               Policy
    # Set Global Variable       ${PolicyBR}


    ${QuoteNameBill}=           GetFieldValue               Quote Name
    Set Global Variable         ${QuoteNameBill}

    ${PNameBill}=               GetFieldValue               Product Name
    Set Global Variable         ${PNameBill}

    ${EXPolicyNumber_BR}=       GetFieldValue               Excess Policy Number
    Set Global Variable         ${EXPolicyNumber_BR}

    ClickFieldValue             Policy
    VerifyText                  Policy Type

Select broker Contact with no billing Agency
    [Documentation]             Select broker Contact with no billing Agency
    #Author=Akshay Verma

    UseModal                    On
    Select Broker for Coburn    ${broker_contact_coburn}

Select Broker for Coburn
    [Documentation]             Used to select the Broker on the Submission Init Form
    [Arguments]                 ${broker}
    #Author=Amol Gaymukhe
    Sleep                       5s
    UseModal                    On
    VerifyText                  Submission Init Form
    LogScreenshot
    ClickElement                //label[text()\='Broker Contact']/following-sibling::div//input
    TypeText                    //label[text()\='Broker Contact']/following-sibling::div//input                   ${broker}
    Sleep                       3s
    ClickElement                //label[text()\='Broker Contact']/following-sibling::div//span[contains(text(),'${broker}')]
    # QVision.ClickText         ${broker}                   index=2
    ClickText                   Next                        anchor=Cancel
    Log To Console              ----- Broker Contact Selected                         Successfully -----










