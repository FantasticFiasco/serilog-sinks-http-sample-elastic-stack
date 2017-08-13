FROM microsoft/dotnet:1.0-sdk

WORKDIR /dotnetapp

# copy and build everything else
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out
ENTRYPOINT ["dotnet", "out/elastic-stack-sample.dll"]