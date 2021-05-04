import json
import os
import boto3

def transfer(event, context):
    try:
        outbound_bucket = os.environ["OUTBOUND_BUCKET"]
        s3 = boto3.resource('s3')
    except Exception as e:
        print(e)
    for record in event['Records']:
        inbound_bucket = record['s3']['bucket']['name']
        key = record['s3']["object"]['key']
        print(f"Copying {inbound_bucket}/{key} to {outbound_bucket}/{key}")
        source = {
            'Bucket': inbound_bucket,
            'Key': key
        }
        try:
            destination = s3.Bucket(outbound_bucket)
            obj = destination.Object(key)
            obj.copy(source)
        except Exception as e:
            print(f"An error occured copying {key} to {outbound_bucket}")
            print(e)
        try:
            print(f"Deleting {inbound_bucket}/{key}")
            object_to_delete = s3.Object(inbound_bucket, key)
            object_to_delete.delete()
        except Exception as e:
            print(f"Could not delete {inbound_bucket}/{key}")
            print(e)


