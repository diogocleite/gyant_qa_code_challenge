*** Keywords ***
Get List of Unreviewed Cases
  [ARGUMENTS]  ${expectedStatus}=${SUCCESS_RESPONSE}
  ${headers}=  Create Dictionary  Content-Type=application/json
  ${responseUnreviewed}=  Get On Session  User_Profile  ${relativePath}  headers=${headers}  expected_status=${expectedStatus}
  Set Test Variable  ${responseUnreviewed}
  Log  Unreviewed Response: ${responseUnreviewed.json()}

Import Cases
  [ARGUMENTS]  ${expectedStatus}=${SUCCESS_RESPONSE}
  ${headers}=  Create Dictionary  Content-Type=application/json
  ${responseImportCases}=  Post On Session  User_Profile  ${relativePath}  headers=${headers}  expected_status=${expectedStatus}
  Set Test Variable  ${responseImportCases}
  Log  Import Cases Response: ${responseImportCases.json()}

Delete Cases
  [ARGUMENTS]  ${expectedStatus}=${SUCCESS_RESPONSE}
  ${responseDelete}=  Delete On Session  User_Profile  ${relativePath}  expected_status=${expectedStatus}
  Set Test Variable  ${responseDelete}
  Log  Delete Cases Response: ${responseDelete.json()}

Review One Case
  [ARGUMENTS]  ${expectedStatus}=${SUCCESS_RESPONSE}
  ${responseReview}=  Put On Session  User_Profile  ${relativePath}  json=${bodyReview}  expected_status=${expectedStatus}
  Set Test Variable  ${responseReview}
  Log  Review Case Response: ${responseReview.json()}

Create Body To Review Case
  ${bodyReview}=  Evaluate  { "id": "${caseId}", "review": { "userId": "${responseLoginJson["id"]}", "conditionId": "${conditionId}" } }
  Set Test Variable  ${bodyReview}

Import New Cases
  Set Relative Path  /cases/import
  Import Cases

Delete All Cases
  Set Relative Path  /cases
  Delete Cases  any

Select One Case To Review
  ${cases}=  Set Variable  ${responseUnreviewed.json()}
  ${LAST_NUMBER_REVIEWS}=  Get Length  ${cases}
  Set Test Variable  ${LAST_NUMBER_REVIEWS}
  Should Not Be Empty  ${cases}
  ${caseId}=  Set Variable  ${cases[0]["id"]}
  Set Test Variable  ${caseId}

Create Invalid Body To Review Case
  ${bodyReview}=  Evaluate  { "id": "9932k3423483jr", "review": { "userId": "2903932rjdijdew", "conditionId": "390402ndksn121" } }
  Set Test Variable  ${bodyReview}