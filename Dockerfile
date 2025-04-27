FROM --platform=linux/amd64 ubuntu:20.04

ENV ACCEPT_EULA=Y
ENV DB_NAME=eboard-local
ENV DEBIAN_FRONTEND=noninteractive

# Копируем пакеты MSSQL
COPY packages/ /tmp/packages/
COPY init-db.sh /init-db.sh

RUN chmod +x /init-db.sh

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y libjemalloc2 libcurl4 openssl libkrb5-3 locales

# Устанавливаем MSSQL Server и Full-Text Search
RUN dpkg -i /tmp/packages/mssql-server_*.deb || apt-get install -y -f
RUN dpkg -i /tmp/packages/mssql-server-fts_*.deb || apt-get install -y -f

# Утилиты и репозиторий Microsoft
RUN apt-get update && apt-get install -y curl apt-transport-https debconf-utils gnupg2
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Устанавливаем драйверы и инструменты SQL Server
RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18
RUN echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

# Локализация
RUN apt-get -y install locales && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

EXPOSE 1433

CMD ["/init-db.sh"]
