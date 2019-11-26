$EmailParams =
    @{
      To         = 'myuser@myhost.com'
      From       = 'no-reply@myhost.com'
      Subject    = '"Job Notification"'
      Body       = '"File Transfer Job Failed!"'
      SMTPServer = 'mysmtpserver.com'
     }

  $Scriptblock = [Scriptblock]::Create(
   "Send-MailMessage $(&{$args} @EmailParams) ")
 Invoke-Command -ScriptBlock $Scriptblock -ComputerName mysmtpserver.com
 
