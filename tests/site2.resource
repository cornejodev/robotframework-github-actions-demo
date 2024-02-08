*** Settings ***
Documentation       Github Actions and Robot Framework demo

Library             SeleniumLibrary
# Run commands example:
# robot -v HEADLESS_MODE:False -v BROWSER:ff -d results    tests/site.robot
# robot -v HEADLESS_MODE:True -v BROWSER:headlessfirefox -d results    tests/site.robot
# Pabot command example:
# 2 processes per core - 8 cores equal 16 processes
# pabot --testlevelsplit --processes 16 --argumentfile argfile.txt tests
# pabot --verbose --testlevelsplit --processes 8 --argumentfile argfile.txt tests
# s


*** Variables ***
${BROWSER}              chrome
${HEADLESS_MODE}        ${FALSE}
${LANDING_PAGE_URL}     https://www.saucedemo.com/
${INVENTORY_URL}        https://www.saucedemo.com/inventory.html

${VALID_PASS_PASS}      ${EMPTY}

# Credentials
@{VALID_USERNAME}       standard_user
...                     locked_out_user
...                     problem_user
...                     performance_glitch_user
...                     error_user
...                     visual_user

${VaLID_password}       secret_sauce

# Locators
${USERNAME_TEXT_BOX}    xpath=//input[@id='user-name']
${PASSWORD_TEXT_BOX}    xpath=//input[@id='password']
${LOGIN_BUTTON}         xpath=//input[@id='login-button']


*** Keywords ***
Landing Page Should Load
    Log To Console
    ...    HEADLESS_MODE:${HEADLESS_MODE} BROWSER:${BROWSER}
    Open Browser
    ...    about:blank
    ...    ${BROWSER}
    Go To    ${LANDING_PAGE_URL}
    Close All Browsers

Login With Credentials
    Log To Console
    ...    HEADLESS_MODE:${HEADLESS_MODE} BROWSER:${BROWSER}

    Open Browser
    ...    about:blank
    ...    ${BROWSER}
    Go To    ${LANDING_PAGE_URL}
    Input Text
    ...    ${USERNAME_TEXT_BOX}
    ...    ${VALID_USERNAME}[0]
    Input Text
    ...    ${PASSWORD_TEXT_BOX}
    ...    ${VALID_PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    Location Should Be    ${INVENTORY_URL}
    Close All Browsers

Add Item To Cart
    Log To Console
    ...    HEADLESS_MODE:${HEADLESS_MODE} BROWSER:${BROWSER}

    Open Browser
    ...    about:blank
    ...    ${BROWSER}
    Go To    ${LANDING_PAGE_URL}
    Input Text
    ...    ${USERNAME_TEXT_BOX}
    ...    ${VALID_USERNAME}[0]
    Input Text
    ...    ${PASSWORD_TEXT_BOX}
    ...    ${VALID_PASSWORD}
    Click Element    ${LOGIN_BUTTON}
    Location Should Be    ${INVENTORY_URL}
    Click Element
    ...    xpath=//button[@id='add-to-cart-sauce-labs-backpack']
    Wait Until Element Is Visible
    ...    xpath=//button[@id='remove-sauce-labs-backpack']
    Close All Browsers

Logged Out User Should Be Able To Search For A Product
    [Documentation]    Test product lookup    while    logged out
    [Tags]    002    smoke    search
    Log    message
