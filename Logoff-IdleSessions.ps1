#Adds snapin to allow use of Citrix commands
Add-PSSnapin "Citrix.XenApp.Commands"

#Gets all sessions from the XenApp farm w/ the -Full parameter
#Loops through each session, creates variables
#-Full parameter grabs all info including LastInputTime and CurrentTime
$sessions = Get-XAsession -Farm -Full
foreach($session in $sessions){
    $State = $session.state
    $SessionID = $session.sessionID
    $Server = $session.Servername
    $Name = $session.accountname
    
    $LastIinputTime = $session.LastInputTime
    $CurrentTime = $session.CurrentTime
    $IdleTime = ($CurrentTime - $LastIinputTime)
    #Converts $IdleTime from date/time format to total minutes
    $IdleTimeMinutes = ([TimeSpan]::Parse($IdleTime)).TotalMinutes 
    
    #Stops any XenApp session that is disconnected or has been idle for more than 45 minutes
    if(($IdleTimeMinutes -gt "45" -and ('TOTALTOOL\josh.schubert.admin','TOTALTOOL\matt.bagan.admin' -notcontains $name)) -or ($State -eq "Disconnected")){
    	stop-xasession -servername $server -sessionID $sessionID  
    }	
}