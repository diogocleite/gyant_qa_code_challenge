*** Settings ***
Resource  ../../../Resources/Common.robot
Resource  ../../../Resources/Utils/CasesUtil.robot
Resource  ../../../Resources/Utils/UsersUtil.robot
Resource  ../../../Resources/Validators/CasesValidator.robot
Suite Setup  SetUp
Suite Teardown  Disconnect Database Mongo

*** Variables ***
${IMPORT_PATH_CASES}  /cases/import

*** Test Cases ***
Import Cases
  [Tags]  TEST
  Delete All Cases
  Set Relative Path  ${IMPORT_PATH_CASES}
  Import Cases
  Validate Import Cases

*** Keywords ***
SetUp
  Create New Session
  Connect To Database Mongo
