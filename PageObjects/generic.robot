*** Settings ***
Documentation   a resource file to reuse keywords and variables
Library     SeleniumLibrary

*** Variables ***
${user_name}    rahulshettyacademy
${invalid_password}    12334
${valid_password}    learning
${url}      https://www.rahulshettyacademy.com/loginpagePractise/
${browsername}      Firefox

*** Keywords ***
open browser with argument url
    [arguments]     ${browser_name}
    create webdriver    ${browsername}  executable_path=Resources/${browser_name}
    go to   ${url}
    maximize browser window

open browser with payment url
    create webdriver    Chrome  executable_path=C:/Users/VARUN/Desktop/Varun_Personal/Appium_Python_2022 _Material/chromedriver_win32/chromedriver
    go to   ${url}
    maximize browser window

close the existing browser
    close browser