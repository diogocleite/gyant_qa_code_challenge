*** Settings ***
Resource  ../../Resources/Common.robot
Resource  ../../Resources/Utils/FrontendUtils.robot
Test Setup  SetUp
Test Teardown  End Session Frontend

*** Test Cases ***
Login in Frontend
  [TAGS]  TEST
  Login
  Wait Until Element Contains  //*[@id="loginInfo"]  Logged in as: Doctor Who
  Capture Page Screenshot

Validate If Cases Are Shown
  [TAGS]  TEST
  Login
  Wait Until Element Contains  //*[@id="loginInfo"]  Logged in as: Doctor Who
  Wait Until Element Is Visible  //*[@id="content"]/div/h2[@class="caseTitle"]
  Element Should Contain  //*[@id="content"]/div/h2[@class="caseTitle"]  Please review this case:
  Element Should Contain  //*[@id="content"]/div/h2[@class="conditionsTitle"]  Select Condition:
  ${selected}=  Get Selected List Label  //*[@id="conditions"]
  Should Be Equal  ${selected}  Select Condition
  ${allOptions}=  Get List Items  //*[@id="conditions"]
  ${allOptionsLength}=  Get Length  ${allOptions}
  Should Be True  ${allOptionsLength}>10
  ${textCase}=  Get Text  //*[@id="case"]
  ${textCaseLength}=  Get Length  ${textCase}
  Should Be True  ${textCaseLength}>100
  Capture Page Screenshot

Response To All The Cases
  [TAGS]  TEST
  Login
  Response to All The Cases
  Wait Until Page Contains  You are done.
  Capture Page Screenshot

Logout
  [TAGS]  TEST
  Login
  Response to All The Cases
  Wait Until Page Contains  You are done.
  Element Should Be Visible  //*[@id="logout"]
  Click Button  //*[@id="logout"]
  Element Should Not Be Visible  //*[@id="logout"]
  Element Should Be Visible  //*[@id="login"]
  Wait Until Page Contains  Please Login to review cases.
  Capture Page Screenshot

### NEGATIVES ###
Login With Invalid Credentials
  [TAGS]  TEST
  Login  invalid@gmail.com
  Wait Until Element Contains  //*[@id="swal2-title"]  Invalid Login
  Element Should Contain  //*[@id="swal2-content"]  User with email: "invalid@gmail.com" not found.
  Click Button  //button[@class="swal2-confirm swal2-styled"]
  Element Should Be Visible  //*[@id="login"]
  Capture Page Screenshot

*** Keywords ***
SetUp
  SetUp DB
  Create New Session Frontend

