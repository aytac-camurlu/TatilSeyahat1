# Build aşaması
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# Proje dosyasını restore için kopyala
COPY TatilSeyahat1/*.csproj ./TatilSeyahat1/
RUN dotnet restore ./TatilSeyahat1/TatilSeyahat1.csproj

# Tüm dosyaları kopyala ve publish et
COPY . ./
RUN dotnet publish TatilSeyahat1/TatilSeyahat1.csproj -c Release -o out

# Runtime aşaması
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "TatilSeyahat1.dll"]
