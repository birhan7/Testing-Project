*** Settings ***
Library           SeleniumLibrary
Resource    ../../resources/products_keyword.robot
Resource    ../../resources/keywords.robot
Resource    ../../variables/constants.robot

*** Test Cases ***
Test case 11: Write Review For Product
    [Documentation]    Verify product review submission functionality
    Open Browser and Navigate to URL
    Click Products Button
    Click First View Product
    Verify Review Section Visible
    Submit Product Review    ${REVIEW_NAME}    ${REVIEW_EMAIL}    ${REVIEW_TEXT}
    Verify Review Success Message
    [Teardown]    Close Browser