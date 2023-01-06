*** Settings ***
Documentation   All keywords of the landing page.
Library     SeleniumLibrary

*** Variables ***
${shop_page_load}        xpath://a[@class='nav-link btn btn-primary']


*** Keywords ***
wait until element is located in the page
    wait until element is visible    ${shop_page_load}


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