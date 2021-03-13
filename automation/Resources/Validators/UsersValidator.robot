*** Keywords ***
Validate Register Response
  ${responseBody}=  Set Variable  ${responseRegister.json()}
  Validate Json  register.schema.json  ${responseBody}
  Log  ResponseBody: ${responseBody}
  Should Be Equal  ${responseBody["name"]}  ${inputName}  Wrong returned name
  Should Be Equal  ${responseBody["email"]}  ${inputEmail}  Wrong returned email
  Should Not Be Empty  ${responseBody["_id"]}  Empty "_id"
  Should Not Be Empty  ${responseBody["password"]}  Empty "password"
  Should Be True  ${responseBody["__v"]}>=0  Invalid "__v"

Validate Register On DB
  ${responseBody}=  Set Variable  ${responseRegister.json()}
  ${mongodbUser}=  Retrieve Some MongoDB Records  ${DB_NAME}  users  { "email":"${inputEmail}"}
  Log  MongoDb User: ${mongodbUser}
  Should Contain X Times  ${mongodbUser}  ${responseBody["name"]}  1
  Should Contain X Times  ${mongodbUser}  ${responseBody["email"]}  1
  Should Contain X Times  ${mongodbUser}  ${responseBody["_id"]}  1
  Should Contain X Times  ${mongodbUser}  ${responseBody["password"]}  1

Validate User Login
  ${responseBody}=  Set Variable  ${responseLogin.json()}
  Validate Json  login.schema.json  ${responseBody}
  Log  ResponseBody: ${responseBody}
  Should Be Equal  ${responseBody["name"]}  ${inputName}  Wrong returned name
  Should Be Equal  ${responseBody["email"]}  ${inputEmail}  Wrong returned email
  Should Not Be Empty  ${responseBody["id"]}  Empty "id"

Validate Login On DB
  ${responseBody}=  Set Variable  ${responseLogin.json()}
  ${mongodbUser}=  Retrieve Some MongoDB Records  ${DB_NAME}  users  { "email":"${inputEmail}"}
  Log  MongoDb User: ${mongodbUser}
  Should Contain X Times  ${mongodbUser}  ${responseBody["name"]}  1
  Should Contain X Times  ${mongodbUser}  ${responseBody["email"]}  1
  Should Contain X Times  ${mongodbUser}  ${responseBody["id"]}  1

Validate Register User Fail
  ${responseBody}=  Set Variable  ${responseRegister.json()}
  Should Be Equal As Integers  ${responseBody["statusCode"]}  400
  Should Be Equal As Integers  ${responseBody["payload"]["statusCode"]}  400
  Should Be Equal  ${responseBody["payload"]["error"]}  Bad Request
  Should Not Be Empty  ${responseBody["payload"]["message"]}

Validate Invalid User Login
  ${responseBody}=  Set Variable  ${responseLogin.json()}
  Should Be Equal As Integers  ${responseBody["statusCode"]}  400
  Should Be Equal As Integers  ${responseBody["payload"]["statusCode"]}  400
  Should Be Equal  ${responseBody["payload"]["error"]}  Bad Request
  Should Not Be Empty  ${responseBody["payload"]["message"]}