*** Settings ***
Resource  ../../../Resources/Common.robot
Resource  ../../../Resources/Utils/CasesUtil.robot
Resource  ../../../Resources/Utils/UsersUtil.robot
Resource  ../../../Resources/Utils/ConditionsUtil.robot
Resource  ../../../Resources/Validators/CasesValidator.robot
Suite Setup  SetUp
Suite Teardown  Disconnect Database Mongo

*** Variables ***
${UNREVIEWED_PATH_CASES}  /cases/unreviewed/{userId}
${REVIEW_PATH_CASES}  /cases/review
${DYNAMIC_VARIABLE}  {userId}

*** Test Cases ***
Review Case
  [Tags]  TEST
  Import New Cases
  Create New User To Login
  Login New User
  Select One Condition
  Set Dynamic Relative Path  ${UNREVIEWED_PATH_CASES}  ${DYNAMIC_VARIABLE}  ${responseLoginJson["id"]}
  Get List of Unreviewed Cases
  Select One Case To Review
  Create Body To Review Case
  Set Relative Path  ${REVIEW_PATH_CASES}
  Review One Case
  Validate Review Response

Review Invalid Case
  [Tags]  TEST
  Create Invalid Body To Review Case
  Set Relative Path  ${REVIEW_PATH_CASES}
  Review One Case  400
  Validate Invalid Review Response

*** Keywords ***
SetUp
  Create New Session
  Connect To Database Mongo
