*** Settings ***
Library           SeleniumLibrary
Library           String
Library           Collections
Resource    ../../resources/keywords.robot
Resource    ../../variables/checkout_variables.robot
Resource    ../../resources/keywords.robot
Resource    ../../resources/checkout_keywords.robot


*** Test Cases ***
Full Checkout and Delete Account Flow
    Open Browser and Navigate to URL

    # Add Products to Cart
    Click Element    xpath=(//a[contains(text(),'Add to cart')])[1]
    Wait Until Element Is Visible    xpath=//button[text()='Continue Shopping']
    Click Button     xpath=//button[text()='Continue Shopping']

    # Go to Cart
    Click Link    xpath=//a[@href='/view_cart']
    Wait Until Page Contains Element    xpath=//li[@class='active' and contains(text(),'Shopping Cart')]

    # Proceed to Checkout
    Click Element    css:a.btn.btn-default.check_out

    # Go to Login / Signup
    Click Element    css:p.text-center > a[href="/login"]

    Enter Valid Credentials
    Click Login Button
    Verify Successful Login

    # Return to Cart
    Click Link    xpath=//a[@href='/view_cart']

    # Proceed to Checkout Again
    Click Element    css:div.col-sm-6 > a.btn.btn-default.check_out

    # Verify Address and Review Order
    Page Should Contain    Address Details
    Page Should Contain    Review Your Order

    # Enter Comment and Place Order
    Input Text    name=message    Please deliver fast
    Click Element    css:a.btn.btn-default.check_out[href="/payment"]

    # Payment Details
    Input Text    name=name_on_card     ${CARD_NAME}
    Input Text    name=card_number      ${CARD_NUMBER}
    Input Text    name=cvc              ${CVC}
    Input Text    name=expiry_month     ${EXP_MONTH}
    Input Text    name=expiry_year      ${EXP_YEAR}
    Click Button  id=submit

    # Verify Order Placed
    Wait Until Element Is Visible    css:p[style*="font-size: 20px"][style*="font-family: garamond"]    10s
    Element Should Contain    css:p[style*="font-size: 20px"]    Your order has been confirmed!

    Download Invoice And Verify

    [Teardown]    Close Browser




