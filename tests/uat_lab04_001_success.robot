*** Settings ***
Library    SeleniumLibrary    run_on_failure=Capture Page Screenshot
Suite Teardown    Close All Browsers

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${URL}                    http://localhost:7272/Registration.html

${FIRSTNAME}    Somyod
${LASTNAME}     Sodsai
${ORG}          CS KKU
${EMAIL}        somyod@kkumail.com
${PHONE}        091-001-1234

*** Test Cases ***
UAT-Lab04-001 Register Success (With Organization)
    Open Registration Page
    Fill Registration Form    ${FIRSTNAME}    ${LASTNAME}    ${ORG}    ${EMAIL}    ${PHONE}
    Click Register
    Verify Success Page

*** Keywords ***
Open Chrome For Testing
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    Call Method    ${chrome_options}    add_argument    --start-maximized
    ${chrome_options.binary_location}=    Set Variable    ${CHROME_BROWSER_PATH}

    ${service}=    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service(executable_path=r'''${CHROME_DRIVER_PATH}''')    modules=sys
    Create Webdriver    Chrome    options=${chrome_options}    service=${service}

Open Registration Page
    Open Chrome For Testing
    Go To    ${URL}
    Title Should Be    Registration
    Page Should Contain Element    xpath=//h1[normalize-space(.)="Workshop Registration"]

Fill Registration Form
    [Arguments]    ${fname}    ${lname}    ${org}    ${email}    ${phone}
    Input Text    id=firstname      ${fname}
    Input Text    id=lastname       ${lname}
    Input Text    id=organization   ${org}
    Input Text    id=email          ${email}
    Input Text    id=phone          ${phone}

Click Register
    Click Button    id=registerButton

Verify Success Page
    Title Should Be    Success
    Page Should Contain    Thank you for registering with us.
    Page Should Contain    We will send a confirmation to your email soon.
