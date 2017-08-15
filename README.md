# Serilog and the Elastic Stack

## Table of contents

- [Usage on Windows](#usage-on-windows)
- [Usage on Linux](#usage-on-linux)

---

## Usage on Windows

### Bringing up Elastic Stack

Start the stack using `docker-compose`:

```posh
PS> cd .\elastic-stack\
PS> docker-compose up
```

If this is the first time the stack is started, you'll have to create a Logstash index pattern. Give the stack some time to initialize and then run the following commands in PowerShell:

```posh
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

### Publishing log events using Serilog

Run the following commands to publish log events to Logstash using Serilog:

```posh
PS> cd .\serilog\
PS> docker-compose up
```

### Using Kibana to render the log events

Access the Kibana web UI by hitting [http://localhost:5601](http://localhost:5601) with a web browser.

## Usage on Linux

### Bringing up Elastic Stack

Start the stack using `docker-compose`:

```bash
$ cd elastic-stack/
$ docker-compose up
```

If this is the first time the stack is started, you'll have to create a Logstash index pattern. Give the stack some time to initialize and then run the following commands:

```bash
$ curl -XPUT -D- 'http://localhost:9200/.kibana/index-pattern/logstash-*' \
    -H 'Content-Type: application/json' \
    -d '{"title" : "logstash-*", "timeFieldName": "@timestamp", "notExpandable": true}'
$ curl -XPUT -D- 'http://localhost:9200/.kibana/config/5.5.1' \
    -H 'Content-Type: application/json' \
    -d '{"defaultIndex": "logstash-*"}'
```

### Publishing log events using Serilog

Run the following commands to publish log events to Logstash using Serilog:

```bash
$ cd serilog/
$ docker-compose up
```

### Using Kibana to render the log events

Access the Kibana web UI by hitting [http://localhost:5601](http://localhost:5601) with a web browser.