import boto3
import datetime
import logging
from botocore.exceptions import ClientError

S3_CA_PATH = '/path/to/ca.pem'
S3_ENDPOINT_URL = 'my.s3.url.com'
S3_BUCKET_NAME = 'mybucketname'
PREFIX_NAME = 'myprefixname'
LOG_FILENAME = '/path/to/logfile'
LOG_FILEMODE = 'w'
LOG_LEVEL = 'INFO'
LOG_FORMAT = '%(asctime)s  %(levelname)s %(process)d --- [%(module)s] %(pathname)s\t: %(message)s'    # log4j format
LOG_DATE_FORMAT = '%Y-%m-%d %H:%M:%S.%03d'

# Set up logging
logging.basicConfig(
    filename=LOG_FILENAME,
    filemode=LOG_FILEMODE,
    level=getattr(logging, LOG_LEVEL, logging.INFO),
    format=LOG_FORMAT,
    datefmt=LOG_DATE_FORMAT
)

client = boto3.client(
    service_name='s3',
    verify=S3_CA_PATH,
    endpoint_url=S3_ENDPOINT_URL,
    aws_access_key_id='myaccesskey',    # bad practice, use other way e.g. aws configure
    aws_secret_access_key='mysecretkey'    # bad practice, use other way e.g. aws configure
)

cleanup_paths = [{'bucket_name':S3_BUCKET_NAME, 'prefix_name':PREFIX_NAME}]

# Improve this to read actual mtime
def is_old(date):
    if date.isdigit():
        date = int(date)
    else:
        return False
    oldDate = datetime.datetime.today() - datetime.timedelta(days=90)
    oldDate = int(oldDate.strftime('%Y%m%d'))
    return oldDate > date > 20190000


def delete_file(bucket, prefix):
    try:
        paginator = S3.get_paginator('list_objects_v2')
        pages = paginator.paginate(Bucket=bucket, Prefix=prefix)
        delete_us = dict(Objects=[])
        for item in pages.search('Contents'):
            delete_us['Objects'].append(dict(Key=item['Key']))
            # flush once aws limit reached
            if len(delete_us['Objects']) >= 1000:
                S3.delete_objects(Bucket=bucket, Delete=delete_us)
                delete_us = dict(Objects=[])
        # flush rest
        if len(delete_us['Objects']):
            S3.delete_objects(Bucket=bucket, Delete=delete_us)
        logging.info(f'folder {prefix} deleted')
    except ClientError as e:
        logging.error(e)


if __name__ == '__main__':

    for cleanup_path in cleanup_paths:
        bucket, prefix = cleanup_path[0], cleanup_path[1]

        objs_1 = S3.list_objects(Bucket=bucket, Prefix=prefix, Delimiter='/')
        for prefix_1 in objs_1.get('CommonPrefixes'):
            objs_2 = S3.list_objects(Bucket=bucket, Prefix=prefix_1.get('Prefix'), Delimiter='/')
            if objs_2.get('CommonPrefixes') is not None:
                for prefix_2 in objs_2.get('CommonPrefixes'):
                    folder_date = prefix_2.get('Prefix').split('/')[-2].replace('-', '')
                    if is_old(folder_date):
                        delete_file(bucket=bucket, prefix=prefix_2.get('Prefix'))
