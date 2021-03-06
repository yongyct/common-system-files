# Other Helpful Tools

## SSH with private key file & non-22 port
* `ssh -i /path/to/key.pem -p myport myuser@myhost`

## SSH Tunneling with Local Port Forwarding
* `ssh -N -L [binded local address:]myport:remotehost:remoteport [-i /path/to/key] myuser@sshtunnelhost`
* -N to not launch ssh terminal to sshtunnelhost
* -i to provide private ssh key
* hitting localaddress:port will be redirected to remotehost:port

## Passwordless ssh
* 1) Generate key-pair by executing `ssh-keygen -t [rsa/dsa/ecdsa] -b [2048/4096]`
* 2) SSH to remote host normally `ssh myuser@remotehost`, and key in password to login
* 3) Create `.ssh` directory if not already there, and create/append to `authorized_keys` file in the folder with the content from the local host public key e.g. via `cat .ssh/id.pub`
* 4) Execute `chmod 700 .ssh; chmod 640 .ssh/authorized_keys` in the remote host
* 5) `ssh myuser@remotehost` command without password should work 

## SCP with different port, recursive
* `scp -r -P myport myuser@myhost:/remote/path/to/file /local/path/to/file`

## Import new .crt into ca
* `keytool -import -keystore /path/to/ca -storepass capassword -file /path/to/newcert.crt -alias newcertalias -noprompt`

## Converting between certificate types (e.g. p12, pem, p8)
When converting p12 to p8, need to convert to pem as an intermediate step first (i.e. p12 -> pem -> p8). Source - https://knowledge.digicert.com/solution/SO26449.html
* 1) `openssl pkcs12 -in certificatename.pfx -nocerts -nodes -out certificatename.pem`
* 2) `openssl pkcs8 -in certificatename.pem -topk8 -nocrypt -out certificatename.pk8`

## Kerberos Keytab Creation
* 1) Execute `ktutil`
* 2) Under ktutil prompt, execute `addent -password -p myuser@MY.REALM.COM -k 1 -e arcfour-hmac`
* 3) Key in password, and press Enter
* 4) Under ktutil prompt, execute `wkt /path/to/myuser.keytab` and press enter, and exit prompt
* 5) To check keytab, execute `klist -k /path/to/myuser.keytab`

## Getting TGT with krb5 CLI
* With keytab: `kinit -kt myuser.keytab myuser[@MY.OTHER.REALM.COM]`
* Without keytab: `kinit myuser[@MY.OTHER.REALM.COM]`
* Check TGT: `klist`

## Execute command as daemon 
* `nohup mycommand > my.log &`
* `nohup mycommand > my.log 2>&1 & echo $! > my.pid &`

## Find out file system disk space status
* `df -hT`

## Get sorted file sizes within a folder
* `du -sh ./* | sort -h`

## File system commands
* `mkdir -p /path/to` - make intermediate dir if not exist
* `cp -a /path/to/src /path/to/dest` - copy folder recursively + with original file properties (e.g. permission, etc)

## Get Public IP
* `curl https://api.ipify.org/`
