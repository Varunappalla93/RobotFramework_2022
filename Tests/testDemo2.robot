*** Settings ***
Documentation   To Validate the login form
...    and check if shop page is loaded and drive data from Resource.
Library     SeleniumLibrary
Library     BuiltIn
Library     Collections
Test Setup      open browser with payment url
Test Teardown   close the existing browser
Resource        ../PageObjects/generic.robot


*** Variables ***
${error_message_login}    css:.alert.alert-danger.col-md-12
${shop_page_load}        xpath://a[@class='nav-link btn btn-primary']


*** Test Cases ***
Validate Unsuccessful login
    [Tags]      SMOKE   REGRESSION
    Fill the login form     ${user_name}     ${invalid_password}
    wait until element is located in the page   ${error_message_login}
    verify if error message is correct

Validate cards display in the shop page
    Fill the login form     ${user_name}     ${valid_password}
    wait until element is located in the page   ${shop_page_load}
    verify if the cards titles are in the shop page
    select the desired card        Blackberry

Select the form and navigate to alert popup
    Fill the login details and select the user pop-up     ${user_name}    ${valid_password}


*** Keywords ***
Fill the login form
    [arguments]     ${username}     ${password}
    input text  xpath://input[@id='username']   ${username}
    input password  CSS:#password    ${password}
    click button    id:signInBtn


wait until element is located in the page
    [arguments]     ${element}
    wait until element is visible    ${element}

VERIFY if error message is correct
    ${result}=  get text    ${error_message_login}
    should be equal as strings  ${result}   Incorrect username/password.
    element text should be  ${error_message_login}  Incorrect username/password.


verify if the cards titles are in the shop page
    @{expectedlist}=        create list     iphone X    Samsung Note 8      Nokia Edge      Blackberry
    @{elements}=      get webelements     css:.card-title
    @{actuallist}=      create list

    FOR     ${element}      IN      @{elements}
        log     ${element.text}
        append to list      ${actuallist}       ${element.text}
    END

    lists should be equal   ${expectedlist}      ${actuallist}


select the desired card
    [arguments]     ${cardname}
    @{elements}=    get webelements     css:.card-title
    ${index}=        set variable   1
    FOR     ${element}      IN      @{elements}
           exit for loop if     '${cardname}'=='${element.text}'

            ${index}=   evaluate   ${index}+1
    END
    click button        xpath:(//div[@class='card-footer'])[${index}]/button

Fill the login details and select the user pop-up
    [arguments]     ${username}     ${password}
    input text  xpath://input[@id='username']   ${username}
    input password  CSS:#password    ${password}
    click element       xpath://input[@value='user']
    wait until element is visible           xpath://div[@class='modal-body']
    click element       id:okayBtn
    wait until element is not visible       xpath://div[@class='modal-body']
    select from list by label   xpath://select[@class='form-control']     Teacher
    select checkbox     xpath://input[@id='terms']
    checkbox should be selected     xpath://input[@id='terms']