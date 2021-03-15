*** Settings ***
Resource  ../../../Resources/Common.robot
Resource  ../../../Resources/Utils/ConditionsUtil.robot
Resource  ../../../Resources/Validators/ConditionsValidator.robot
Suite Setup  SetUp
Suite Teardown  Disconnect Database Mongo

*** Variables ***
${REGISTER_PATH_CONDITIONS}  /conditions
${REGISTER_PATH_CONDITIONS_IMPORT}  /conditions/import

*** Test Cases ***
Create Condition
  [Tags]  TEST
  Set Relative Path  ${REGISTER_PATH_CONDITIONS}
  Create Body To Create Condition
  Create Condition
  Validate New Condition

Conditions Import
  [Tags]  TEST
  Set Relative Path  ${REGISTER_PATH_CONDITIONS_IMPORT}
  Import Conditions
  Validate Conditions Import

### NEGATIVES ###
Create Invalid Condition
  [Tags]  TEST
  Set Relative Path  ${REGISTER_PATH_CONDITIONS}
  Create Invalid Body To Create Condition
  Create Condition  422
  Validate Invalid New Condition

*** Keywords ***
SetUp
  Create New Session
  Connect To Database Mongo