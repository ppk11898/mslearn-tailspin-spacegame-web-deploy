# Dockerfile
# ====== build stage ======
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY Tailspin.SpaceGame.Web.sln ./
COPY Tailspin.SpaceGame.Web/ Tailspin.SpaceGame.Web/
RUN dotnet restore
RUN dotnet publish Tailspin.SpaceGame.Web/Tailspin.SpaceGame.Web.csproj -c Release -o /app/publish

# ====== runtime stage ======
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "Tailspin.SpaceGame.Web.dll"]
