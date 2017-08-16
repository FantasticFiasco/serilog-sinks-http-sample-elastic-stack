FROM microsoft/dotnet:1.0-sdk

WORKDIR /dotnetapp

COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out
ENTRYPOINT ["dotnet", "out/serilog-example.dll"]