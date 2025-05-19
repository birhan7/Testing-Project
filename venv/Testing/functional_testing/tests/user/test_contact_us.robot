*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords.robot
Resource   ../../resources/contact_us_keywords.robot

*** Test Cases ***
Test case 4: Submit Contact Us Form And Verify Success Message
    Open Browser and Navigate to URL
    Click Contact Us Button
    Fill Contact Form
    Upload File
    Click Submit Button
    Handle Alert    ACCEPT
    Verify Success Message Is Visible
    Click Home Button
    Verify Home Page Is Visible
