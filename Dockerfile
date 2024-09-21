FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["SE310-Blog.csproj", "./"]
RUN dotnet restore "SE310-Blog.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "SE310-Blog.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SE310-Blog.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SE310-Blog.dll"]
