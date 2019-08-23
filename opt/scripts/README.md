# Other Helpful Tools

## SSH with private key file & non-22 port
* <strong>ssh -i /path/to/key.pem -p myport myuser@myhost</strong>

## SCP with different port, recursive
* <strong>scp -r -P myport myuser@myhost:/remote/path/to/file /local/path/to/file</strong>

## Execute command as daemon 
* <strong>nohup mycommand > my.log &</strong>
* <strong>nohup mycommand > my.log 2>&1 & echo $! > my.pid &</strong>

## Find out file system disk space status
* <strong>df -hT</strong>

## Get sorted file sizes within a folder
* <strong>du -sh ./* | sort -h</strong>

## Kerberos Keytab Creation
* 1) Execute <strong>ktutil</strong>
* 2) Under ktutil prompt, execute <strong>addent -password -p myuser@MY.REALM.COM -k 1 -e arcfour-hmac</strong>
* 3) Key in password, and press Enter
* 4) Under ktutil prompt, execute <strong>wkt /path/to/myuser.keytab</strong> and press enter, and exit prompt
* 5) To check keytab, execute <strong>klist -k /path/to/myuser.keytab</strong>

## Redis cluster mode shell
* <strong>redis-cli -p myport -h myhost -a myauth -c</strong>

## awscli with custom domain, ssl cert
* <strong>aws --endpoint-url https://my.s3.url.com --ca-bundle /path/to/ca.pem s3 ls</strong>

## Import new .crt into ca
* <strong>keytool -import -keystore /path/to/ca -storepass capassword -file /path/to/newcert.crt -alias newcertalias -noprompt</strong>

## Passwordless ssh
* 1) Generate key-pair by executing <strong>ssh-keygen -t [rsa/dsa/ecdsa] -b [2048/4096]</strong>
* 2) SSH to remote host normally <strong>ssh myuser@remotehost</strong>, and key in password to login
* 3) Create <strong>.ssh</strong> directory if not already there, and create/append to <strong>authorized_keys</strong> file in the folder with the content from the local host public key e.g. via <strong>cat .ssh/id.pub</strong>
* 4) Execute <strong>chmod 700 .ssh; chmod 640 .ssh/authorized_keys</strong> in the remote host
* 5) <strong>ssh</strong> command without password should work 
