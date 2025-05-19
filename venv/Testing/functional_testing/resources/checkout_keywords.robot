*** Settings ***
Library    SeleniumLibrary
Library    String
Library    OperatingSystem
Resource    ../variables/checkout_variables.robot

*** Keywords ***
Click Proceed To Checkout
    Click Element    xpath=//a[text()='Proceed To Checkout']
    
Verify Address Details And Review Order
    Wait Until Page Contains    Review Your Order
    Page Should Contain         ${ADDRESS1}
    Page Should Contain         ${CITY}
    Page Should Contain         ${ZIPCODE}

Enter Description And Place Order
    Input Text    name=message    Please deliver ASAP
    Click Element    xpath=//a[text()='Place Order']

Enter Payment Details And Confirm
    Input Text    name=name_on_card    ${CARD_NAME}
    Input Text    name=card_number     ${CARD_NUMBER}
    Input Text    name=cvc             ${CVC}
    Input Text    name=expiry_month    ${EXP_MONTH}
    Input Text    name=expiry_year     ${EXP_YEAR}
    Click Button  id=submit

Verify Order Success Message
    Wait Until Page Contains    Your order has been placed successfully!

Download Invoice And Verify
    Click Element    css:a.btn.btn-default.check_out[href^="/download_invoice"]
    Sleep           3s    # Wait for download
    ${file_path}=    Set Variable    ${DOWNLOADS_DIR}/invoice.txt
    File Should Exist    ${file_path}

    Click Element    css:a.btn-primary[data-qa="continue-button"]