FROM python:3.8

COPY ./ /

COPY ./app /app

RUN pip install -r requirements.txt

EXPOSE 3000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "3000"]