FROM microsoft/dotnet:2.2-runtime-bionic-arm32v7 as runtime

WORKDIR /app

FROM microsoft/dotnet:2.2-sdk-bionic-arm32v7 as build

WORKDIR /src

COPY ./app/app.csproj ./ 

RUN dotnet restore app.csproj

COPY ./app/ .

RUN dotnet build app.csproj -o /app

FROM runtime as final

COPY --from=build /app .

ENTRYPOINT ["dotnet", "app.dll"]




