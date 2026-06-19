*** Settings ***
Library               QWeb
Library               QForce
#Library              QVision
Library               FakerLibrary
Resource              ../resources/common.robot



*** Keywords ***
Verify All HomePage Elemets
    # Author = Amol
    [tags]            All
    Home
    VerifyText        Accounts
    VerifyText        Contacts
    VerifyText        Reports
    VerifyText        Policies
    VerifyText        Reports
    VerifyText        Dashboard

    UseModal          on
    VerifyText        My NB Submissions
    VerifyText        My Renewal Submissions      anchor=All NB Submissions
    VerifyText        My Quoted Submissions       anchor=All NB Submissions
    VerifyText        All NB Submissions          anchor=All NB Submissions


    VerifyText        All Renewal Submissions     anchor=All NB Submissions
    #ClickText        More                        anchor=All NB Submissions
    VerifyText        All Quoted Submissions      anchor=All NB Submissions
    #VerifyText       SFiles
    UseModal          Off

    VerifyText        YTD Report
    ClickElement      //span[text()\='App Launcher']
    TypeText          //input[@placeholder\='Search apps and items...']       FEI Insurance
    ClickText         FEI Insurance
    VerifyText        FEI Insurance               anchor=Home
    Log To Console    Homepge Elements Verified