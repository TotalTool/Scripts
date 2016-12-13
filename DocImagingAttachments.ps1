#Opens up connection to outlook
$o = New-Object -ComObject Outlook.Application
$n = $o.GetNamespace("MAPI")

#sets inbox variable
$inbox=$n.GetDefaultFolder(6)

#sets filepaths for attachments to be saved to 
$filepathPick = "I:\remote_stores\pick_tickets_appleton"
$filepathPack = "I:\remote_stores\packing_slips_appleton"

#loops through each mail item
#saves attachment to filepath based on subject line
$inbox.Items | foreach{
   If($_.subject -match "pi"){
   	$_.attachments | foreach{
	   $_.saveasfile((Join-Path $filepathPick $_.filename))
	}
   }

   ElseIf($_.subject -match "pa"){
	$_.attachments | foreach{
	   $_.saveasfile((Join-Path $filepathPack $_.filename))
	}
   } 
}


#opens up new session to exchange server
$cred = Get-Credential totaltool\administrator
$session = New-PSSession -ConfigurationName microsoft.exchange -ConnectionUri http://exch3/powershell -Credential $cred
Import-PSSession $session

#retrieves scan mailbox
#searches for suject line and deletes if pa or pi
Get-Mailbox -identity scans| Search-Mailbox -SearchQuery 'Subject: "pa" OR "pi" ' -DeleteContent



