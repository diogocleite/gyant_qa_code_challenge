*** Settings ***
Resource  UsersUtil.robot
Resource  CasesUtil.robot
Resource  ConditionsUtil.robot

*** Keywords ***
SetUp DB
  Set Relative Path  /users/register
  ${bodyRegister}=  Evaluate  { "name": "Doctor Who", "email": "who@doctor.com", "password": "qwerty" }
  Set Test Variable  ${bodyRegister}
  Register User  400
  Import New Cases
  Set Relative Path  /conditions/import
  Import Conditions

Login
  Wait Until Element Is Visible  //*[@id="login"]
  ${emailInput}=  Set Variable  //*[@id="login"]/input[@placeholder="email"]
  Input Text  ${emailInput}  who@doctor.com
  ${passwordInput}=  Set Variable  //*[@id="login"]/input[@placeholder="password"]
  Input Text  ${passwordInput}  qwerty
  ${loginButton}=  Set Variable  //*[@id="login"]/input[@type="submit"]
  Click Button  ${loginButton}

Response to All The Cases
  Wait Until Element Contains  //*[@id="loginInfo"]  Logged in as: Doctor Who
  Wait Until Page Contains  Please review this case:
  Select From List By Value  //*[@id="conditions"]  604b858d095f565a46b08667
  Wait Until Element Is Enabled  //*[@id="nextCase"]
  Click Button  //*[@id="nextCase"]
  Wait Until Element Is Visible  //*[@id="nextCase" and @disabled="true"]
  Select From List By Value  //*[@id="conditions"]  604b858d095f565a46b0872e
  Wait Until Element Is Enabled  //*[@id="nextCase"]
  Click Button  //*[@id="nextCase"]
  Wait Until Element Is Visible  //*[@id="nextCase" and @disabled="true"]
  Select From List By Value  //*[@id="conditions"]  604b858d095f565a46b0871d
  Wait Until Element Is Enabled  //*[@id="nextCase"]
  Click Button  //*[@id="nextCase"]