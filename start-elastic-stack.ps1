function Print ([string] $Message) {
    Write-Host $Message -ForegroundColor Blue
}

function Edit-LogstashIndexPattern
{
    Print("Configure Logstash index pattern...");
    $Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $Headers.Add("Content-Type", 'application/json')

    $Body = '{ "title":"logstash-*", "timeFieldName":"@timestamp", "notExpandable":true }'
    Invoke-RestMethod "http://localhost:9200/.kibana/index-pattern/logstash-*" -Method Put -Headers $Headers -Body $Body
    
    $Body = '{ "defaultIndex":"logstash-*" }'
    Invoke-RestMethod "http://localhost:9200/.kibana/config/5.5.1" -Method Put -Headers $Headers -Body $Body
}

function Start-ElasticStack
{
    Print("Start Elastic Stack in new process...")
    Start-Process -FilePath docker-compose -ArgumentList up -WorkingDirectory .\docker-elk
}

#$FirstTime = !(Test-Path ./docker-elk/README.md)

Start-ElasticStack

#If ($FirstTime -eq $True)
#{
    Print("Wait 2 minutes for Elastic Stack to complete its initialization...")
    Start-Sleep 120
    Edit-LogstashIndexPattern
#}
#else {
#    Print("Wait 30 seconds for Elastic Stack to complete its initialization...")
#    Start-Sleep 30
#}

Print("Done, the Elastic Stack is now running!");