*** Settings ***
Resource  ../../../Resources/Common.robot
Resource  ../../../Resources/Utils/CasesUtil.robot
Resource  ../../../Resources/Validators/CasesValidator.robot
Suite Setup  SetUp
Suite Teardown  Disconnect Database Mongo

*** Variables ***
${DELETE_PATH_CASES}  /cases

*** Test Cases ***
Delete Cases
  [Tags]  TEST
  Import New Cases
  Set Relative Path  ${DELETE_PATH_CASES}
  Delete Cases
  Validate No Cases Existence

Delete Cases Fail
  [Tags]  TEST
  Import New Cases
  Set Relative Path  ${DELETE_PATH_CASES}
  Delete Cases  any
  Delete Cases  400
  Validate Fail Delete Cases

*** Keywords ***
SetUp
  Create New Session
  Connect To Database Mongo
