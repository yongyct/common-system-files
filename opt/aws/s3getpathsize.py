import boto3
from datetime import datetime as dt

S3_BUCKET_NAME='mybucketname'

client = boto3.client(
    service_name='s3',
    verify='/path/to/ca.pem',
    endpoint_url='my.s3.url.com',
    aws_access_key_id='myaccesskey',    # bad practice, use other way e.g. aws configure
    aws_secret_access_key='mysecretkey'    # bad practice, use other way e.g. aws configure
)

paginator = client.get_paginator('list_objects')
items = 0
size = 0
paths = ['/prefix/path/1/', '/prefix/path/2/']

def aggregator(chunk):
    items_chunk = 0
    size_chunk = 0
    for item in chunk['Contents']:
        if item['Size'] == 0:	# assuming this is a folder
            print('Checking folder: {}'.format(item['Key']))
        else:
            size_chunk += item['Size']
            items_chunk += 1
    return items_chunk, size_chunk

start = dt.now()
print(start)
for path in paths:
	for chunk in paginator.paginate(Bucket=S3_BUCKET_NAME, Prefix=path):
		items_chunk, size_chunk = aggregator(chunk)
		items += items_chunk
		size += size_chunk
	print('Path: {}\nNo. of items: {}, Size: {} GB'.format(path, items, size/(1024 ** 3)))
end = dt.now()
print('Total time: {}'.format(end - start))
