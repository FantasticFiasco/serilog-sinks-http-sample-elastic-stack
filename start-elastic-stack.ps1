function Print ($Message) {
    Write-Host $Message -ForegroundColor Blue
}

function InitSubmodules
{
    Print("Update git submodules")
    git submodule update --init --recursive
}

function ConfigureLogstash
{
    Print("Configure Logstash HTTP input plugin to use JSON codec")
    $LogstashConfiguration =
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
    $LogstashConfiguration | Out-File -FilePath ./docker-elk/logstash/pipeline/logstash.conf
}

function StartElasticStack
{
    Print("Start Elastic Stack in a new process")
    Start-Process -FilePath docker-compose -ArgumentList up -WorkingDirectory .\docker-elk
}

function ConfigureLogstashIndexPattern
{
    Print("Wait 2 minutes for Elastic Stack to complete its initialization")
    Start-Sleep 120

    Print("Configure Logstash index pattern");
    $Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $Headers.Add("Content-Type", 'application/json')

    $Body = '{ "title":"logstash-*", "timeFieldName":"@timestamp", "notExpandable":true }'
    Invoke-RestMethod "http://localhost:9200/.kibana/index-pattern/logstash-*" -Method Put -Headers $Headers -Body $Body
    
    $Body = '{ "defaultIndex":"logstash-*" }'
    Invoke-RestMethod "http://localhost:9200/.kibana/config/5.5.1" -Method Put -Headers $Headers -Body $Body
}

$FirstTime = !(Test-Path ./docker-elk/README.md)
If ($FirstTime -eq $True)
{
    InitSubmodules
    ConfigureLogstash
}

StartElasticStack

If ($FirstTime -eq $True)
{
    ConfigureLogstashIndexPattern
}