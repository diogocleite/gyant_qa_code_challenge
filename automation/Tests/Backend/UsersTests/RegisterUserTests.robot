*** Settings ***
Resource  ../../../Resources/Common.robot
Resource  ../../../Resources/Utils/UsersUtil.robot
Resource  ../../../Resources/Validators/UsersValidator.robot
Suite Setup  SetUp
Suite Teardown  Disconnect Database Mongo

*** Variables ***
${REGISTER_PATH}  /users/register

*** Test Cases ***
Register a user with success
  [Tags]  TEST
  Set Relative Path  ${REGISTER_PATH}
  Create Body To Register User
  Register User
  Validate Register Response
  Validate Register On DB

### NEGATIVE ###
Register a user fail
  [Tags]  TEST
  Set Relative Path  ${REGISTER_PATH}
  Create Body To Register User
  Register User
  Register User  400
  Validate Register User Fail

*** Keywords ***
SetUp
  Create New Session
  Connect To Database Mongo