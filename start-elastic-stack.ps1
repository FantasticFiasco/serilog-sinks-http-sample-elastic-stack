function Print ([string] $Message) {
    Write-Host $Message -ForegroundColor Blue
}

function Initialize-Submodules
{
    Print("Initialize git submodules...")
    git submodule update --init --recursive
}

function Edit-LogstashPipeline
{
    Print("Configure Logstash HTTP input plugin to use JSON codec...")
    $Configuration =
@"
input {
	http {
		port => 31311
		codec => json
	}
}

## Add your filters / logstash plugins configuration here

output {
	elasticsearch {
		hosts => "elasticsearch:9200"
	}
}
"@

    $FilePath = Resolve-Path "./docker-elk/logstash/pipeline/logstash.conf"
    $Encoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllLines($FilePath, $Configuration, $Encoding)
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

$FirstTime = !(Test-Path ./docker-elk/README.md)
If ($FirstTime -eq $True)
{
    Initialize-Submodules
    Edit-LogstashPipeline
}

Start-ElasticStack

If ($FirstTime -eq $True)
{
    Print("Wait 2 minutes for Elastic Stack to complete its initialization...")
    Start-Sleep 120
    Edit-LogstashIndexPattern
}
else {
    Print("Wait 30 seconds for Elastic Stack to complete its initialization...")
    Start-Sleep 30
}

Print("Done, the Elastic Stack is now running!");