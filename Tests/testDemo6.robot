*** Settings ***
Documentation   To Validate the login form
...    and check if shop page is loaded and drive data from Resource.
Library     SeleniumLibrary
Library     BuiltIn
Library     Collections
Library     ../customLibaries/shop.py
Test Setup      open browser with payment url
#Test Setup      open browser with argument url     # Firefox
#Suite Setup,#Suite Teardown ->
#Once before and after all the tests in the file.
Test Teardown   close the existing browser
Resource        ../PageObjects/generic.robot
Resource        ../PageObjects/LandingPage.robot
Resource        ../PageObjects/ShopPage.robot
Resource        ../PageObjects/CheckoutPage.robot
Resource        ../PageObjects/ConfirmationPage.robot


*** Variables ***
@{listofprods}              iphone X    Samsung Note 8      Blackberry
${country_name}             India

*** Test Cases ***
Validate Unsuccessful login
    LandingPage.Fill the login form     ${user_name}     ${invalid_password}
    LandingPage.wait until element is located in the page
    LandingPage.verify if error message is correct

Validate cards display in the shop page
    LandingPage.Fill the login form     ${user_name}     ${valid_password}
    ShopPage.wait until element is located in the page
    ShopPage.verify if the cards titles are in the shop page
#    hello world
#    select the desired card        Blackberry   # comment this as custom method of multi selecting cards comes from our custom library
    select multiple desired cards     ${listofprods} #custom library
    click_on_checkout_button  #custom library
    CheckoutPage.Proceed to checkout page
    ConfirmationPage.Enter the country and select the terms       ${country_name}
    ConfirmationPage.Purchase the product and confirm

Select the form and navigate to alert popup
    LandingPage.Fill the login details and select the user pop-up     ${user_name}    ${valid_password}
