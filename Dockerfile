FROM apache/airflow:2.10.5
COPY requirements.txt /

ENV AIRFLOW__CORE__LOAD_EXAMPLES=False
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" -r /requirements.txt

WORKDIR $AIRFLOW_HOME
USER $AIRFLOW_UID