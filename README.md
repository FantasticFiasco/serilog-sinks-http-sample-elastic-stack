# Serilog and the Elastic Stack

[![Build status](https://ci.appveyor.com/api/projects/status/sojh549t2n5nt4w4/branch/master?svg=true)](https://ci.appveyor.com/project/FantasticFiasco/serilog-sinks-http-sample-elastic-stack/branch/master)

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