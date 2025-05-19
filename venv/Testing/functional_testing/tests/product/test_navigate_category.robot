*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords.robot
Resource    ../../resources/products_keyword.robot
Resource    ../../variables/constants.robot

*** Test Cases ***
Test case 9: Navigate And Verify Women And Men Categories
    Open Browser and Navigate to URL
    Verify Home Page Is Visible
    Verify Categories Sidebar Is Visible
    Click Women Category And Select Dress
    Verify Women Category Page Displayed
    Click Men Category And Select Tshirts
    Verify Men Category Page Displayed