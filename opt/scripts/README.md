# Other Helpful Tools

## SSH with private key file & non-22 port
* `ssh -i /path/to/key.pem -p myport myuser@myhost`

## SCP with different port, recursive
* `scp -r -P myport myuser@myhost:/remote/path/to/file /local/path/to/file`

## Execute command as daemon 
* `nohup mycommand > my.log &`
* `nohup mycommand > my.log 2>&1 & echo $! > my.pid &`

## Find out file system disk space status
* `df -hT`

## Get sorted file sizes within a folder
* `du -sh ./* | sort -h`

## Kerberos Keytab Creation
* 1) Execute `ktutil`
* 2) Under ktutil prompt, execute `addent -password -p myuser@MY.REALM.COM -k 1 -e arcfour-hmac`
* 3) Key in password, and press Enter
* 4) Under ktutil prompt, execute `wkt /path/to/myuser.keytab` and press enter, and exit prompt
* 5) To check keytab, execute `klist -k /path/to/myuser.keytab`

## Redis cluster mode shell
* `redis-cli -p myport -h myhost -a myauth -c`

## awscli with custom domain, ssl cert
* `aws --endpoint-url https://my.s3.url.com --ca-bundle /path/to/ca.pem s3 ls`

## Import new .crt into ca
* `keytool -import -keystore /path/to/ca -storepass capassword -file /path/to/newcert.crt -alias newcertalias -noprompt`

## Converting between certificate types (e.g. p12, pem, p8)
When converting p12 to p8, need to convert to pem as an intermediate step first (i.e. p12 -> pem -> p8). Source - https://knowledge.digicert.com/solution/SO26449.html
* 1) `openssl pkcs12 -in certificatename.pfx -nocerts -nodes -out certificatename.pem`
* 2) `openssl pkcs8 -in certificatename.pem -topk8 -nocrypt -out certificatename.pk8`

## Passwordless ssh
* 1) Generate key-pair by executing `ssh-keygen -t [rsa/dsa/ecdsa] -b [2048/4096]`
* 2) SSH to remote host normally `ssh myuser@remotehost`, and key in password to login
* 3) Create `.ssh` directory if not already there, and create/append to `authorized_keys` file in the folder with the content from the local host public key e.g. via `cat .ssh/id.pub`
* 4) Execute `chmod 700 .ssh; chmod 640 .ssh/authorized_keys` in the remote host
* 5) `ssh myuser@remotehost` command without password should work 

## Get Public IP
* `curl https://api.ipify.org/`
