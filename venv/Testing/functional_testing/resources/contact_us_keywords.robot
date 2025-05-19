*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ../variables/contact_us_variables.robot


*** Keywords ***
Click Contact Us Button
    Click Link    xpath=//a[contains(@href,'contact_us')]
    Wait Until Page Contains    Contact Us    5s

Verify Get In Touch Visible
    Wait Until Element Is Visible    xpath=//h2[contains(text(),'GET IN TOUCH')]    10s
    Page Should Contain Element    xpath=//div[contains(@class,'contact-form')]

Fill Contact Form
    [Arguments]    ${name}    ${email}    ${subject}    ${message}    ${file_path}
    Input Text    name=name    ${name}
    Input Text    name=email    ${email}
    Input Text    name=subject    ${subject}
    Input Text    name=message    ${message}
    Choose File    name=upload_file    ${file_path}

Submit Contact Form
    Click Button    name=submit
    Sleep    2s    # Wait for form processing

Verify Success Message
    Wait Until Page Contains    Success! Your details have been submitted successfully.    10s
    Page Should Contain Element    xpath=//div[contains(@class,'status alert alert-success')]

Handle Success Alert
    # Handle JavaScript alert
    Handle Alert    accept
    Sleep    1s    # Wait for alert to close