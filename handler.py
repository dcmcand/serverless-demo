import json


def transfer(event, context):
    for record in event['Records']:
        s3 = record['s3']
        bucket = s3['bucket']['name']
        key = s3["object"]['key']
        print(f"key: {bucket}/{key}")