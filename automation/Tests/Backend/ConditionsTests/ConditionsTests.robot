*** Settings ***
Resource  ../../../Resources/Common.robot
Resource  ../../../Resources/Utils/ConditionsUtil.robot
Resource  ../../../Resources/Validators/ConditionsValidator.robot
Suite Setup  SetUp
Suite Teardown  Disconnect Database Mongo

*** Variables ***
${REGISTER_PATH_CONDITIONS}  /conditions

*** Test Cases ***
Get List of Conditions
  [Tags]  TEST
  Set Relative Path  ${REGISTER_PATH_CONDITIONS}
  Get Conditions List
  Validate Conditions

*** Keywords ***
SetUp
  Create New Session
  Connect To Database Mongo