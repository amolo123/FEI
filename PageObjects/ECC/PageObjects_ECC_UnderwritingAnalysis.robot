*** Settings ***
Library                QWeb
Library                QForce
Library                FakerLibrary
Library                String
Library                BuiltIn
Library                DateTime
Resource               ../../resources/common.robot
Resource               PageObjects_ECC_InsuredInfo.robot
Resource               ../Freberg_Common.robot



*** Variables ***


*** Keywords ***

Validate Underwriting Analysis Elements for ECC
    #Author=Vighanesh surve

    VerifyText         Total Premium Basis
    TypeText           *Total Premium Basis        30000
    ClickText          *Total Premium Basis
    TypeText           *Total Premium Basis        30000
    VerifyText         *Total Premium Basis
    VerifyText         Auditable?
    ClickCheckbox      Auditable?                  on                          timeout=5s
    ClickCheckbox      Auditable?                  off
    ClickText          Exposure
    ClickText          Exposure
    #UseTable          Exposure

    VerifyText         Commercial General Liability
    VerifyText         Contractors Pollution Liability
    VerifyText         Professional Liability
    VerifyText         Excess
    #VerifyText        Excess Prior Policies
    # ClickText        Close

    ClickText          Underwriting Comments (if applicable):
    ClickText          Underwriting Comments (if applicable):
    TypeText           type here...                Test Check
    ${Broker_Notice}=      Generate Random String      15
    Set Global Variable    ${Broker_Notice}
    ClickElement           (//span[@title\='Broker Notice']/ancestor::section)[2]//textarea
    TypeText               (//span[@title\='Broker Notice']/ancestor::section)[2]//textarea            ${Broker_Notice}    anchor=Broker Notice
    # Save and verify the save was successfully!
    ClickText          Subjectivities
    Log To Console     ----- Underwritting Analysis Elements validated successfully------


 Validate Subjectivities are open CGL CPL PL Excess
    #Author=Vighanesh surve
    UseTable           Description
    ClickText          Underwriting Comments (if applicable):
    ClickText          Underwriting Comments (if applicable):
    ScrollText         Subjectivities
    VerifyTable        r?BRF - ECC/c?Status        Open
    VerifyTable        r?ECC OFAC/c?Status         Open
    VerifyTable        r?TRIA - ECC/c?Status       Open
    VerifyTable        r?BRF - UL info/c?Status    Open
    VerifyTable        r?BRF - XS/c?Status         Open
    VerifyTable        r?TRIA - XS/c?Status        Open
    VerifyTable        r?XS OFAC/c?Status          Open
    Log To Console     ----- Subjectivities open for CGL CPL PL validated successfully------




Validate Subjectivities are open for PL
    #Author=Vighanesh surve

    ClickText          Subjectivities
    UseTable           Description
    ClickText          Underwriting Comments (if applicable):
    ClickText          Underwriting Comments (if applicable):
    ScrollText         Subjectivities
    VerifyTable        r?BRF - ECC/c?Status        Open
    VerifyTable        r?ECC OFAC/c?Status         Open
    VerifyTable        r?TRIA - ECC/c?Status       Open
    Log To Console     ----- Subjectivities areopen for PL validated successfully------



Validate Subjectivities are open(CGL,CPL,PL)
    #Author=Vighanesh surve

    ClickText          Subjectivities
    UseTable           Description
    ClickText          Underwriting Comments (if applicable):
    ClickText          Underwriting Comments (if applicable):
    ScrollText         Subjectivities
    VerifyTable        r?BRF - ECC/c?Status        Open
    VerifyTable        r?ECC OFAC/c?Status         Open
    VerifyTable        r?TRIA - ECC/c?Status       Open
    Log To Console     ----- Subjectivities open for CGL CPL PL validated successfully------



Add Explosure for CGL CPL PL and Excess
    #Author= Vighnesh Surve
    # Add exposures
    Add Exposure       Above Ground Storage Tank Installation
    Add Exposure       Air Pollution Control Design
    Add Exposure       Air Pollution Control Installation
    Add Exposure       All Professional Services
    Add Exposure       Analytical Laboratories
    Add Exposure       Asbestos Abatement (A)
    Add Exposure       Asbestos Abatement (B)
    Add Exposure       Bioremediation
    Add Exposure       Bridge Construction
    Add Exposure       Carpentry
    Add Exposure       Concrete
    Add Exposure       Demolition Contractor (no blasting)
    Add Exposure       Demolition Contractor (no blasting) 3+ stories
    Add Exposure       Dismantling
    Add Exposure       Dismantling - 4+ stories
    Add Exposure       Dismantling 3 stories & less and interior dismantling
    Add Exposure       Dredging
    Add Exposure       Drilling
    Add Exposure       Drilling (not oil and gas production)
    Add Exposure       Electrical
    Add Exposure       Electronics Recycling
    Add Exposure       Emergency Response
    Add Exposure       Explosive Demolition
    Add Exposure       Fencing
    Add Exposure       Fire / Water Damage Restoration Contractor
    Add Exposure       GL NOC High Exposure
    Add Exposure       GL NOC Low Exposure
    Add Exposure       GL NOC Medium Exposure
    Add Exposure       General Consulting
    Add Exposure       General Contracting
    Add Exposure       General Contracting NOC High Hazard
    Add Exposure       General Contracting NOC Low Hazard
    Add Exposure       General Contracting NOC Med Hazard
    Add Exposure       Geophysical surveys
    Add Exposure       Geotechnical Engineering
    Add Exposure       Geothermal System Design
    Add Exposure       Geothermal System Installation
    Add Exposure       Hazardous Waste Cleanup
    Add Exposure       Hydrogeological Investigations
    Add Exposure       Industrial Cleaning
    Add Exposure       Industrial Hygiene/Health & Safety
    Add Exposure       Interior Demolition
    Add Exposure       Labpacking/Drum Handling
    Add Exposure       Landfill Liner Installation
    Add Exposure       Landscaping Contractor
    Add Exposure       Lead Abatement
    Add Exposure       Lead and Asbestos Consulting
    Add Exposure       Maintenance / Janitorial
    Add Exposure       Mechanical Construction
    Add Exposure       Metal Erection
    Add Exposure       Mold Abatement
    Add Exposure       Mold Assessments
    Add Exposure       Other PL Exposure High Hazard
    Add Exposure       Other PL Exposure Low Hazard
    Add Exposure       Other PL Exposure Medium Hazard
    Add Exposure       PL NOC High Hazard
    Add Exposure       PL NOC Low Hazard
    Add Exposure       PL NOC Med Hazard
    Add Exposure       Painting
    Add Exposure       Paving
    Add Exposure       Pesticide / Herbicide Application
    Add Exposure       Phase I Environmental Assessments
    Add Exposure       Phase II and III Environmental Assessments
    Add Exposure       Pile Driving
    Add Exposure       Pipe and Tank Integrity Testing
    Add Exposure       Pipeline Installation
    Add Exposure       Plumbing - Commercial
    Add Exposure       Plumbing - Residential
    Add Exposure       Process Engineering
    Add Exposure       Project Management
    Add Exposure       Property Condition Assessments
    Add Exposure       Regulatory Compliance/Permitting
    Add Exposure       Remedial Design
    Add Exposure       Remediation Oversight
    Add Exposure       Rigging / Stevedoring
    Add Exposure       Road Construction
    Add Exposure       Roofing - Commercial
    Add Exposure       Roofing - Residential
    Add Exposure       Sampling
    Add Exposure       Soil Excavation
    Add Exposure       Soil Excavation / Grading
    Add Exposure       Soil Excavation â€“ Other than Petroleum
    Add Exposure       Soil Excavation â€“ Petroleum
    Add Exposure       Soil remediation
    Add Exposure       Street Cleaning
    Add Exposure       Tank Cleaning
    Add Exposure       Tank Lining
    Add Exposure       Tank Vapor Recovery Design
    Add Exposure       Tank Vapor Recovery Installation
    Add Exposure       Thermal Treatment
    Add Exposure       Training
    Add Exposure       Tunneling
    Add Exposure       UST Installation
    Add Exposure       UST Removal
    Add Exposure       UST Testing
    Add Exposure       UST Testing
    Add Exposure       Unexploded Ordinance
    Add Exposure       Utility Locating
    Add Exposure       Vapor Barrier Installation
    Add Exposure       Waste Broker
    Add Exposure       Wastewater Treatment Design
    Add Exposure       Wastewater Treatment Installation/Construction
    #Add Exposure      Demolition Contractor       <3
    Log To Console     ----- All Exposures Added Successfully ------



Complete All Subjectivities
    #Author= Amol Gaymukhe
    [Documentation]    Complete subjectivities
    VerifyText         Subjectivities
    ClickText          Subjectivities
    ScrollTo           Please provide business/mailing

    UseTable           Status
    ClickCell          r1c6                        index=2                     tag=span
    ClickElement       //lightning-base-combobox-item[@data-value\='Completed']
    ClickCell          r2c6                        index=2
    ClickElement       //lightning-base-combobox-item[@data-value\='Completed']


    ClickCell          r3c6                        index=2
    ClickElement       //lightning-base-combobox-item[@data-value\='Completed']


    ClickCell          r4c6                        index=2
    ClickElement       //lightning-base-combobox-item[@data-value\='Completed']


    ClickCell          r5c6
    ClickElement       //lightning-base-combobox-item[@data-value\='Completed']


    ClickCell          r6c6
    ClickElement       //lightning-base-combobox-item[@data-value\='Completed']

    ClickCell          r7c6
    ClickElement       //lightning-base-combobox-item[@data-value\='Completed']

    ClickText          Save                        anchor=Qualify Submission
    Log To Console     ----- Subjectivities Completed Successfully ------
