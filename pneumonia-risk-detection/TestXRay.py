import pandas as pd
import numpy as np
import boto3
import botocore
import tensorflow as tf
import io
import os
import sys
import logging
import json
import mysql.connector

logging.basicConfig(stream=sys.stdout, level=logging.INFO)

db_user = os.environ['database_user']
db_password = os.environ['database_password']
db_host = os.environ['database_host']
db_db = os.environ['database_db']
service_point = os.environ['storage_service_point']
ssl_verify = os.environ['storage_ssl_verify']
use_signature_versioning = os.environ['use_signature_versioning']


class TestXRay(object):
  def __init__(self):
    self.model_name = "TestXRay"
    self.predictor_name = "xray-demo"
    self.predictor_version = "v1.0"        
    logging.info(f"Service endpoint: {service_point}")


  def update_images_processed(self, image_name, model_version, pneumonia_risk):
    logging.info("Processing DB update...")
    success = False
    try:
      cnx = mysql.connector.connect(user=db_user, password=db_password,
                                    host=db_host,
                                    database=db_db)
      cursor = cnx.cursor()
      subject_name = image_name[image_name.index('_')+1:image_name.index('_',image_name.index('_')+1)] # get the string between the first two occurences of '_'
      query = 'INSERT INTO xraylab_xraydata(test_date, name, risk, image_name, model_name) SELECT CURRENT_TIMESTAMP(), "' + subject_name + '","' + str(pneumonia_risk) + '","' + image_name + '","' + model_version + '";'
      logging.info(f"Trying query:{query}")
      cursor.execute(query)
      cnx.commit()
      cursor.close()
      cnx.close()
      success = True

    except Exception as e:
      logging.error(f"Unexpected error: {e}")
      #raise
    return success
        
        
  def predict(self, X, features_names):
    logging.info(f"Got request {X} with features {features_names}")        
    df = pd.DataFrame(data=X, columns=[features_names])
        
    aws_access_key_id = str(df.iloc[0]['aws_key_id'])
    aws_secret_access_key = str(df.iloc[0]['aws_key'])
    region_name = str(df.iloc[0]['region_name'])
    bucket_name = str(df.iloc[0]['bucket_name'])
    path_name = str(df.iloc[0]['file_path_name'])

    bucket_name_processed = bucket_name+'-processed'
    
    s3 = None
    
    if ssl_verify == True:
      if use_signature_versioning == True:
        s3 = boto3.client('s3',
                    endpoint_url = service_point,
                    aws_access_key_id = aws_access_key_id,
                    aws_secret_access_key = aws_secret_access_key,
                    region_name = region_name,
                    config=botocore.client.Config(signature_version = 's3'))
      else:
        s3 = boto3.client('s3',
                    endpoint_url = service_point,
                    aws_access_key_id = aws_access_key_id,
                    aws_secret_access_key = aws_secret_access_key,
                    region_name = region_name)
    else:
      if use_signature_versioning == True:
        s3 = boto3.client('s3',
                    endpoint_url = service_point,
                    aws_access_key_id = aws_access_key_id,
                    aws_secret_access_key = aws_secret_access_key,
                    region_name = region_name,
                    verify = False,
                    config=botocore.client.Config(signature_version = 's3'))
      else:
        s3 = boto3.client('s3',
                    endpoint_url = service_point,
                    aws_access_key_id = aws_access_key_id,
                    aws_secret_access_key = aws_secret_access_key,
                    region_name = region_name)

    file_name = path_name.split('/')[-1]    
    pred = np.array([-1])
    self.pneumonia = 0
    
    try:
      s3.download_file(Bucket=bucket_name, Key=path_name, Filename='/tmp/'+file_name)
      logging.info("File downloaded: %s.", file_name)
                                    
      img = tf.keras.preprocessing.image.load_img('/tmp/'+file_name, target_size=(150, 150))
      img_tensor = tf.keras.preprocessing.image.img_to_array(img) # (height, width, channels)
      img_tensor = np.expand_dims(img_tensor, axis=0)         	# (1, height, width, channels), add a dimension because the model expects this shape: (batch_size, height, width, channels)
      img_tensor /= 255.                                      	# imshow expects values in the range [0, 1]
      logging.info("Image to tensor completed.")
    
      model = tf.keras.models.load_model('./pneumonia_model.h5')
    
      pred = model.predict(img_tensor)
      pneumonia_risk = pred[0][0]
      logging.info(f"Pneumonia risk prediction of: {pneumonia_risk}.")    
              
      if pneumonia_risk > 0.5:
        self.pneumonia = 1

      s3.upload_file('/tmp/'+file_name, bucket_name_processed, file_name)
      logging.info("Uploaded processed file to s3 processed bucket.")
    
      success = self.update_images_processed(file_name, self.model_name, pneumonia_risk.item())
      if success:
        logging.info("Data processing results stored in DB.")
      
      os.remove('/tmp/'+file_name)
      logging.info("Deleted local file. Prediction event completed!")
    except Exception as e:
      logging.info(f"Got an exception while processing: {e}")
    
    return pred


  def metrics(self):
    return [
      {"type": "COUNTER", "key": "requests", "value": 1}, # a counter which will increase by one on each request
      {"type": "COUNTER", "key": "pneumonia", "value": self.pneumonia},   # pneumonia counter will increase only if prediction is pneumonia
      {"type": "TIMER", "key": "timer", "value": 50.5},  # a timer which will add sum and count metrics - assumed millisecs
    ]


  def init_metadata(self):
    meta = {
      "name": "xray-demo-tf",
      "versions": ["v1"],
      "platform": "seldon",
      "inputs": [
        {
            "messagetype": "ndarray",
            "schema": {"names": ["aws_key_id", "aws_key", "region_name", "bucket_name", "file_path_name"]},
        }
      ],
      "outputs": [{"messagetype": "ndarray"}],
      "custom": {"author": "eartvit", "extra": "xray-demo"},
    }
    return meta
  
