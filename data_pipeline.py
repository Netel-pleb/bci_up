import json
import os
import boto3
import psycopg2
from psycopg2.extras import execute_values

# AWS S3 configuration
s3 = boto3.client('s3')
bucket_name = os.environ.get('S3_EEG_HALT_BUCKET')

# PostgreSQL configuration
db_params = {
    'host': os.environ.get('DB_HOST'),
    'database': os.environ.get('BCI_DB_NAME'),
    'user': os.environ.get('DB_USER'),
    'password': os.environ.get('DB_PASSWORD')
}

def upload_to_s3(file_path, s3_key):
    try:
        s3.upload_file(file_path, bucket_name, s3_key)
        print(f"Uploaded {file_path} to S3")
    except Exception as e:
        print(f"Failed to upload {file_path} to S3: {e}")

def create_table(cursor, table_name, columns):
    columns_sql = ', '.join([f"{col} {dtype}" for col, dtype in columns.items()])
    cursor.execute(f"CREATE TABLE IF NOT EXISTS {table_name} ({columns_sql})")
    print(f"Created table: {table_name}")

def insert_data(cursor, table_name, data):
    columns = data[0].keys()
    values = [[row[col] for col in columns] for row in data]
    insert_sql = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES %s"
    execute_values(cursor, insert_sql, values)
    print(f"Inserted {len(data)} rows into {table_name}")



def process_json_file(file_path):
    with open(file_path, 'r') as f:
        data = json.load(f)
    
    # Upload to S3
    s3_key = os.path.basename(file_path)
    upload_to_s3(file_path, s3_key)
    
    # Create table and insert data
    table_name = os.path.splitext(s3_key)[0]
    # Define the table structure based on the known schema
    columns = {
        'recording_key': 'SERIAL PRIMARY KEY',
        'recording_name': 'TEXT[] NOT NULL',
        'subject': 'CHAR(1) NOT NULL',
        'task_type': 'TEXT[] NOT NULL',
        'eeg_data': 'FLOAT[] NOT NULL',
        'sampling_rate': 'FLOAT NOT NULL',
        'channel_names': 'TEXT[] NOT NULL',
        'event_starts': 'INTEGER NOT NULL',
        'event_durations': 'INTEGER NOT NULL',
        'event_types': 'INTEGER NOT NULL'
    }
    # Create table and insert data
    with psycopg2.connect(**db_params) as conn:
        with conn.cursor() as cur:
            create_table(cur, table_name, columns)
            insert_data(cur, table_name, data)
        conn.commit()

def main():
    print("Starting data pipeline")
    print("DB_HOST:", os.environ.get('DB_HOST'))
    print("BCI_DB_NAME:", os.environ.get('BCI_DB_NAME'))
    print("DB_USER:", os.environ.get('DB_USER'))
    print("DB_PASSWORD:", os.environ.get('DB_PASSWORD'))
    json_folder = os.environ.get('EEG_HALT_JSON_FOLDER')
    for filename in os.listdir(json_folder):
        if filename.endswith('.json'):
            file_path = os.path.join(json_folder, filename)
            process_json_file(file_path)

if __name__ == '__main__':
    main()