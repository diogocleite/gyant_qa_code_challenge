*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  String
Library  JSONSchemaLibrary  ${CURDIR}/Schemas
Library  MongoDBLibrary
Library  SeleniumLibrary

*** Variables ***
${BASE_URL}  http://gyant-challenge-app:3000
${SUCCESS_RESPONSE}  200
${DB_CONNECTION}  mongodb+srv://gyant_user:qwerty1234@cluster0.npiuo.mongodb.net/gyantQaChallenge?retryWrites=true&w=majority
${DB_NAME}  gyantQaChallenge

*** Keywords ***
Create New Session
  Create Session  User_Profile  ${BASE_URL}

Create New Session Frontend
  Open Browser  ${BASE_URL}  headlesschrome  options=add_argument("window-size=1920,1080");add_argument("--no-sandbox");add_argument("--disable-setuid-sandbox");add_argument("--remote-debugging-port=9222");add_argument("--disable-dev-shm-using")

End Session Frontend
  Close Browser

Set Relative Path
  [Arguments]  ${relativePath}
  Set Test Variable  ${relativePath}
  Log  Path: ${BASE_URL}/${relativePath}

Set Dynamic Relative Path
  [Arguments]  ${relativePath}  ${variable}  ${value}
  ${relativePath}=  Replace String  ${relativePath}  ${variable}  ${value}
  Set Test Variable  ${relativePath}
  Log  Path: ${BASE_URL}/${relativePath}

Connect To Database Mongo
  Connect To MongoDB  ${DB_CONNECTION}
  @{output}=  Get MongoDB Collections  gyantQaChallenge

Disconnect Database Mongo
  Disconnect From MongoDB