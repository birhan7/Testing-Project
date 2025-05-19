*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}       https://automationexercise.com
${ENDPOINT}       /api/brandsList

*** Test Cases ***
Test Case 3: Verify GET Request For Brands List API
    Create Session    api    ${BASE_URL}
    ${response}=      Get On Session    api    ${ENDPOINT}
    Status Should Be  200    ${response}
    ${json}=           To Json    ${response.content}
    Should Contain     ${json}    brands
    ${brands_count}=  Evaluate    len(${json['brands']})
    Should Be True     ${brands_count} > 0
    
