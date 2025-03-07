# Create network to connect containers
docker network create pg-network

# Create container to run postgres16
docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5431:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:16

# Create container to run pgadmin14
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  --network=pg-network \
  --name pgadmin-2 \
  dpage/pgadmin4

# Running pgcli to access database
pgcli -h localhost -u root -p 5431  -d ny_taxi

# Running python file: ingest_data.py
python3 ingest_data.py \
  --host localhost \
  --user root \
  --password root \
  --port 5431 \
  --db ny_taxi \
  --tb yellow_taxi_2024 \
  --url https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet

  # Building docker image
  docker build -t taxi_ingest:v001 .

  # Running docker container using image (Change host to pg-databse)
  docker run -it --network=pg-network taxi_ingest:v001 \
    --host pg-database \
    --user root \
    --password root \
    --port 5432 \
    --db ny_taxi \
    --tb yellow_taxi_2024 \
    --url https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet

  # Running docker compose (To start multiple container at once)
  docker-compose up