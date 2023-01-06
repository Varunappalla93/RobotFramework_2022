*** Settings ***
Documentation   All keywords of the Confirmation page.
Library     SeleniumLibrary

*** Variables ***
${country_text}    xpath://a[contains(text(),'India')]


*** Keywords ***
Enter the country and select the terms
    [arguments]     ${countryname}
    input text      id:country      ${countryname}
    wait until element is visible       xpath://a[contains(text(),'${countryname}')]    10
    click element    xpath://a[contains(text(),'${countryname}')]
    click element       xpath://label[@for='checkbox2']

Purchase the product and confirm
    click button   xpath://input[@value='Purchase']
    page should contain     Success!