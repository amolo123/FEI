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

Select Trucking
    # Author = Amol Gaymukhe
    [Documentation]    Select Trucking Product
    [tags]             Insured Info
    ClickText          Home                        anchor=FEI Insurance
    ClickElement       //span[text()\='App Launcher']
    TypeText           //input[@placeholder\='Search apps and items...']       FEI Insurance
    ClickText          FEI Insurance
    VerifyText         FEI Insurance               anchor=Home
    VerifyText         New                         anchor=Printable View
    ClickText          New
    ClickElement       //button/span[text()\="Select Product"]
    ClickText          Trucking                    anchor=Product
    ClickText          Next


Enter Data Into Submission Info Page Trucking
    # Author = Amol Gaymukhe
    [Documentation]    Enter Data in Submission Console
    [tags]             Submission Console
    VerifyText         Account Information
    ClickElement       (//input[@placeholder\="Search..."])[1]
    TypeText           (//input[@placeholder\="Search..."])[1]                 ${uniqueName}              anchor=Account Name
    ClickElement       (//li[@role\='presentation']/span)[1]
    # TypeText         //label[text()\='Broker Contact']/parent::*//lightning-input                       Automation FEI
    # PressKey         //label[text()\='Broker Contact']/parent::*//lightning-input                       {ENTER}
    ClickElement       //label[text()\='Broker Contact']/parent::*//lightning-input                       timeout=20s
    TypeText           //label[text()\='Broker Contact']/parent::*//lightning-input                       Automa
    # ClickElement     //label[text()\='Broker Contact']/parent::*//lightning-input                       timeout=20s
    # PressKey         //label[text()\='Broker Contact']/parent::*//lightning-input                       {Enter}
    # ClickText        Automation FEI              partial_match=false
    # ClickText          Automation FEI - CAMERON MUT INS CO - Cameron - Missouri
    ClickElement       //span[contains(text(),'Automation FEI')]
    ClickElement       (//button[text()\='Save'])
    VerifyText         Success!                    anchor=Record is saved !    timeout=25s


Validate field on Submission Console page for Trucking
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console

    Scroll             //html                      page_up
    VerifyAll          Stage, Broker Name, Agency Name, Agency Address, CSR
    VerifyAll          Follow, Import SAN, Filing Review, Send Mail, New Event, New Note, Delete
    VerifyAll          Underwriter Workbench, Activity, Files & Notes , Sfiles, History, G Trac
    VerifyAll          Account Name, Business Type, Billing Address, Phone, Country, Credit Score, Street, Customer Intel Order Date, City, State, PostalCode
    VerifyAll          Broker Information, Broker Contact, Relationship Type
    VerifyAll          Product Selection, Available, Selected
    VerifyAll          Submission Information, Writing Company, Carrier Commission, Writing Company(Excess), Carrier Commission(Excess)
    VerifyAll          Writing Company(PD Surplus), Carrier Commission(PD Surplus), CSR, Underwriter, Stage, Workflow Status
    VerifyAll          Closed Reason, Decline Comment, Owner, Type, Application Type
    VerifyAll          Key Dates, Effective Date, Received Date, Expiration Date, Close Date, Quote Due Date, Maven
    VerifyAll          Maven, Garage State, Operation Type, Power Unit Count, Vehicle Score, Driver Score, Hazmat Score
    VerifyAll          Submission Complete, Percentage hazmat >10%, Large Loss on Expiring
    VerifyAll          Maven Response



Check Import SAN form fields
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console

    ClickElement       //button[text()\='Import SAN']
    UseModal           On
    VerifyText         Import SAN
    VerifyAll          SAN No., PD SAN No., Cancel, Proceed
    ClickText          Cancel
    UseModal           Off

    # Check Filing Review form fields
    #                  # Author = Gaymukhe
    #                  [Documentation]             Validating all the elements on submission Console Page
    #                  [tags]                      Submission Console
    #                  ClickElement                //button[text()\='Filing Review']




    # Check Send Mail form fields
    #                  # Author = Gaymukhe
    #                  [Documentation]             Validating all the elements on submission Console Page
    #                  [tags]                      Submission Console
    #                  ClickElement                //button[text()\='Send Mail']


Check New Event form fields
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console
    ClickElement       //button[text()\='New Event']
    UseModal           On
    VerifyText         New Event
    VerifyAll          Subject, Description, Start, End, Date, Time
    VerifyAll          Location, Name, Related To, Cancel, Save
    ClickText          Cancel


Check New Note form fields
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console
    ClickElement       //button[text()\='New Note']
    VerifyText         Title
    VerifyAll          Visibility Set by Record, Compose text, Related to, Add to Records, Done
    ClickElement       //span[text()\='Close']

Check Delete form fields
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console
    ClickElement       //button[text()\='Delete']
    VerifyText         Delete Submission
    VerifyAll          Cancel, Delete
    ClickText          Cancel

Create New Event  
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console
    ClickElement       //button[text()\='New Event']
    UseModal           On
    ClickText          Subject
    ClickText          Other
    TypeText           Description                 Hello Darkness
    TypeText           Location                    California
    ClickText          Save                        anchor=Cancel


Create Import SAN Button Functionality
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console
    ClickElement       //button[text()\='Import SAN']
    UseModal           On
    VerifyText         Import SAN
    TypeText           SAN No.                     5216351AJ00000
    TypeText           PD SAN No.                  7216351AJ00000
    ClickText          Proceed                     anchor=Cancel
    Sleep              20s

Create New Note Button Functionality
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console
    ClickElement       //button[text()\='New Note']
    TypeText           Title                       My Title
    TypeText           Compose text                My Compose text
    ClickText          Done                        anchor=Add to Records
    VerifyText         Your note was created.      timeout=35s

Click on Delete Button and Remove Opportunity
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console
    ClickElement       //button[text()\='Delete']
    VerifyText         Delete Submission
    ClickText          Delete
    VerifyText         Recently Viewed             timeout=45s

Enter Full data On Submission Info Page  
    # Author = Amol Gaymukhe
    [Documentation]    Validating all the elements on submission Console Page
    [tags]             Submission Console
    PickList           Business Type               Individual
    PickList           Application Type            FEI New Business Application
    ClickElement       (//button[text()\='Save'])
    VerifyText         Success!                    anchor=Record is saved !    timeout=25s


Import SAN NO and PD SAN NO
    # Author = Amol Gaymukhe
    [Documentation]    San No Import
    [tags]             Submission Console
    [Arguments]        ${SAN_NO}                   ${PD_SAN_NO}
    ClickElement       //button[text()\='Import SAN']
    UseModal           On
    VerifyText         Import SAN
    TypeText           SAN No.                     ${SAN_NO}
    TypeText           PD SAN No.                  ${PD_SAN_NO}
    ClickText          Proceed                     anchor=Cancel
    Sleep              15s
    VerifyText         Account Name                timeout=60s


Add Product 
    # Author = Amol Gaymukhe
    [Documentation]    Add Product
    [tags]             Submission Console
    [Arguments]        ${product}
    VerifyText         Product Selection
    MultiPickList      Product Selection           ${product}                  action=Move to Selected