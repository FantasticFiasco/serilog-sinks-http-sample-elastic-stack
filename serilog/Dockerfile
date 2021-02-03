FROM mcr.microsoft.com/dotnet/sdk:5.0

WORKDIR /dotnetapp

COPY . .
RUN dotnet publish -c Release -o out
ENTRYPOINT ["dotnet", "out/serilog-example.dll"]
