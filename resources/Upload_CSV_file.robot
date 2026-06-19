*** Settings ***
Library                         QWeb
Library                         QForce
Library                         String
Library                         Collections
Library                         DateTime
Library                         OperatingSystem
Library                         QVision

*** Keywords ***
Upload CSV file
    [Documentation]    Keyword for uploading files, using the project structure (${CURDIR}/resources)
    [Arguments]                 ${file_name}
    Set Library Search Order     QVision
    sleep                       3s    
    
    ${file_path}=    Convert To String    ${CURDIR}/resources
    @{folders}     Split String     ${file_path}    separator=/
    
    FOR    ${folder}    IN    @{folders}
        IF    '${folder}' != ''
            DoubleClick       ${folder}    
        END
    END

    DoubleClick           ${file_name}