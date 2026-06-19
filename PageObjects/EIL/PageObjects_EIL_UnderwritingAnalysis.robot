*** Settings ***
Library                    QWeb
Library                    QForce
Library                    FakerLibrary
Library                    String
Library                    BuiltIn
Library                    DateTime


*** Variables ***


*** Keywords ***

Validate Elements on Underwriting Analysis for EIL
    #Author=Vighanesh surve
    [Documentation]        Validate Elements on Underwriting Analysis
    ClickText              EIL Coverages
    ClickText              EIL Coverages
    VerifyText             EIL Sub-Coverage
    VerifyText             Full
    VerifyText             3rd Party
    VerifyText             Onsite Only
    VerifyText             Tank Only
    VerifyText             Auto Dealer
    #ClickCheckbox         3rd Party                   on                      timeout=5s
    ClickText              3rd Party                   partial_match=False
    ClickText              Onsite Only                 partial_match=False
    ClickText              Tank Only                   partial_match=False
    ClickText              Auto Dealer                 partial_match=False
    ClickText              Full                        partial_match=False
    VerifyText             EIL Retroactive Date
    ClickText              None                        partial_match=False
    ClickText              Other                       partial_match=False
    ClickText              TBD                         partial_match=False
    ClickText              Policy Inception            partial_match=False
    VerifyText             EIL Retro Date
    TypeText               EIL Retro Date              23-10-2023
    VerifyText             Self Insured Retention
    VerifyText             Per Claim
    VerifyText             Per Pollution Condition
    VerifyText             Deductible
    ClickText              Per Claim
    ClickText              Per Pollution Condition
    ClickText              Deductible
    #Remove Coverage A     from the selected coverages
    ClickText              Coverage A - Onsite Cleanup                         timeout=2s
    ClickText              Move to                     anchor=2

    ${UW_comment}=         Generate Random String      15
    Set Global Variable    ${UW_comment}
    ClickText              Underwriting Comments (if applicable):
    ClickText              Underwriting Comments (if applicable):
    TypeText               type here...                ${UW_comment}

    ${Broker_Notice}=      Generate Random String      15
    Set Global Variable    ${Broker_Notice}
    ClickElement           (//span[@title\='Broker Notice']/ancestor::section)[2]//textarea
    TypeText               (//span[@title\='Broker Notice']/ancestor::section)[2]//textarea            ${Broker_Notice}    anchor=Broker Notice
    # Save and verify the save was successfully!
    ClickText              Save                        anchor=EIL Coverages
    VerifyText             Update records successfully!




Validate Subjectivities are open for EIL

    Scroll                 Subjectivities
    UseTable               Description

    ScrollText             Subjectivities

    VerifyTable            r?BRF - UL info/c?Status    Open
    VerifyTable            r?BRF - XS/c?Status         Open
    VerifyTable            r?TRIA - XS/c?Status        Open
    VerifyTable            r?XS OFAC/c?Status          Open
    VerifyTable            r?EIL OFAC/c?Status         Open
    VerifyTable            r?BRF/c?Status              Open
    VerifyTable            r?EIL App/c?Status          Open




