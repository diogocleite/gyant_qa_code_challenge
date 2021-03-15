# Automation Tests
To cover this Application with tests I created Functional Tests and Integration Tests.
To do achieve this I used:
- Robot Framework(versions and all dependencies more detail bellow)
    - RequestLibrary(to do the REST calls)
    - SeleniumLibrary(to do the Frontend tests)
- Docker to run the app and to run the tests against the app.

## How To Run
I used Docker to run everything so make sure you have it installed.
```
git clone https://github.com/diogocleite/gyant_qa_code_challenge.git
cd gyant_qa_code_challenge
docker-compose up
```
After finish the results are in command line and inside the folder automation/Results(index.html and log.html).
Inside this folder it's already there an example.

## Tools
- pip install robotframework==4.0
- pip install robotframework-requests==0.8.1
- pip install robotframework-jsonschemalibrary==1.0
- pip install robotframework-seleniumlibrary==5.1.0
- pip install webdrivermanager==0.10.0
- pip install robotframework-mongodb-library3
- pip install pymongo
- pip install dnspython
- webdrivermanager chrome

## How to Run only tests
- robot -d Results -i TEST Tests/