*** Settings ***
Resource  ../../../Resources/Common.robot
Resource  ../../../Resources/Utils/UsersUtil.robot
Resource  ../../../Resources/Validators/UsersValidator.robot
Suite Setup  SetUp
Suite Teardown  Disconnect Database Mongo

*** Variables ***
${REGISTER_PATH}  /users/login

*** Test Cases ***
Login with an user success
  [Tags]  TEST
  Create New User To Login
  Set Relative Path  ${REGISTER_PATH}
  Create Body To Login
  Login User
  Validate User Login
  Validate Login On DB

Login With Invalid User
  [Tags]  TEST
  Set Relative Path  ${REGISTER_PATH}
  Create Invalid Body To Login
  Login User  400
  Validate Invalid User Login

*** Keywords ***
SetUp
  Create New Session
  Connect To Database Mongo