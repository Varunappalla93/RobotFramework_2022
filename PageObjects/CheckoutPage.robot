*** Settings ***
Documentation   All keywords of the Checkout page.
Library     SeleniumLibrary


*** Keywords ***
Proceed to checkout page
    click element       xpath://button[normalize-space()='Checkout']
