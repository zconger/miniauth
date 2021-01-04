# set base image (host OS)
FROM python:3.9-alpine

# copy the dependencies file to the working directory
COPY requirements.txt .

# install dependencies
RUN pip install -r requirements.txt

# make a user, app, and become it
RUN adduser --disabled-password app
USER app

# set the working directory in the container
WORKDIR /miniapi

# copy the content of the local src directory to the working directory
COPY miniapi/ .

# command to run on container start
CMD [ "python", "./app.py" ]
