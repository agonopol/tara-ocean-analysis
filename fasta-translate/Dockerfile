FROM python

RUN mkdir -p /opt/app
RUN pip install biopython xphyle tqdm

COPY translate.py /opt/app

WORKDIR /opt/app
