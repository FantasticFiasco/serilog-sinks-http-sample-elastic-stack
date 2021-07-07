FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine

WORKDIR /dotnetapp

COPY . .
RUN dotnet publish -c Release -o out
ENTRYPOINT ["dotnet", "out/serilog-example.dll"]
