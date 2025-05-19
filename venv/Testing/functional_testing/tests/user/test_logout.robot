*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
Test Case 3: Logout User 
    [Documentation]    Verify user can logout successfully
    Open Browser and Navigate to URL
    Verify Home Page Is Visible
    Click Signup/Login Button
    Verify Login Section Is Visible
    Enter Valid Credentials
    Click Login Button
    Verify Successful Login
    Click Element    xpath=//a[text()=' Logout']
    Verify Login Section Is Visible