*** Settings ***
Library                         QWeb
Library                         QForce
Library                         FakerLibrary
Library                         String
Library                         BuiltIn
Library                         DateTime
Library                         OperatingSystem

Resource                        ../Freberg_Common.robot


*** Variables ***


*** Keywords ***

Validate Elements on Underwriting Analysis for STEIL
    #Author=Vighanesh surve

    ClickText                   EIL Coverages
    ClickText                   EIL Coverages

    VerifyText                  Retro Date
    TypeText                    Retro Date                  23-10-2023

    ClickText                   None                        partial_match=False
    ClickText                   Other                       partial_match=False
    ClickText                   TBD                         partial_match=False
    ClickText                   Policy Inception            partial_match=False

    ClickText                   Per Claim
    ClickText                   Per Pollution Condition
    ClickText                   Deductible

    #Verify Business NAICS Code list for STEIL
    VerifyPickList              Business NAICS Code
    ${Business_NAICS_Code}=     GetPicklist                 Business NAICS Code
    Log To Console              ${Business_NAICS_Code}
    ${Business_NAICS_Code_List}=                            Create List                 Airport or FBO          Asphalt paving                Auto dealer                Auto repair                             Bulk petroleum facility            Bus depot                   Citrus grove or orchard                           Condominium                 Contractors yard            Equipment rental/sales/svc.    Farm                      Farm co-op              *Gas station/C-store/truck stop)    Golf course or country club    Government (municipal or county)    Hospital    Hotel    Marina    Office or retail space    School    Ski Resort
    Log To Console              ${Business_NAICS_Code_List}
    Lists Should Be Equal       ${Business_NAICS_Code}      ${Business_NAICS_Code_List}                         ignore_order=true


    ${UW_comment}=              Generate Random String      15
    Set Global Variable         ${UW_comment}
    ClickText                   Underwriting Comments (if applicable):
    ClickText                   Underwriting Comments (if applicable):
    TypeText                    type here...                ${UW_comment}


    ${Broker_Notice}=      Generate Random String      15
    Set Global Variable    ${Broker_Notice}
    ClickElement           (//span[@title\='Broker Notice']/ancestor::section)[2]//textarea
    TypeText               (//span[@title\='Broker Notice']/ancestor::section)[2]//textarea            ${Broker_Notice}    anchor=Broker Notice
    # Save and verify the save was successfully!

    # Save and verify the save was successfully!
    ClickText                   Save                        anchor=EIL Coverages
    VerifyText                  Update records successfully!


Validate Subjectivities are open for STEIL

    ScrollTo                    Subjectivities
    Expand Aria                 Subjectivities
    UseTable                    Description
    ScrollText                  Subjectivities
    VerifyTable                 r?NI or AI's - STEIL/c?Status                           Open
    VerifyTable                 r?UST OFAC/c?Status         Open
    VerifyTable                 r?UST Ren App/c?Status      Open
    VerifyTable                 r?TRIA - STEIL/c?Status     Open
    VerifyTable                 r?UST App/c?Status          Open
    VerifyTable                 r?BRF - STEIL/c?Status      Open



Add Retroacive Date
    [Documentation]     Adding Retroacive Date
    TypeText                    Retro Date                  1st Nov 2023


Select NAICS Code
    [Documentation]     Adding NAICS Date
    PickList                    Business NAICS Code         Auto dealer