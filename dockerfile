FROM python:3.8-slim

EXPOSE 5000

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY . /app

CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]
