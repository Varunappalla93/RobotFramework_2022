*** Settings ***
Documentation   To Validate the login form
Library     SeleniumLibrary
Library     BuiltIn
Test Teardown   close browser


*** Variables ***
${error_message_login}    css:.alert.alert-danger.col-md-12

*** Test Cases ***
Validate Unsuccessful login
    open browser with payment url
    Fill the login form
    wait until it checks and displays error message
    verify if error message is correct


*** Keywords ***
open browser with payment url
    create webdriver    Chrome  executable_path=C:/Users/VARUN/Desktop/Varun_Personal/Appium_Python_2022 _Material/chromedriver_win32/chromedriver
    go to   https://www.rahulshettyacademy.com/loginpagePractise/
    maximize browser window



Fill the login form
    input text  xpath://input[@id='username']   rahulshettyacademy
    input password  CSS:#password    12334
    click button    id:signInBtn

wait until it checks and displays error message
    wait until element is visible   ${error_message_login}      5

VERIFY if error message is correct
    ${result}=  get text    ${error_message_login}
    should be equal as strings  ${result}   Incorrect username/password.
    element text should be  ${error_message_login}  Incorrect username/password.
