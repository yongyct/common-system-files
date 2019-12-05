$token = 'myverylongtoken'
$headers = @{
  'Authorization' = "Bearer $token"
}
$body = @{
  'key' = 'value'
}
$uri = 'myhost.com/path/to/api'

$params = @{
	Uri = $uri
	Headers = $headers
	Method = 'Get'
	Body = $body
}

Invoke-RestMethod @params
