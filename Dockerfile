FROM python:latest

WORKDIR /flask_app
COPY . /flask_app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "flask_app.py"]
