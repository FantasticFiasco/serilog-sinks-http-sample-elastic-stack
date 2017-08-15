# Serilog and the Elastic Stack

## Usage

### Elastic Stack

```bash
PS> cd elastic-stack
PS> docker-compose up
```

Wait 2 minutes first time the Elastic Stack is started.

```
PS> $Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
PS> $Headers.Add("Content-Type", 'application/json')
PS> Invoke-RestMethod "http://localhost:9200/.kibana/index-pattern/logstash-*" `
      -Method Put `
      -Headers $Headers `
      -Body '{ "title":"logstash-*", "timeFieldName":"@timestamp", "notExpandable":true }'
PS> Invoke-RestMethod "http://localhost:9200/.kibana/config/5.5.1" `
      -Method Put `
      -Headers $Headers `
      -Body '{ "defaultIndex":"logstash-*" }'
```

### Serilog

```bash
PS> cd serilog
PS> docker-compose up
```