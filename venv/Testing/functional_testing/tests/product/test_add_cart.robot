*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Resource    ../../resources/keywords.robot
Resource    ../../resources/products_keyword.robot
Resource    ../variables/constants.robot

*** Test Cases ***
Test case 7: Add Two Products To Cart And Verify Details
    Open Browser and Navigate to URL
    Verify Home Page Is Visible
    Click Products Button
    Hover And Add Product To Cart    ${PRODUCT1_NAME}    1
    Hover And Add Product To Cart    ${PRODUCT2_NAME}    2
    Click View Cart Button
    Verify Product In Cart    ${PRODUCT1_NAME}    ${PRODUCT1_PRICE}    1    ${PRODUCT1_PRICE}
    Verify Product In Cart    ${PRODUCT2_NAME}    ${PRODUCT2_PRICE}    1    ${PRODUCT2_PRICE}