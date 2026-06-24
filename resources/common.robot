*** Settings ***
Library                         QWeb
Library                         QForce
Library                         String
Library                         Collections
Library                         DateTime
Library                         OperatingSystem



*** Variables ***
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${BROWSER}                      chrome
#${username}                    pace.delivery1@qentinel.com.demonew
#${login_url}                   https://qentinel--demonew.my.salesforce.com/            # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/page/home



*** Keywords ***
Setup Browser
    # Setting search order is not really needed here, but given as an example
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order    QForce                      QWeb
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    Evaluate                    random.seed()               random                      # initialize random generator
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow
    # adds a delay of 0.3 between keywords. This is helpful in cloud with limited resources.
    #SetConfig                  Delay                       0.3


Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}                 delay=1
    ClickText                   Log In to Sandbox
    TypeText                    Password                    ${password}
    ClickText                   Log In to Sandbox
    # We'll check if variable ${secret} is given. If yes, fill the MFA dialog.
    # If not, MFA is not expected.
    # ${secret} is ${None} unless specifically given.
    Sleep                       5s
    ${MFA_Text_One}=            IsText                      Use the authenticator app on your mobile device to generate a verification code.
    IF                          "${MFA_Text_One}" == "True"
        ${MFA_needed}=          Run Keyword And Return Status                           Should Not Be Equal         ${None}         ${secret}
        Run Keyword If          ${MFA_needed}               Fill MFA
        Log To Console          Login using MFA
    END


Fill MFA
    ${mfa_code}=                GetOTP                      ${username}                 ${secret}                   ${login_url}
    TypeSecret                  Verification Code           ${mfa_code}
    ClickText                   Verify


Home
    [Documentation]             Navigate to homepage, login if needed
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.                  2
    Run Keyword If              ${login_status}             Login
    ClickText                   Home
    VerifyTitle                 Home | Salesforce

Click on save button
    ClickText                   Save
    VerifyText                  Success                     anchor=Account updated

Click on NEXT:Submission Info
    ClickText                   NEXT:Submission Info >


Global search
    [Documentation]             searching and navigating to name with specific type
    [Arguments]                 ${name}
    ${found}=                   Convert To Boolean          False
    WHILE                       not ${found}
        RefreshPage
        ClickText               Search...
        # ClickElement          //button[contains(@aria-label,'Search')]
        TypeText                Search...                   ${name}
        Sleep                   2s
        ClickText               Show more results for "${name}"
        Sleep                   5s
        ${found}=               IsNoText                    Don't give up yet!
    END

    VerifyText                  We searched for "${name}"

Home2
    #Author=Amol Gaymukhe
    [Documentation]             Navigate to homepage, login if needed
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.                  2
    Run Keyword If              ${login_status}             Login2
    ClickText                   Home
    VerifyTitle                 Home | Salesforce


Login2
    #Author=Amol Gaymukhe
    [Documentation]             Login to Salesforce instance
    GoTo                        ${login_url}
    TypeText                    Username                    ${username_L2}              delay=1s
    TypeText                    Password                    ${password_L2}              delay=2s
    ClickText                   Log In
    # We'll check if variable ${secret} is given. If yes, fill the MFA dialog.
    # If not, MFA is not expected.
    # ${secret} is ${None} unless specifically given.
    Sleep                       5s
    ${MFA_Text}=                IsText                      Use the authenticator app on your mobile device to generate a verification code.
    IF                          "${MFA_Text}" == "True"
        ${MFA_needed}=          Run Keyword And Return Status                           Should Not Be Equal         ${None}         ${secret_L2}
        Run Keyword If          ${MFA_needed}               Fill MFAtwo
        Log To Console          Login using MFA

    END


Fill MFAtwo
    #Author=Amol Gaymukhe
    ${mfa_code}=                GetOTP                      ${username_L2}              ${secret_L2}                ${login_url}
    TypeSecret                  Verification Code           ${mfa_code}
    ClickText                   Verify

    # Example of custom keyword with robot fw syntax
    # VerifyStage
    #                           [Documentation]             Verifies that stage given in ${text} is at ${selected} state; either selected (true) or not selected (false)
    #                           [Arguments]                 ${text}                     ${selected}=true
    #                           VerifyElement               //a[@title\="${text}" and (@aria-checked\="${selected}" or @aria-selected\="${selected}")]


    # NoData
    #                           VerifyNoText                ${data}                     timeout=3                   delay=2


    # DeleteAccounts
    #                           [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    #                           ClickText                   ${data}
    #                           ClickText                   Delete
    #                           VerifyText                  Are you sure you want to delete this account?
    #                           ClickText                   Delete                      2
    #                           VerifyText                  Undo
    #                           VerifyNoText                Undo
    #                           ClickText                   Accounts                    partial_match=False


    # DeleteLeads
    #                           [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    #                           ClickText                   ${data}
    #                           ClickText                   Delete
    #                           VerifyText                  Are you sure you want to delete this lead?
    #                           ClickText                   Delete                      2
    #                           VerifyText                  Undo
    #                           VerifyNoText                Undo
    #                           ClickText                   Leads                       partial_match=False


Logout

    [Documentation]             Logout

    ClickText                   View profile
    ClickText                   Log Out
    VerifyText                  Remember me                 timeout=30s