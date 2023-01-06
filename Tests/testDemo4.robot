*** Settings ***
Documentation   To Validate the login form
Library     SeleniumLibrary
Library     BuiltIn
#Test Teardown   close browser
Test Template       Validate Unsuccessful login

*** Variables ***
${error_message_login}    css:.alert.alert-danger.col-md-12

*** Test Cases ***      usernames        passwords
Invalid username        varun           varun@123
Invalid password        rahulshetty     pcloudfg
special characters      %$Q#^           learning


*** Keywords ***
Validate Unsuccessful login
    [arguments]     ${username}     ${password}
    open browser with payment url
    Fill the login form     ${username}     ${password}
    wait until it checks and displays error message
    verify if error message is correct

open browser with payment url
    create webdriver    Chrome  executable_path=C:/Users/VARUN/Desktop/Varun_Personal/Appium_Python_2022 _Material/chromedriver_win32/chromedriver
    go to   https://www.rahulshettyacademy.com/loginpagePractise/
    maximize browser window

Fill the login form
    [arguments]     ${username}     ${password}
    input text  xpath://input[@id='username']   ${username}
    input password  CSS:#password    ${password}
    click button    id:signInBtn

wait until it checks and displays error message
    wait until element is visible   ${error_message_login}      5

VERIFY if error message is correct
    ${result}=  get text    ${error_message_login}
    should be equal as strings  ${result}   Incorrect username/password.
    element text should be  ${error_message_login}  Incorrect username/password.