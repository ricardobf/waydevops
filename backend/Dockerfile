FROM python:3.8.3-slim-buster

WORKDIR /app/ 

COPY requirements.txt .

RUN pip install --upgrade pip &&  pip install -r requirements.txt

COPY . .