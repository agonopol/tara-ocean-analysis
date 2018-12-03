FROM python

RUN mkdir -p /opt/app
RUN pip install biopython tqdm xphyle

COPY translate.py /opt/app

WORKDIR /opt/app
