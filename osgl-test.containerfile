FROM docker.io/nvidia/cudagl:11.4.2-base

USER root

RUN apt-get update --yes && \
    # - apt-get upgrade is run to patch known vulnerabilities in apt-get packages as
    #   the ubuntu base image is rebuilt too seldom sometimes (less than once a month)
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends \
    curl \
    mesa-common-dev \
    libglu1-mesa-dev \
    libglvnd-dev \
    wget

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

RUN micromamba install -n base conda-forge::libcxx \
    ncar-vapor::osgl

#CMD ["/bin/bash","-c","exec /bin/bash -c 'trap : TERM INT; sleep infinity & wait'" ]
ENTRYPOINT [ "/root/micromamba/bin/osgl_test_version" ]