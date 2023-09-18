import logging
import os
import random
import sys
from time import sleep

import boto3
import psycopg2

logging.basicConfig(stream=sys.stdout, level=logging.INFO)

##############
## Vars init #
##############
# Object storage
access_key = os.environ['AWS_ACCESS_KEY_ID']
secret_key = os.environ['AWS_SECRET_ACCESS_KEY']
service_point = os.environ['SERVICE_POINT']
s3client = boto3.client('s3', 'us-east-1', endpoint_url=service_point,
                        aws_access_key_id=access_key,
                        aws_secret_access_key=secret_key,
                        use_ssl=True if 'https' in service_point else False)

# Buckets
bucket_source = os.environ['BUCKET_SOURCE']
bucket_destination = os.environ['BUCKET_BASE_NAME']

# Helper database
db_user = os.environ['DATABASE_USER']
db_password = os.environ['DATABASE_PASSWORD']
db_host = os.environ['DATABASE_HOST']
db_db = os.environ['DATABASE_DB']

# Delay between images
seconds_wait = float(os.environ['SECONDS_WAIT'])

########
# Code #
########
def copy_file(bucket_source, key_source, bucket_destination, key_destination):
    """Copies an object from a source bucket to a destination bucket."""

    CopySource={'Bucket': bucket_source, 'Key': key_source}
    s3client.copy(CopySource,bucket_destination,key_destination)

def update_images_uploaded(image_name):
    """Inserts image name and timestamp into the helper database."""

    try:
        connString = f"host={db_host} port=5433 dbname={db_db} user={db_user} password={db_password} load_balance=True"
        cnx = psycopg2.connect(connString)
        cursor = cnx.cursor()
        query = 'INSERT INTO images_uploaded(time,name) SELECT CURRENT_TIMESTAMP,"' + image_name + '";'
        cursor.execute(query)
        cnx.commit()
        cursor.close()
        cnx.close()

    except Exception as e:
        logging.error(f"Unexpected error: {e}")
        raise

# Populate source images lists
pneumonia_images=[]
for image in s3client.list_objects(Bucket=bucket_source,Prefix='PNEUMONIA/')['Contents']:
    pneumonia_images.append(image['Key'])
normal_images=[]
for image in s3client.list_objects(Bucket=bucket_source,Prefix='NORMAL/')['Contents']:
    normal_images.append(image['Key'])

# Main loop
while seconds_wait != 0: #This allows the container to keep running but not send any image if parameter is set to 0
    logging.info("copy image")
    rand_type = random.randint(1,10)
    if rand_type <= 8: # 80% of time, choose a normal image
        image_key = normal_images[random.randint(0,len(normal_images)-1)]
    else:
        image_key = pneumonia_images[random.randint(0,len(pneumonia_images)-1)]
    image_name = image_key.split('/')[-1]
    copy_file(bucket_source,image_key,bucket_destination,image_name)
    update_images_uploaded(image_name)
    sleep(seconds_wait)

# Dirty hack to keep container running even when no images are to be copied
os.system("tail -f /dev/null")
