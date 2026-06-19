*** Settings ***
Library                    QWeb
Library                    QForce
Library                    FakerLibrary
Library                    String
Library                    BuiltIn
Library                    DateTime
Resource                   ../../resources/common.robot
Resource                   ../Freberg_Common.robot


*** Variables ***


*** Keywords ***

Validate Elements on Underwriting Analysis for PPL
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
    # Save and verify the save was successfully!
    ClickText              Save                        anchor=EIL Coverages
    VerifyText             Update records successfully!


 Add exposures for PPL 
    #Author Vighanesh
    [Documentation]        Explosure for PPL

    # Add Exposure         Fuel Distribution/Blending (wholesale)Biodiesel
    Add Exposure           Chemical Distribution?
    Add Exposure           Chemical Warehouses (no explosives)?
    Add Exposure           Cogeneration & Power Producers (non-public utilities)
    Add Exposure           Die Casting
    Add Exposure           Electroplating
    Add Exposure           Foundries
    # Add Exposure         Fuel Distribution/Blending (wholesale) Diesel
    # Add Exposure         Fuel Distribution/Blending (wholesale) Transfer facilities
    # Add Exposure         Fuel Distribution/Blending (wholesale)
    # Add Exposure         Fuel Distribution/Blending (wholesale)Blending/Packaging
    Add Exposure           Instrument & Monitoring Equipment Manufacturing
    Add Exposure           Intermediate Chemical Suppliers Adhesives
    Add Exposure           Intermediate Chemical Suppliers Asphalt
    Add Exposure           Intermediate Chemical Suppliers Bulk Cleaning Products (wholesale)
    Add Exposure           Intermediate Chemical Suppliers Resins
    Add Exposure           Intermediate Chemical Suppliers Sealants
    Add Exposure           Intermediate Chemical Suppliers Waxes (no pharmaceuticals)
    # Add Exposure         Lubricants/Oil/Oil Blending (excludes Fuel Oil Delivery)
    Add Exposure           Machine Shops
    Add Exposure           Machinery or Machinery Parts Mfg.- Industrial Typ
    Add Exposure           Machinery or Machinery Parts Mfg.- Metalworking
    Add Exposure           Metal Goods
    # Add Exposure         Paints & Coatings (excludes Mold/Rust suppressants)
    Add Exposure           Piping, Tubing & Pipe Connectors
    Add Exposure           Plastics
    Add Exposure           Remediation Equipment (No PPE) Aerators
    Add Exposure           Remediation Equipment (No PPE) Air Pollution Control EquipmentÂ
    Add Exposure           Remediation Equipment (No PPE) Bio-bugs (clean-up bacteria)
    Add Exposure           Remediation Equipment (No PPE) Cleanup gear
    Add Exposure           Remediation Equipment (No PPE) Skimmers
    Add Exposure           Remediation Equipment (No PPE) Water Treatment Systems (non-consumer)
    Add Exposure           Rubber
    # Add Exposure         Storage Tanks/Drums/IBCs/Totes
    Add Exposure           Submersible Pump & Related Pumping Equipment
    Add Exposure           Tool & Die


Validate Subjectivities

    #Author Vighanesh
    [Documentation]        Validate PPL Subjectivity

    Scroll                 Subjectivities
    UseTable               Description
    VerifyTable            r?EIL App/c?Status          Open
    VerifyTable            r?EIL OFAC/c?Status         Open
    VerifyTable            r?BRF -EIL/c?Status         Open
