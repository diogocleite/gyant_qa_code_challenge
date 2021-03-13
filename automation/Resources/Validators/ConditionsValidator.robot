*** Keywords ***
Validate Conditions
  ${responseBody}=  Set Variable  ${responseConditions.json()}
  Validate Json  conditions.schema.json  ${responseBody}
  Log  ResponseBody: ${responseBody}
  FOR  ${condition}  IN  @{responseBody}
    Log  ${condition}
    Should Not Be Empty  ${condition["_id"]}
    Should Not Be Empty  ${condition["code"]}
    Should Not Be Empty  ${condition["description"]}
    Validate Condition On DB  ${condition}
  END

Validate Condition On DB
  [ARGUMENTS]  ${condition}
  ${mongodbCondition}=  Retrieve Some MongoDB Records  ${DB_NAME}  conditions  { "code":"${condition["code"]}"}
  Log  MongoDb Condition: ${mongodbCondition}
  Should Contain X Times  ${mongodbCondition}  ${condition["code"]}  1
  Should Contain X Times  ${mongodbCondition}  ${condition["description"]}  1
  Should Contain X Times  ${mongodbCondition}  ${condition["_id"]}  1

Validate Conditions Import
  ${responseBody}=  Set Variable  ${responseConditionsImport.json()}
  Log  ResponseBody: ${responseBody}
  Should Be Equal As Numbers  ${responseBody["ok"]}  1
  ${mongodbConditionsImport}=  Retrieve All MongoDB Records  ${DB_NAME}  conditions
  Log  MongoDb Conditions Import: ${mongodbConditionsImport}
  ${length}=  Get Length  ${mongodbConditionsImport}
  Should Be True  ${length}>0

Validate New Condition
  ${responseBody}=  Set Variable  ${responseCondition.json()}
  Log  ResponseBody: ${responseBody}
  Should Not Be Empty  ${responseBody["_id"]}
  Should Not Be Empty  ${responseBody["code"]}
  Should Not Be Empty  ${responseBody["description"]}
  Should Be True  ${responseBody["__v"]}>=0  Invalid "__v"
  Validate Condition On DB  ${responseBody}

Validate Invalid New Condition
  ${responseBody}=  Set Variable  ${responseCondition.json()}
  Should Be Equal As Integers  ${responseBody["statusCode"]}  422
  Should Be Equal As Integers  ${responseBody["payload"]["statusCode"]}  422
  Should Be Equal  ${responseBody["payload"]["error"]}  Unprocessable Entity
  Should Not Be Empty  ${responseBody["payload"]["message"]}