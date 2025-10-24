# -----------------------
# Build aşaması
# -----------------------
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# .csproj dosyasını kopyala ve restore et
COPY TatilSeyahat1/*.csproj ./TatilSeyahat1/
RUN dotnet restore ./TatilSeyahat1/TatilSeyahat1.csproj

# Tüm kaynak dosyaları kopyala ve publish et
COPY . .
RUN dotnet publish ./TatilSeyahat1/TatilSeyahat1.csproj -c Release -o out

# -----------------------
# Runtime aşaması
# -----------------------
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app

# Build'dan publish edilmiş dosyaları al
COPY --from=build /app/out ./

# Uygulamayı çalıştır
ENTRYPOINT ["dotnet", "TatilSeyahat1.dll"]

