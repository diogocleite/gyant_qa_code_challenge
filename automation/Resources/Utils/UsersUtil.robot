*** Variables ***
${NAME}  Doctor Who
${EMAIL}  @doctor.com
${PASSWORD}  qwerty

*** Keywords ***
Register User
  [ARGUMENTS]  ${expectedStatus}=${SUCCESS_RESPONSE}
  Log  Register User Body: ${bodyRegister}
  ${headers}=  Create Dictionary  Content-Type=application/json
  ${responseRegister}=  Post On Session  User_Profile  ${relativePath}  json=${bodyRegister}  headers=${headers}  expected_status=${expectedStatus}
  Set Test Variable  ${responseRegister}
  Log  Register User Response: ${responseRegister.json()}

Create Body To Register User
  ${random}=  Generate Random String  4  [LETTERS]
  ${inputEmail}=  Catenate  SEPARATOR=  who  ${random}  ${EMAIL}
  Set Test Variable  ${inputEmail}
  ${inputName}=  Set Variable  ${NAME}
  Set Test Variable  ${inputName}
  ${bodyRegister}=  Evaluate  { "name": "${inputName}", "email": "${inputEmail}", "password": "${PASSWORD}" }
  Set Test Variable  ${bodyRegister}

Create Body To Login
  ${bodyLogin}=  Evaluate  { "email": "${inputEmail}", "password": "${PASSWORD}" }
  Set Test Variable  ${bodyLogin}

Create Invalid Body To Login
  ${bodyLogin}=  Evaluate  { "email": "notexist", "password": "notexist" }
  Set Test Variable  ${bodyLogin}

Login User
  [ARGUMENTS]  ${expectedStatus}=${SUCCESS_RESPONSE}
  Log  Login User Body: ${bodyLogin}
  ${headers}=  Create Dictionary  Content-Type=application/json
  ${responseLogin}=  Post On Session  User_Profile  ${relativePath}  json=${bodyLogin}  headers=${headers}  expected_status=${expectedStatus}
  Set Test Variable  ${responseLogin}
  Log  Login User Response: ${responseLogin.json()}

Create New User To Login
  Set Relative Path  /users/register
  Create Body To Register User
  Register User

Login New User
  Set Relative Path  /users/login
  Create Body To Login
  Login User
  ${responseLoginJson}=  Set Variable  ${responseLogin.json()}
  Set Test Variable  ${responseLoginJson}
