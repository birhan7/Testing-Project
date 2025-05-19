*** Settings ***
Resource    ../../resources/products_keyword.robot
Resource    ../../resources/keywords.robot

*** Test Cases ***
Test case 5: View First Product And Verify Details
    Open Browser and Navigate to URL
    Verify Home Page Is Visible
    Click Products Button
    Verify All Products Page Is Visible
    Verify Product List Is Visible
    Click First View Product
    Verify Product Detail Page Is Visible
    Verify Product Detail Information