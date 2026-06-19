*** Settings ***
Library                     QWeb
Library                     QForce
Library                     String
Library                     Collections
Library                     DateTime
Library                     OperatingSystem

*** Keywords ***
Move to outputdir

    ${ret}=                 Generate Random String      3
    IF                      "${EXECDIR}"=="/home/executor/execution"
    # normal test run environment
        ${downloads_folder}=                            Set Variable                /home/executor/Downloads
        Log To Console      Folder set Regression
    ELSE                    # Live Testing environment
        ${downloads_folder}=                            Set Variable                /home/services/Downloads
        Log To Console      Folder set Live
    END
    Log To Console          If success
    Sleep                   5s
    #Get file name from download folder
    ${count}=               Count Files In Directory    ${downloads_folder}
    Log To Console          ${count}
    @{downloads}=           List Files In Directory     ${downloads_folder}         *.pdf
    Log Many                @{downloads}
    ${pdf_file}=            Get From List               ${downloads}                0
    Log To Console          PDF Filename: ${pdf_file}
    Set Suite Variable      ${pdf_file}
    Log To Console          PDF File success
    #Moving file to Outpur dir so it will be attached to the run
    Move File               ${downloads_folder}/${pdf_file}                         ${OUTPUT_DIR}
   
    # ${count2}=            Count Files In Directory    ${OUTPUT_DIR}
    # Log To Console        ${count2}
    # ${br}=                Empty Directory             ${OUTPUT_DIR}
    # Sleep                 2s


ReadingPDF
    UsePdf                  ${OUTPUT_DIR}/${pdf_file}


Test PDF File
    [Arguments]             ${pdftext}
    ReadingPDF
    ${AllPDFtext}=          GetPdfText
    # Log To Console          ${AllPDFtext}
    Set Global Variable     ${AllPDFtext}
    VerifyPDFText           ${pdftext}

Empty Directory command

    ${count}=               Count Files In Directory    ${OUTPUT_DIR}
    Log To Console          ${count}
    @{downloads}=           List Files In Directory     ${OUTPUT_DIR}
    Log Many                @{downloads}
    # ${count2}=            Count Files In Directory    ${downloads_folder}
    # Log To Console        ${count}
    ${bdir}=                Empty Directory             ${OUTPUT_DIR}
    Sleep                   2s
    IF                      "${EXECDIR}"=="/home/executor/execution"
    # normal test run environment
        ${downloads_folder}=                            Set Variable                /home/executor/Downloads
        Log To Console      Folder set Regression
    ELSE                    # Live Testing environment
        ${downloads_folder}=                            Set Variable                /home/services/Downloads
        Log To Console      Folder set Live
    END
    Log To Console          If success
    Sleep                   5s
    #Get file name from download folder
    ${count}=               Count Files In Directory    ${downloads_folder}
    Log To Console          ${count}
    ${cdir}=                Empty Directory             ${downloads_folder}