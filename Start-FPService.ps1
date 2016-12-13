$serviceName = "Escalator"
$service = Get-Service -Name $serviceName
if($service.Status -eq "Stopped"){
    Start-Service -Name $serviceName
    }
