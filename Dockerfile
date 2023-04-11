FROM mcr.microsoft.com/dotnet/sdk:3.1

WORKDIR /app

COPY . .

RUN dotnet publish -c Release -o out

ENTRYPOINT ["dotnet", "out/myapp.dll"]
