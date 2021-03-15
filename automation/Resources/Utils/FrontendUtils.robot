*** Settings ***
Resource  UsersUtil.robot
Resource  CasesUtil.robot
Resource  ConditionsUtil.robot

*** Keywords ***
SetUp DB
  Create Session  User_Profile  ${BASE_URL}
  Connect To Database Mongo
  Set Relative Path  /users/register
  ${bodyRegister}=  Evaluate  { "name": "Doctor Who", "email": "who@doctor.com", "password": "qwerty" }
  Set Test Variable  ${bodyRegister}
  Register User  any
  Import New Cases
  Import New Conditions
  Delete All Sessions
  Disconnect Database Mongo

Login
  [ARGUMENTS]  ${emailIn}=who@doctor.com  ${passwordIn}=qwerty
  Wait Until Element Is Visible  //*[@id="login"]
  ${emailInput}=  Set Variable  //*[@id="login"]/input[@placeholder="email"]
  Input Text  ${emailInput}  ${emailIn}
  ${passwordInput}=  Set Variable  //*[@id="login"]/input[@placeholder="password"]
  Input Text  ${passwordInput}  ${passwordIn}
  ${loginButton}=  Set Variable  //*[@id="login"]/input[@type="submit"]
  Click Button  ${loginButton}

Response to All The Cases
  Wait Until Element Contains  //*[@id="loginInfo"]  Logged in as: Doctor Who
  Wait Until Page Contains  Please review this case:
  Wait Until Element Is Visible  //option[@value="${conditionId}"]
  Select From List By Value  //*[@id="conditions"]  ${conditionId}
  Wait Until Element Is Enabled  //*[@id="nextCase"]
  Click Button  //*[@id="nextCase"]
  Wait Until Element Is Visible  //*[@id="nextCase" and @disabled="true"]
  Wait Until Element Is Visible  //option[@value="${conditionId}"]
  Select From List By Value  //*[@id="conditions"]  ${conditionId}
  Wait Until Element Is Enabled  //*[@id="nextCase"]
  Click Button  //*[@id="nextCase"]
  Wait Until Element Is Visible  //*[@id="nextCase" and @disabled="true"]
  Wait Until Element Is Visible  //option[@value="${conditionId}"]
  Select From List By Value  //*[@id="conditions"]  ${conditionId}
  Wait Until Element Is Enabled  //*[@id="nextCase"]
  Click Button  //*[@id="nextCase"]