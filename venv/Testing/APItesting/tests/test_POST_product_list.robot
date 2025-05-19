*** Settings ***
Library           RequestsLibrary
Resource    ../variables/constants.robot

*** Test Cases ***
Test Case 2: Verify POST Request Not Allowed On Products List API
    Create Session    api    https://automationexercise.com
    ${response}=      Post On Session    api    /api/productsList
    Status Should Be  200    ${response}
    Should Contain    ${response.text}    This request method is not supported.
