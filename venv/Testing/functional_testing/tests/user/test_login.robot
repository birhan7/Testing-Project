*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
Test Case 2: Login User With Correct Email And Password
    [Documentation]    Verify user can login to account successfully
    Open Browser and Navigate to URL
    Verify Home Page Is Visible
    Click Signup/Login Button
    Verify Login Section Is Visible
    Enter Valid Credentials
    Click Login Button
    Verify Successful Login
    [Teardown]    Close Browser
