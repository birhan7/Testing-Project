*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       https://automationexercise.com
${ENDPOINT}       /api/brandsList

*** Test Cases ***
Verify PUT Request Not Allowed On Brands List API
    Create Session    api    https://automationexercise.com
    ${response}=      Put On Session    api    /api/brandsList
    Status Should Be  405    ${response}    # <- Expecting 405 here
    Should Contain    ${response.text}    This request method is not supported.
