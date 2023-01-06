*** Settings ***
Documentation   To Validate the login form
...    and check if shop page is loaded and drive data from Resource.
Library     SeleniumLibrary
Library     BuiltIn
Library     Collections
Library     String
Test Setup      open browser with payment url
#Test Teardown   close the existing browser
Resource        ../PageObjects/generic.robot

*** Variables ***
${error_message_login}    css:.alert.alert-danger.col-md-12
${shop_page_load}        xpath://a[@class='nav-link btn btn-primary']


*** Test Cases ***
Validate child window login functionality
    [Tags]      SMOKE
    Select the link of child window
    Verify if child window is opened
    Grab the email id in the child window
    Switch to parent window and enter in the email


*** Keywords ***
Select the link of child window
    click link      css:.blinkingText
    sleep   5


Verify if child window is opened
   @{handles}=    get window handles  browser=CURRENT
       FOR     ${element}      IN      @{handles}
       log     ${element}
       END
   switch window        url=https://rahulshettyacademy.com/#/documents-request
   element text should be   xpath://h1[normalize-space()='Documents request']   DOCUMENTS REQUEST

Grab the email id in the child window
    ${emailtext}=    get text    css:.red
    @{words}=   Split String    ${emailtext}    at
    ${text_split}=      get from list   ${words}    1
    log     ${text_split}
    @{words2}=    split string    ${text_split}
    ${email}=   get from list   ${words2}   0
    log     ${email}
    set global variable     ${email}

Switch to parent window and enter in the email
    switch window   MAIN        # parent window
    title should be     LoginPage Practise | Rahul Shetty Academy
    input text      id:username     ${email}