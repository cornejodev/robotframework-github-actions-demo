*** Settings ***
Documentation            Github Actions and Robot Framework demo 
Library                  SeleniumLibrary       

#Run commands:
#robot -v HEADLESS_MODE:False -v BROWSER:ff -d Results  Tests/Site.robot
#robot -v HEADLESS_MODE:True -v BROWSER:headlessfirefox -d Results  Tests/Site.robot

*** Variables ***
${BROWSER}                      chrome
${HEADLESS_MODE}                ${False}                     
${LANDING_PAGE_URL}             https://www.saucedemo.com/
${INVENTORY_URL}                https://www.saucedemo.com/inventory.html

#Credentials
@{VALID_USERNAME}               standard_user
...                             locked_out_user
...                             problem_user
...                             performance_glitch_user
...                             error_user
...                             visual_user

${VALID_PASSWORD}               secret_sauce

#Locators
${USERNAME_TEXT_BOX}            xpath=//input[@id='user-name']
${PASSWORD_TEXT_BOX}            xpath=//input[@id='password']
${LOGIN_BUTTON}                 xpath=//input[@id='login-button']

*** Test Cases ***

Landing page should load
    Log To Console   HEADLESS_MODE:${headless_mode} BROWSER:${browser}
    Open Browser     about:blank             ${BROWSER}
    Go To                                    ${LANDING_PAGE_URL}
    Close All Browsers

Login with credentials 
    Log To Console                           HEADLESS_MODE:${HEADLESS_MODE} BROWSER:${BROWSER}
    
    Open Browser     about:blank             ${BROWSER}
    Go To                                    ${LANDING_PAGE_URL}
    Input Text                               ${USERNAME_TEXT_BOX}     ${VALID_USERNAME}[0]
    Input Text                               ${PASSWORD_TEXT_BOX}     ${VALID_PASSWORD}
    Click Element                            ${LOGIN_BUTTON}
    Location Should Be                       ${INVENTORY_URL}    
    Close All Browsers

Add item to cart 
    Log To Console                           HEADLESS_MODE:${HEADLESS_MODE} BROWSER:${BROWSER}
    
    Open Browser     about:blank             ${BROWSER}
    Go To                                    ${LANDING_PAGE_URL}
    Input Text                               ${USERNAME_TEXT_BOX}     ${VALID_USERNAME}[0]
    Input Text                               ${PASSWORD_TEXT_BOX}     ${VALID_PASSWORD}
    Click Element                            ${LOGIN_BUTTON}
    Location Should Be                       ${INVENTORY_URL}
    Click Element                            xpath=//button[@id='add-to-cart-sauce-labs-backpack']            
    Wait Until Element Is Visible            xpath=//button[@id='remove-sauce-labs-backpack']    
    Close All Browsers