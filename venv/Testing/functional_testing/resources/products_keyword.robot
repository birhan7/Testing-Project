*** Settings ***
Library           SeleniumLibrary

*** Keywords ***
Click Products Button
    Click Link    xpath=//a[@href='/products']

Verify All Products Page Is Visible
    Wait Until Page Contains Element    xpath=//h2[@class='title text-center' and normalize-space()='All Products']    10s
    Page Should Contain Element    xpath=//h2[@class='title text-center' and normalize-space()='All Products']

Verify Product List Is Visible
    Wait Until Element Is Visible    xpath=//div[@class='features_items']/div[contains(@class,'col-sm-4')]

Click First View Product
    Click Element    xpath=(//a[text()='View Product'])[1]

Verify Product Detail Page Is Visible
    Wait Until Element Is Visible    xpath=//div[@class='product-information']
    Page Should Contain Element      xpath=//div[@class='product-information']

Verify Product Detail Information
    Page Should Contain Element    xpath=//div[@class='product-information']/h2         # Product name
    Page Should Contain Element    xpath=//div[@class='product-information']/p[contains(text(),'Category')]
    Page Should Contain Element    xpath=//div[@class='product-information']/span/span  # Price
    Page Should Contain Element    xpath=//*[contains(@class,'product-info')]//*[contains(text(),'Availability')]
    Page Should Contain Element    xpath=//*[contains(@class,'product-info')]//*[contains(text(),'Condition')]
    Page Should Contain Element    xpath=//*[contains(@class,'product-info')]//*[contains(text(),'Brand')]

Enter Search Term And Click Search
    Input Text     xpath=//input[@id='search_product']     ${SEARCH_TERM}
    Click Button   xpath=//button[@id='submit_search']

Verify Searched Products Section Is Visible
    Wait Until Page Contains    SEARCHED PRODUCTS
    Page Should Contain         Searched Products

Verify Search Results Are Displayed
    Wait Until Element Is Visible    xpath=//div[@class='features_items']/div[contains(@class,'col-sm-4')]
    ${count}=    Get Element Count    xpath=//div[@class='features_items']/div[contains(@class,'col-sm-4')]
    Should Be True    ${count} > 0

Hover And Add Product To Cart
    [Arguments]    ${product_name}    ${product_id}
    # Scroll to make element visible
    Scroll Element Into View    xpath=//div[contains(@class,'productinfo') and .//p[text()='${product_name}']]
    
    # Hover using multiple methods
    Mouse Over    xpath=//div[contains(@class,'productinfo') and .//p[text()='${product_name}']]
    Execute JavaScript    window.dispatchEvent(new Event('scroll'));
    
    # Wait for button to be ready
    Wait Until Element Is Visible    xpath=//div[.//p[text()='${product_name}']]//a[@data-product-id='${product_id}']    10s
    
    # Try multiple click methods
    ${click_success}=    Run Keyword And Return Status    Click Element    xpath=//div[.//p[text()='${product_name}']]//a[@data-product-id='${product_id}']
    Run Keyword Unless    ${click_success}    JavaScript Click    //div[.//p[text()='${product_name}']]//a[@data-product-id='${product_id}']

JavaScript Click
    [Arguments]    ${xpath}
    ${element_exists}=    Execute JavaScript    return document.evaluate("${xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue !== null
    Run Keyword If    not ${element_exists}    Fail    Element ${xpath} not found
    Execute JavaScript    document.evaluate("${xpath}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()

Click View Cart Button
    Wait Until Element Is Visible    xpath=//u[text()='View Cart']
    Click Element    xpath=//u[text()='View Cart']

Verify Two Products Are In Cart
    Wait Until Page Contains Element    xpath=//tr[@id='product-1']
    Wait Until Page Contains Element    xpath=//tr[@id='product-2']

Verify Product In Cart
    [Arguments]    ${product_name}    ${unit_price}    ${quantity}    ${total_price}
    [Documentation]    Verifies product details in cart using the specific table structure
    
    # Verify product row exists
    Wait Until Element Is Visible    
    ...    xpath=//table[@id='cart_info_table']//tr[starts-with(@id,'product-')][.//a[normalize-space()='${product_name}']]
    ...    timeout=10s
    ...    error=Product '${product_name}' not found in cart
    
    # Store the product row locator
    ${product_row}=    Set Variable    
    ...    xpath=//table[@id='cart_info_table']//tr[starts-with(@id,'product-')][.//a[normalize-space()='${product_name}']]
    
    # Verify unit price
    Element Text Should Be    
    ...    ${product_row}//td[@class='cart_price']/p
    ...    ${unit_price}
    ...    message=Unit price for '${product_name}' doesn't match
    
    # Verify quantity (using the disabled button text)
    Element Text Should Be    
    ...    ${product_row}//td[@class='cart_quantity']/button
    ...    ${quantity}
    ...    message=Quantity for '${product_name}' doesn't match
    
    # Verify total price
    Element Text Should Be    
    ...    ${product_row}//td[@class='cart_total']/p[@class='cart_total_price']
    ...    ${total_price}
    ...    message=Total price for '${product_name}' doesn't match
    
    # Additional verification - product image exists
    Element Should Be Visible    
    ...    ${product_row}//td[@class='cart_product']/a/img
    ...    message=Product image missing for '${product_name}'

Set Product Quantity
    [Arguments]    ${QUANTITY}
    Clear Element Text    xpath=//input[@id='quantity']
    Input Text            xpath=//input[@id='quantity']    ${QUANTITY}

Click Add To Cart Button
    Click Element    css=button.btn-default.cart > i.fa-shopping-cart

Verify Product Is In Cart With Quantity
    [Arguments]    ${QUANTITY}
    Wait Until Element Is Visible    xpath=//tr[contains(@id,'product')]/td[@class='cart_quantity']/button
    ${actual_quantity}=    Get Text    xpath=//tr[contains(@id,'product')]/td[@class='cart_quantity']/button
    Should Be Equal As Strings    ${actual_quantity}    ${QUANTITY}

Delete Product From Cart
    [Arguments]    ${product_name}
    [Documentation]    Deletes specified product from cart
    Click Element    xpath=//tr[contains(@id,'product-')][.//a[normalize-space()='${product_name}']]//a[@class='cart_quantity_delete']
    Wait Until Element Is Not Visible    xpath=//tr[contains(@id,'product-')][.//a[normalize-space()='${product_name}']]    10s

Verify Product Is Removed From Cart
    [Arguments]    ${product_name}
    [Documentation]    Verifies product is removed and empty cart message appears
    
    # 1. Verify product row is gone
    Wait Until Page Does Not Contain Element    
    ...    xpath=//tr[contains(@id,'product-')][.//a[normalize-space()='${product_name}']]
    ...    timeout=10s
    ...    error=Product '${product_name}' is still present in cart
    
    # 2. Verify empty cart message (using the exact element structure)
    Wait Until Element Is Visible    
    ...    xpath=//p[@class='text-center' and contains(.,'Cart is empty!')]//b[contains(.,'Cart is empty!')]
    ...    timeout=10s
    ...    error=Empty cart message not displayed
    
    # 3. Verify the "Click here" link exists
    Element Should Be Visible    
    ...    xpath=//p[@class='text-center']/a[contains(@href,'/products')]
    ...    message=Products link missing in empty cart message
    

Verify Categories Sidebar Is Visible
    Wait Until Element Is Visible    xpath=//div[@class='left-sidebar']
    Page Should Contain Element      xpath=//h2[text()='Category']


Click Women Category And Select Dress
    Click Element    xpath=//a[@href='#Women']
    Wait Until Element Is Visible    xpath=//a[contains(text(),'Dress')]
    Click Element    xpath=//a[contains(text(),'Dress')]

Verify Women Category Page Displayed
    [Documentation]    Verifies Women category page is displayed
    
    ${title_text}=    Get Text    xpath=//h2[@class='title text-center']
    Should Contain    ${title_text}    WOMEN
    Should Contain    ${title_text}    PRODUCTS
    

Click Men Category And Select Tshirts
    Click Element    xpath=//a[@href='#Men']
    Wait Until Element Is Visible    xpath=//a[contains(text(),'Tshirts')]
    Click Element    xpath=//a[contains(text(),'Tshirts')] 

Verify Men Category Page Displayed
    [Documentation]    Comprehensive verification of men's category page
    
    # 1. Verify heading
    Wait Until Element Is Visible    
    ...    xpath=//h2[contains(@class,'title')][contains(.,'Men')]
    ...    timeout=10s
    
    # 2. Verify URL pattern
    ${current_url}=    Get Location
    Should Contain    ${current_url}    category_products
    
    # 3. Verify product grid
    ${products}=    Get WebElements    css=div.features_items div.productinfo
    Should Not Be Empty    ${products}    No products found in men's category
    
    # 4. Verify at least one men's product
    ${mens_products}=    Get Element Count    xpath=//div[contains(@class,'productinfo')][contains(.,'Men') or contains(.,'Tshirt')]
    Should Be True    ${mens_products} > 0    No men's tshirts found in products grid

Verify Brands Sidebar Is Visible
    Wait Until Element Is Visible    xpath=//div[@class='brands_products']
    Page Should Contain Element      xpath=//h2[text()='Brands']

Click Brand And Verify Products Page
    Element Should Be Visible    xpath=//a[@href='/brand_products/Polo' and .//text()[contains(., 'Polo')]]
    Click Element                xpath=//a[@href='/brand_products/Polo' and .//text()[contains(., 'Polo')]]
    Wait Until Page Contains Element    xpath=//h2[@class='title text-center']    10s
    Element Text Should Be    xpath=//h2[@class='title text-center']    BRAND - POLO PRODUCTS
    Page Should Contain Element    xpath=//div[@class='features_items']//div[contains(@class,'product-image-wrapper')]

Verify Review Section Visible
    Scroll Element Into View    id=review-form

Submit Product Review
    [Arguments]    ${name}    ${email}    ${review}
    Input Text    id=name    ${name}
    Input Text    id=email    ${email}
    Input Text    id=review    ${review}
    Click Button    id=button-review

Verify Review Success Message
    Wait Until Page Contains    Thank you for your review.    10s
    Page Should Contain Element    xpath=//div[contains(@class,'alert-success') and contains(.,'Thank you')]