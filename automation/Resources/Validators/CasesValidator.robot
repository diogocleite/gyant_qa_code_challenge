*** Keywords ***
Validate List of Unreviewed Cases
  ${responseBody}=  Set Variable  ${responseUnreviewed.json()}
  Validate Json  unreviewed.schema.json  ${responseBody}
  Log  ResponseBody: ${responseBody}
  ${responseLength}=  Get Length  ${responseBody}
  ${dbLength}=  Get MongoDB Collection Count  ${DB_NAME}  cases
  Should Be Equal  ${responseLength}  ${dbLength}
  FOR  ${case}  IN  @{responseBody}
    Log  ${case}
    Should Not Be Empty  ${case["_id"]}
    Should Not Be Empty  ${case["id"]}
    Should Not Be Empty  ${case["description"]}
    Should Be Empty  ${case["reviews"]}
  END

Validate No Cases Existence
  ${responseBody}=  Set Variable  ${responseDelete.json()}
  Should Be Equal  ${responseBody}  ${TRUE}
  ${mongodbCases}=  Retrieve All MongoDB Records  ${DB_NAME}  cases
  Log  MongoDb Cases: ${mongodbCases}
  Should Be Empty  ${mongodbCases}

Validate Import Cases
  ${responseBody}=  Set Variable  ${responseImportCases.json()}
  Should Be Equal As Numbers  ${responseBody["ok"]}  1
  ${mongodbCases}=  Retrieve All MongoDB Records  ${DB_NAME}  cases
  Log  MongoDb Cases: ${mongodbCases}
  Should Not Be Empty  ${mongodbCases}

Validate Review Response
  ${responseBody}=  Set Variable  ${responseReview.json()}
  Validate Json  review.schema.json  ${responseBody}
  Should Not Be Empty  ${responseBody["_id"]}
  Should Be Equal  ${responseBody["id"]}  ${caseId}
  Should Not Be Empty  ${responseBody["description"]}
  Should Be True  ${responseBody["__v"]}>0
  ${reviewsLength}=  Get Length  ${responseBody["reviews"]}
  Should Be Equal As Numbers  ${reviewsLength}  1
  ${review}=  Set Variable  ${responseBody["reviews"][0]}
  Should Not Be Empty  ${review["_id"]}
  Should Be Equal  ${review["userId"]}  ${responseLoginJson["id"]}
  Should Be Equal  ${review["conditionId"]}  ${conditionId}
  Should Not Be Empty  ${review["date"]}
  Validate Review Response on DB  ${responseBody}

Validate Review Response on DB
  [ARGUMENTS]  ${responseBody}
  ${mongodbCases}=  Retrieve Some MongoDB Records  ${DB_NAME}  cases  { "id": "${caseId}" }
  Log  MongoDb Cases: ${mongodbCases}
  Should Not Be Empty  ${mongodbCases}
  Should Contain X Times  ${mongodbCases}  ${responseBody["_id"]}  1
  Should Contain X Times  ${mongodbCases}  ${responseBody["id"]}  1
  ${review}=  Set Variable  ${responseBody["reviews"][0]}
  Should Contain X Times  ${mongodbCases}  ${review["_id"]}  1
  Should Contain X Times  ${mongodbCases}  ${review["userId"]}  1
  Should Contain X Times  ${mongodbCases}  ${review["conditionId"]}  1

Validate List of Unreviewed Cases With Invalid Id
  ${responseBody}=  Set Variable  ${responseUnreviewed.json()}
  Should Be Equal As Integers  ${responseBody["statusCode"]}  400
  Should Be Equal As Integers  ${responseBody["payload"]["statusCode"]}  400
  Should Be Equal  ${responseBody["payload"]["error"]}  Bad Request
  Should Not Be Empty  ${responseBody["payload"]["message"]}

Validate Fail Delete Cases
  ${responseBody}=  Set Variable  ${responseDelete.json()}
  Should Be Equal As Integers  ${responseBody["statusCode"]}  400
  Should Be Equal As Integers  ${responseBody["payload"]["statusCode"]}  400
  Should Be Equal  ${responseBody["payload"]["error"]}  Bad Request
  Should Be Equal  ${responseBody["payload"]["message"]}  ns not found

Validate Invalid Review Response
  ${responseBody}=  Set Variable  ${responseReview.json()}
  Should Be Equal As Integers  ${responseBody["statusCode"]}  400
  Should Be Equal As Integers  ${responseBody["payload"]["statusCode"]}  400
  Should Be Equal  ${responseBody["payload"]["error"]}  Bad Request
  Should Not Be Empty  ${responseBody["payload"]["message"]}