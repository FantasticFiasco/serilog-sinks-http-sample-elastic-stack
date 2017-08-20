FROM microsoft/dotnet:2.0-sdk

WORKDIR /dotnetapp

COPY . .
RUN dotnet publish -c Release -o out
ENTRYPOINT ["dotnet", "out/serilog-example.dll"]