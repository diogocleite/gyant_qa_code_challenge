FROM python:3

RUN apt-get update
RUN apt-get install -y gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 libfontconfig1 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libxss1 fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils
RUN apt-get install -y chromium

RUN python3 -m pip install robotframework==4.0
RUN python3 -m pip install robotframework-requests==0.8.1
RUN python3 -m pip install robotframework-jsonschemalibrary==1.0
RUN python3 -m pip install robotframework-seleniumlibrary==5.1.0
RUN python3 -m pip install webdrivermanager==0.10.0
RUN python3 -m pip install bson==0.5.9
RUN python3 -m pip install pymongo==3.11.0
RUN python3 -m pip install robotframework-mongodb-library3
RUN python3 -m pip install dnspython
RUN webdrivermanager chrome

WORKDIR /app

CMD sleep 5; robot -d Results -i TEST Tests
