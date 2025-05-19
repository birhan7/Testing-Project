*** Settings ***
Library    SeleniumLibrary
Resource    ../../variables/subscription_variables.robot

*** Test Cases ***
Cart Page Subscription Test
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be    Automation Exercise

    Click Link    xpath=//a[@href='/view_cart']    # Click on 'Cart' button

    Scroll Element Into View    xpath=//h2[text()='Subscription']
    Element Should Be Visible   xpath=//h2[text()='Subscription']

    Input Text    id=susbscribe_email    ${EMAIL}
    Click Button  id=subscribe

    Element Should Be Visible   xpath=//div[contains(text(),'${SUBSCRIPTION_MSG}')]

    [Teardown]    Close Browser
