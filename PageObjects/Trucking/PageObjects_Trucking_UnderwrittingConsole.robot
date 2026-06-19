*** Settings ***
Library                QWeb
Library                QForce
#Library               QVision
Library                FakerLibrary
Library                String
Library                BuiltIn
Library                DateTime
Resource               ../../resources/common.robot
Resource               ../PageObjects_Account.robot
Resource               ../PageObjects_HomePage.robot
Resource               ../Freberg_Common.robot



*** Keywords ***
Validate field on Underwrtting Console page for Trucking
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on Underwrtting Console Page
    [tags]             Underwrtting Console
    VerifyText         Vehicle Schedule
    VerifyAll          Number, Year, Make, Model
    VerifyAll          POLAR, PETERBILT, HEIL, BEAL
    VerifyAll          Additional Insured, Loss Detail, Broker Notice, Comments, Subjectivities
    VerifyAll          Name, Product/Coverage, Description, Stage
    VerifyAll          Name, Product/Coverage, Description, Stage, Type, Status, Edit/Save, Delete
    # VerifyAll          BRF, FEIN, TRK FEI app, TRK Financials, TRK TRIA, Vehicle Sched



Validate field on Underwrtting Console page for Trucking Excess
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on Underwrtting Console Page
    [tags]             Underwrtting Console
    VerifyAll          Indicative premium, Excess Limit, Garage State, Hazard Group, Hazard Group Factor, Excess Product Selection, GL Credit/Debit
    VerifyAll          AL Credit/Debit, Underlying Auto Premium, Vehicle Type, Count, Vehicle Schedule
    VerifyAll          Number, Year, Make, Model
    VerifyAll          POLAR, PETERBILT, HEIL, BEAL
    VerifyAll          Additional Insured, Loss Detail, Broker Notice, Comments, Subjectivities
    VerifyAll          Name, Product/Coverage, Description, Stage, Type, Status, Edit/Save, Delete
    # VerifyAll          BRF, FEIN, TRK FEI app, TRK Financials, TRK TRIA, Vehicle Sched




