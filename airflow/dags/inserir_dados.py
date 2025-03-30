import os
from datetime import datetime
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.providers.google.cloud.transfers.local_to_gcs import LocalFilesystemToGCSOperator

AIRFLOW_HOME = "/opt/airflow"
GCP_BUCKET_NAME = os.environ.get('GCP_BUCKET_NAME')

YELLOW_TIP_URL = 'https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2022-01.parquet'
LOOKUP_TABLE = 'https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv'

dag =  DAG(dag_id="inserir_data_gcp",
        description="Baixa dados de site",
        catchup=False,
        start_date=datetime(2024,10,26))

download_yellow_tip = BashOperator(
        task_id='download_yellow_tip',
        bash_command=f'curl --location --output {AIRFLOW_HOME}/yellow_tip.parquet {YELLOW_TIP_URL}',
        dag=dag
    )

download_lookup_table = BashOperator(
        task_id='download_lookup_table',
        bash_command=f'curl --location --output {AIRFLOW_HOME}/lookup_table.csv {LOOKUP_TABLE}',
        dag=dag
    )

send_local_to_gcs = LocalFilesystemToGCSOperator(
    task_id='send_local_to_gcs',
    src=f'{AIRFLOW_HOME}/yellow_tip.parquet',
    dst=f'landding/yellow_tip/{datetime.now()}.parquet',
    bucket=GCP_BUCKET_NAME,
    dag=dag
)



[download_lookup_table, download_yellow_tip] >> send_local_to_gcs