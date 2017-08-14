function Print ($Message) {
    Write-Host $Message -ForegroundColor Blue
}

function InitSubmodules
{
    Print("Updating git submodules...")
    git submodule update --init --recursive
}

function ConfigureLogstash
{
    Print("Configure Logstash HTTP input plugin to use JSON codec...")
    $LogstashConfiguration =
@"
input {
    tcp {
        port => 5000
    }
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
    Print("Starting the Elastic Stack in a new process...")
    Start-Process -FilePath docker-compose -ArgumentList up -WorkingDirectory .\docker-elk
}

$FirstTime = !(Test-Path ./docker-elk/README.md)
If ($FirstTime -eq $True)
{
    InitSubmodules
    ConfigureLogstash
}

StartElasticStack