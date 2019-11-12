from base64 import b64decode
from StringIO import StringIO
import gzip
import boto3
import os
import json

print('Loading function')

fhclient = boto3.client('firehose', region_name=os.environ['FIREHOSE_REGION'])
    

def lambda_handler(eventIn, context):
    result=[]
    event = json.loads(gzip.GzipFile(fileobj=StringIO(eventIn['awslogs']['data'].decode('base64'))).read())

    for cwlog in event['logEvents']:
        cwlog['message'] =  cwlog['message']
        cwlog['log_group'] = event['logGroup']
        cwlog['log_stream'] = event['logStream']
        cwlog['logStream']=event['logStream']
        result.append({'Data':json.dumps(cwlog)})
    try:
        fhclient.put_record_batch(
        DeliveryStreamName=os.environ['FIREHOSE_STREAM_NAME'],
        Records=result
        )
    except:
        print('Error when trying to deliver')
        raise Exception('Something went wrong')
