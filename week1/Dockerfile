# Set the base image to the python image
FROM python:3.12

# Runs the command to install pandas on the image
RUN pip install pandas psycopg2-binary sqlalchemy pyarrow

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY ingest_data.py /app/ingest_data.py

# Run pipeline.py when the container launches
ENTRYPOINT [ "python", "ingest_data.py" ]