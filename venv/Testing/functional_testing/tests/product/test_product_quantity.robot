*** Settings ***
Library           SeleniumLibrary
Resource    ../../resources/keywords.robot
Resource    ../../resources/products_keyword.robot
Resource    ../variables/constants.robot

*** Test Cases ***
Test case 7: Add Product With Quantity And Verify In Cart
    Open Browser and Navigate to URL
    Verify Home Page Is Visible
    Click First View Product
    Verify Product Detail Page Is Visible
    Set Product Quantity    ${QUANTITY}
    Click Add To Cart Button
    Click View Cart Button
    Verify Product Is In Cart With Quantity    ${QUANTITY}