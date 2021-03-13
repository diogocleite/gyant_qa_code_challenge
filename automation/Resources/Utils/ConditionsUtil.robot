*** Keywords ***
Get Conditions List
  [ARGUMENTS]  ${expectedStatus}=${SUCCESS_RESPONSE}
  ${headers}=  Create Dictionary  Content-Type=application/json
  ${responseConditions}=  Get On Session  User_Profile  ${relativePath}  headers=${headers}  expected_status=${expectedStatus}
  Set Test Variable  ${responseConditions}
  Log  Conditions Response: ${responseConditions.json()}

Import Conditions
  [ARGUMENTS]  ${expectedStatus}=${SUCCESS_RESPONSE}
  ${headers}=  Create Dictionary  Content-Type=application/json
  ${responseConditionsImport}=  Post On Session  User_Profile  ${relativePath}  headers=${headers}  expected_status=${expectedStatus}
  Set Test Variable  ${responseConditionsImport}
  Log  Conditions Import Response: ${responseConditionsImport.json()}

Create Condition
  [ARGUMENTS]  ${expectedStatus}=${SUCCESS_RESPONSE}
  ${headers}=  Create Dictionary  Content-Type=application/json
  ${responseCondition}=  Post On Session  User_Profile  ${relativePath}  json=${bodyCondition}  headers=${headers}  expected_status=${expectedStatus}
  Set Test Variable  ${responseCondition}
  Log  Conditions Response: ${responseCondition.json()}

Create Body To Create Condition
  ${newCodeCondition}=  Generate Random String  5
  ${newCodeCondition}=  Catenate  B  ${newCodeCondition}
  ${newDescriptionCondition}=  Generate Random String  5
  ${newDescriptionCondition}=  Catenate  TEST   ${newDescriptionCondition}
  ${bodyCondition}=  Evaluate  { "code": "${newCodeCondition}", "description": "${newDescriptionCondition}" }
  Set Test Variable  ${bodyCondition}

Select One Condition
  Set Relative Path  /conditions
  Get Conditions List
  ${conditions}=  Set Variable  ${responseConditions.json()}
  ${conditionsLength}=  Get Length  ${conditions}
  ${randomCondition}=  Evaluate  random.sample(range(0, ${conditionsLength}-1),1)  random
  Log  ${randomCondition}
  ${conditionId}=  Set Variable  ${conditions[${randomCondition[0]}]["_id"]}
  Set Test Variable  ${conditionId}

Create Invalid Body To Create Condition
  ${newDescriptionCondition}=  Set Variable  TestFail
  ${bodyCondition}=  Evaluate  { "description": "${newDescriptionCondition}" }
  Set Test Variable  ${bodyCondition}