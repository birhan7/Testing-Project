*** Settings ***
Resource    ../../resources/keywords.robot
Resource    ../../resources\products_keyword.robot

*** Test Cases ***
Test Case 6: Search Product And Verify Results
    Open Browser and Navigate to URL
    Verify Home Page Is Visible
    Click Products Button
    Verify All Products Page Is Visible
    Enter Search Term And Click Search
    Verify Searched Products Section Is Visible
    Verify Search Results Are Displayed
