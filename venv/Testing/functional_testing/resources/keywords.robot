*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ../variables/constants.robot

*** Keywords ***
Open Browser and Navigate to URL
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.1

Verify Home Page Is Visible
    Wait Until Page Contains    AutomationExercise
    Page Should Contain Element    xpath=//a[contains(text(),'Home')]

Click Signup/Login Button
    Click Link    xpath=//a[contains(text(),'Signup / Login')]

Verify Login Section Is Visible
    Wait Until Page Contains    Login to your account
    Page Should Contain    Login to your account

Enter Valid Credentials
    Input Text    xpath=//input[@data-qa='login-email']    ${VALID_EMAIL}
    Input Password    xpath=//input[@data-qa='login-password']    ${VALID_PASSWORD}

Click Login Button
    Click Button    xpath=//button[@data-qa='login-button']

Verify Successful Login
    Wait Until Page Contains    Logged in as
    Page Should Contain    Logged in as
    Capture Page Screenshot    after_login.png

Verify New User Signup Is Visible
    Wait Until Page Contains    New User Signup!
    Page Should Contain    New User Signup!

Enter Name and Email Address
    Input Text    name=name    ${NAME}
    ${EMAIL}=    Generate Unique Email
    Input Text    xpath=//input[@data-qa='signup-email']    ${EMAIL}

Generate Unique Email
    ${CURTIME}=    Get Time    epoch
    [Return]    testuser${CURTIME}@example.com

Click Signup Button
    Click Button    xpath=//button[@data-qa='signup-button']

Verify Enter Account Information Is Visible
    Wait Until Page Contains    ENTER ACCOUNT INFORMATION
    Page Should Contain    ENTER ACCOUNT INFORMATION

Fill Account Information
    # Title
    Click Element    id=id_gender1
    
    # Password
    Input Password    id=password    ${PASSWORD}
    
    # Date of Birth
    Select From List By Value    id=days    ${BIRTH_DAY}
    Select From List By Value    id=months    ${BIRTH_MONTH}
    Select From List By Value    id=years    ${BIRTH_YEAR}
    
    # Newsletters
    Select Checkbox    id=newsletter
    Select Checkbox    id=optin
    
    # Address Information
    Input Text    id=first_name    ${FIRST_NAME}
    Input Text    id=last_name    ${LAST_NAME}
    Input Text    id=company    ${COMPANY}
    Input Text    id=address1    ${ADDRESS1}
    Input Text    id=address2    ${ADDRESS2}
    
    # Country
    Select From List By Label    id=country    ${COUNTRY}
    
    # State/City/Zip
    Input Text    id=state    ${STATE}
    Input Text    id=city    ${CITY}
    Input Text    id=zipcode    ${ZIPCODE}
    Input Text    id=mobile_number    ${MOBILE_NUMBER}

Click Create Account Button
    Click Button    xpath=//button[@data-qa='create-account']

Verify Account Created Is Visible
    Wait Until Element Is Visible    xpath=//h2[@data-qa='account-created']    10s
    Element Text Should Be    xpath=//h2[@data-qa='account-created']/b    ACCOUNT CREATED!

Click Continue Button
    Click Link    xpath=//a[@data-qa='continue-button']

Verify Logged In As Username Is Visible
    Wait Until Page Contains    Logged in as ${NAME}
    Page Should Contain    Logged in as ${NAME}

Click Delete Account Button
    Click Link    xpath=//a[contains(text(),'Delete Account')]

Verify Account Deleted Is Visible
    Wait Until Element Is Visible    xpath=//h2[@data-qa='account-deleted']    10s
    Element Text Should Be    xpath=//h2[@data-qa='account-deleted']/b    ACCOUNT DELETED!

Click Continue Button After Deletion
    Click Link    xpath=//a[@data-qa='continue-button']
