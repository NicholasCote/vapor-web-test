FROM mambaorg/micromamba:jammy-cuda-12.2.2

USER root

RUN apt-get update --yes && \
    # - apt-get upgrade is run to patch known vulnerabilities in apt-get packages as
    #   the ubuntu base image is rebuilt too seldom sometimes (less than once a month)
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends \
    mesa-common-dev \
    libglu1-mesa-dev \
    libglvnd-dev

RUN mkdir /app

COPY env.yaml /app

ADD flask-app /app/flask-app/

RUN micromamba env create -f /app/env.yaml

WORKDIR /app/flask-app

CMD ["python", "wsgi.py"]