import argparse, os, sys
from time import time
import pandas as pd
import pyarrow.parquet as pq
from sqlalchemy import create_engine

def main(params):
    
    user = params.user 
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    tb = params.tb
    url = params.url
    
    # Get file name from url https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet
    file_name = url.split('/')[-1]
    
    # Download file from url
    os.system(f'curl {url.strip()} -o {file_name}')
    
    # Create connection to the database
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    
    # Create table schema
    file = pq.ParquetFile(file_name)
    df = next(file.iter_batches(batch_size=10)).to_pandas()
    df.head(0).to_sql(name=tb, con=engine, if_exists='replace')
    
    df_iter = file.iter_batches(batch_size=100000)
    
    
    count = 0
    for batch in df_iter:
        count += 1
        batch_df = batch.to_pandas()
        
        print(f'Inserting batch {count} into {tb} table')
        t_start = time()
        batch_df.to_sql(name=tb, con=engine, if_exists='append')
        t_end = time()
        
        print(f'Batch {count} inserted in {t_end - t_start} seconds')
    
    print(f'All data inserted into {tb} table')

    '''Print the schema of the table

    print(
        pd.io.sql.get_schema(df, name='yellow_taxi_2024', con=engine)
    ) 
    
    '''
    

if __name__ == '__main__':
    
    parser = argparse.ArgumentParser(description='Loading data from .paraquet file link to a Postgres datebase.')
    
    parser.add_argument('--user', help='Username for Postgres.')
    parser.add_argument('--password', help='Password to the username for Postgres.')
    parser.add_argument('--host', help='Hostname for Postgres.')
    parser.add_argument('--port', help='Port for Postgres connection.')
    parser.add_argument('--db', help='Databse name for Postgres')
    parser.add_argument('--tb', help='Destination table name for Postgres.')
    parser.add_argument('--url', help='URL for .paraquet file.')
    
    args = parser.parse_args()
    main(args)