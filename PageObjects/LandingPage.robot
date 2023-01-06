*** Settings ***
Documentation   All keywords of the landing page.
Library     SeleniumLibrary

*** Variables ***
${error_message_login}    css:.alert.alert-danger.col-md-12

*** Keywords ***
Fill the login form
    [arguments]     ${username}     ${password}
    input text  xpath://input[@id='username']   ${username}
    input password  CSS:#password    ${password}
    click button    id:signInBtn

wait until element is located in the page
    wait until element is visible    ${error_message_login}


VERIFY if error message is correct
    ${result}=  get text    ${error_message_login}
    should be equal as strings  ${result}   Incorrect username/password.
    element text should be  ${error_message_login}  Incorrect username/password.

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
