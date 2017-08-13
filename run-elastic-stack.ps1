function Print ($Message) {
    Write-Host $Message -ForegroundColor Blue
}

$FirstTime = !(Test-Path ./docker-elk/README.md)
If ($FirstTime -eq $True)
{
    Print("Updating git submodules...")
    git submodule update --init --recursive
}

Print("Starting the Elastic Stack in a new process...")
Start-Process -FilePath docker-compose -ArgumentList up -WorkingDirectory .\docker-elk