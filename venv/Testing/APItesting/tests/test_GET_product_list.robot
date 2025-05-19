*** Settings ***
Library           RequestsLibrary
Resource    ../variables/constants.robot

*** Test Cases ***
Test case 1: Verify Products List API Returns 200 and Products
    Create Session    api_session    ${BASE_URL}
    ${response}=      GET On Session    api_session    ${ENDPOINT}
    Status Should Be    200    ${response}
    ${json}=           To Json    ${response.content}
    Should Contain     ${json}    products
    ${product_count}=  Evaluate    len(${json['products']})
    Should Be True     ${product_count} > 0
