FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app

# Tell Docker this container listens on port 5000
EXPOSE 5000

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ./src/MyWebApi/ ./MyWebApi/
WORKDIR /src/MyWebApi
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

# Set environment variable to tell .NET to listen on port 5000
ENV ASPNETCORE_URLS="http://+:5000"

ENTRYPOINT ["dotnet", "MyWebApi.dll"]
