import boto3

client = boto3.client(
    service_name='s3',
    verify='/path/to/ca.pem',
    endpoint_url='my.s3.url.com',
    aws_access_key_id='myaccesskey',    # bad practice, use other way e.g. aws configure
    aws_secret_access_key='mysecretkey'    # bad practice, use other way e.g. aws configure
)

client.download_file(
    'mybucketname',
    'path/to/s3/file',
    '/path/to/local/file'
)

client.upload_file(
    '/path/to/local/file',
    'mybucketname',
    'path/to/s3/file'
)
