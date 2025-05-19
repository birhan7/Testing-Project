*** Settings ***
Library    SeleniumLibrary    timeout=300    implicit_wait=10
Resource    ../../resources/keywords.robot
Resource    ../../resources/products_keyword.robot
Resource    ../../variables/constants.robot


*** Test Cases ***
Test case 8: Delete Product From Cart
    Open Browser and Navigate to URL
    Verify Home Page Is Visible
    Hover And Add Product To Cart    ${PRODUCT1_NAME}    1
    Click View Cart Button
    Verify Product In Cart    ${PRODUCT1_NAME}    ${PRODUCT1_PRICE}    1    ${PRODUCT1_PRICE}
    Delete Product From Cart    ${PRODUCT1_NAME}
    Verify Product Is Removed From Cart    ${PRODUCT1_NAME}