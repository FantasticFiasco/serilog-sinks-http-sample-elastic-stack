function UpdateSubmodules
{
    Write-Information "Updating git submodules..."
    git submodule update --init --recursive
}

# Update git submodules if required
$GitSubmodules = Test-Path ./submodules/docker-elk/README.md
If ($GitSubmodules -eq $False)
{
    UpdateSubmodules
}