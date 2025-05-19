*** Settings ***
Resource    ../../resources/keywords.robot

*** Test Cases ***
Test Case 1: Register User
    [Documentation]    Complete user registration
    Open Browser and Navigate to URL
    Verify Home Page Is Visible
    Click Signup/Login Button
    Verify New User Signup Is Visible
    Enter Name and Email Address
    Click Signup Button
    Fill Account Information
    Click Create Account Button
    Verify Account Created Is Visible
    [Teardown]    Close Browser
