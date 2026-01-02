*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${URL}                    http://localhost:7272/Registration.html

*** Test Cases ***
Open Registration Page
    Open Chrome For Testing
    Go To    ${URL}
    Wait Until Element Is Visible    xpath=//h1    5s
    Element Text Should Be           xpath=//h1    Workshop Registration
    [Teardown]    Close Browser

*** Keywords ***
Open Chrome For Testing
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    Call Method    ${chrome_options}    add_argument    --start-maximized
    ${chrome_options.binary_location}=    Set Variable    ${CHROME_BROWSER_PATH}

    ${service}=    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path=r"""${CHROME_DRIVER_PATH}""")    modules=sys
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}
