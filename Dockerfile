FROM mcr.microsoft.com/dotnet/sdk:3.1-alpine AS build
WORKDIR /app

COPY . .

RUN dotnet restore && dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/runtime-deps:3.1-alpine AS runtime
WORKDIR /app

COPY --from=build /app/out ./

ENTRYPOINT ["dotnet", "myapp.dll"]
