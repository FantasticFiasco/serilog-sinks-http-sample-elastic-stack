function Print ([string] $Message) {
    Write-Host $Message -ForegroundColor Blue
}

function Initialize-Image
{
    Print("Build Docker image...")
    docker build -t elastic-stack-sample ./src
}

function Start-Container
{
    Print("Start Docker container...")
    docker run -it --rm elastic-stack-sample
}

Initialize-Image
Start-Container