FROM debian:10
EXPOSE 5380/tcp
EXPOSE 53/udp
VOLUME /opt/dns/config
ENV http_proxy=http://proxy.au.ext.ray.com:80 
ENV https_proxy=http://proxy.au.ext.ray.com:80
RUN apt update && apt install -y gnupg wget curl apt-transport-https
RUN curl -fsSL -q https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && wget -q https://packages.microsoft.com/config/debian/10/prod.list \
    && mv prod.list /etc/apt/sources.list.d/microsoft-prod.list \
    && apt update
RUN apt install -y  dotnet-runtime-2.2
RUN wget https://download.technitium.com/dns/DnsServerPortable.tar.gz
RUN mkdir -p /etc/dns/
RUN tar -zxf DnsServerPortable.tar.gz -C /opt/dns/
ENTRYPOINT ["dotnet", "/opt/dns/DnsServerApp.dll"]