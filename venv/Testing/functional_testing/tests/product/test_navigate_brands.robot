*** Settings ***
Library           SeleniumLibrary
Resource    ../../resources/keywords.robot
Resource    ../../resources/products_keyword.robot

*** Test Cases ***
Test case 10: Verify Brands Navigation Functionality
    Open Browser and Navigate to URL
    Click Products Button
    Verify Brands Sidebar Is Visible
    Click Brand And Verify Products Page