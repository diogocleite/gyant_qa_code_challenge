*** Settings ***
Resource  ../../../Resources/Common.robot
Resource  ../../../Resources/Utils/CasesUtil.robot
Resource  ../../../Resources/Utils/UsersUtil.robot
Resource  ../../../Resources/Validators/CasesValidator.robot
Suite Setup  SetUp
Suite Teardown  Disconnect Database Mongo

*** Variables ***
${UNREVIEWED_PATH_CASES}  /cases/unreviewed/{userId}
${DYNAMIC_VARIABLE}  {userId}
${INVALID_ID}  9999999999999

*** Test Cases ***
Get List of the cases to Review
  [Tags]  TEST
  Import New Cases
  Create New User To Login
  Login New User
  Set Dynamic Relative Path  ${UNREVIEWED_PATH_CASES}  ${DYNAMIC_VARIABLE}  ${responseLoginJson["id"]}
  Get List of Unreviewed Cases
  Validate List of Unreviewed Cases

Get List of the cases to Review Invalid Id
  [Tags]  TEST
  Set Dynamic Relative Path  ${UNREVIEWED_PATH_CASES}  ${DYNAMIC_VARIABLE}  ${INVALID_ID}
  Get List of Unreviewed Cases  400
  Validate List of Unreviewed Cases With Invalid Id

*** Keywords ***
SetUp
  Create New Session
  Connect To Database Mongo