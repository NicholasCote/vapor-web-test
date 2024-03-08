FROM docker.io/mambaorg/micromamba:latest

COPY env.yaml /home/mambauser

ADD flask-app /home/mambauser/flask-app

WORKDIR /home/mambauser

RUN micromamba env create -f env.yaml

CMD ["python3", "flask-app/wsgi.py"]