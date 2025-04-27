FROM ubuntu:20.04

ENV ACCEPT_EULA=Y
ENV DB_NAME=eboard-local
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Копируем скрипт и все пакеты в контейнер
COPY init-db.sh /init-db.sh
COPY deb-final/ /all-packages/

RUN chmod +x /init-db.sh


# Устанавливаем базовые зависимости
RUN dpkg -i \
    /all-packages/readline-common_8.0-4_all.deb \
    /all-packages/libsigsegv2_2.12-2_amd64.deb \
    /all-packages/libmpfr6_4.0.2-1_amd64.deb \
    /all-packages/libreadline8_8.0-4_amd64.deb && \
    apt-get install -f -y

# Теперь можно ставить gawk
RUN dpkg -i /all-packages/gawk_1%3a5.0.1+dfsg-1ubuntu0.1_amd64.deb && \
    apt-get install -f -y

RUN dpkg -i \
    /all-packages/libssl1.1_1.1.1f-1ubuntu2.24_amd64.deb \
    /all-packages/libexpat1_2.2.9-1ubuntu0.8_amd64.deb \
    /all-packages/libpython3.8-minimal_3.8.10-0ubuntu1~20.04.18_amd64.deb \
    /all-packages/python3.8-minimal_3.8.10-0ubuntu1~20.04.18_amd64.deb \
    && apt-get install -f -y


# Сначала ставим только python3-minimal
RUN dpkg -i /all-packages/python3-minimal_3.8.2-0ubuntu2_amd64.deb && apt-get install -f -y

RUN dpkg -i \
    /all-packages/libmpdec2_2.4.2-3_amd64.deb \
    /all-packages/libsqlite3-0_3.31.1-4ubuntu0.6_amd64.deb && apt-get install -f -y

RUN dpkg -i \
    /all-packages/mime-support_3.64ubuntu1_all.deb \
    /all-packages/libpython3.8-stdlib_3.8.10-0ubuntu1~20.04.18_amd64.deb \
    /all-packages/libpython3-stdlib_3.8.2-0ubuntu2_amd64.deb && apt-get install -f -y

RUN dpkg -i \
    /all-packages/python3.8_3.8.10-0ubuntu1~20.04.18_amd64.deb && apt-get install -f -y

# После этого ставим python3
RUN dpkg -i /all-packages/python3_3.8.2-0ubuntu2_amd64.deb && apt-get install -f -y



RUN apt-get update && \
    dpkg -i /all-packages/*.deb || true && \
    apt-get install -f -y

#
#RUN dpkg -i \
#           /all-packages/libmpfr6_4.0.2-1_amd64.deb  \
#          /all-packages/gawk_1%3a5.0.1+dfsg-1ubuntu0.1_amd64.deb c
#
#RUN dpkg -i /all-packages/libmpfr6_4.0.2-1_amd64.deb \
#            /all-packages/gawk_1%3a5.0.1+dfsg-1ubuntu0.1_amd64.deb \
#            /all-packages/gcc-10-base_10.5.0-1ubuntu1~20.04_amd64.deb \
#            /all-packages/libc6_2.31-0ubuntu9.17_amd64.deb \
#            /all-packages/libcrypt1_1%3a4.4.10-10ubuntu4_amd64.deb \
#            /all-packages/libgcc-s1_10.5.0-1ubuntu1~20.04_amd64.deb \
#            /all-packages/libgmp10_2%3a6.2.0+dfsg-4ubuntu0.1_amd64.deb \
#            /all-packages/libidn2-0_2.2.0-2_amd64.deb \
#            /all-packages/libmpfr6_4.0.2-1_amd64.deb \
#            /all-packages/libreadline8_8.0-4_amd64.deb \
#            /all-packages/libsigsegv2_2.12-2_amd64.deb \
#            /all-packages/libtinfo6_6.2-0ubuntu2.1_amd64.deb \
#            /all-packages/libunistring2_0.9.10-2_amd64.deb \
#            /all-packages/readline-common_8.0-4_all.deb \
#            /all-packages/tzdata_2025b-0ubuntu0.20.04_all.deb || apt-get install -f
#
#
#
#RUN dpkg -i \
#            /all-packages/ca-certificates_20240203~20.04.1_all.deb \
#            /all-packages/krb5-locales_1.17-6ubuntu4.9_all.deb \
#            /all-packages/libasn1-8-heimdal_7.7.0+dfsg-1ubuntu1.4_amd64.deb \
#            /all-packages/libbrotli1_1.0.7-6ubuntu0.1_amd64.deb \
#            /all-packages/libcurl4_7.68.0-1ubuntu2.25_amd64.deb \
#            /all-packages/libgssapi-krb5-2_1.17-6ubuntu4.9_amd64.deb \
#            /all-packages/libgssapi3-heimdal_7.7.0+dfsg-1ubuntu1.4_amd64.deb \
#            /all-packages/libhcrypto4-heimdal_7.7.0+dfsg-1ubuntu1.4_amd64.deb \
#            /all-packages/libheimbase1-heimdal_7.7.0+dfsg-1ubuntu1.4_amd64.deb \
#            /all-packages/libheimntlm0-heimdal_7.7.0+dfsg-1ubuntu1.4_amd64.deb \
#            /all-packages/libhx509-5-heimdal_7.7.0+dfsg-1ubuntu1.4_amd64.deb \
#            /all-packages/libjemalloc2_5.2.1-1ubuntu1_amd64.deb \
#            /all-packages/libk5crypto3_1.17-6ubuntu4.9_amd64.deb \
#            /all-packages/libkeyutils1_1.6-6ubuntu1.1_amd64.deb \
#            /all-packages/libkrb5-26-heimdal_7.7.0+dfsg-1ubuntu1.4_amd64.deb \
#            /all-packages/libkrb5-3_1.17-6ubuntu4.9_amd64.deb \
#            /all-packages/libkrb5support0_1.17-6ubuntu4.9_amd64.deb \
#            /all-packages/libldap-2.4-2_2.4.49+dfsg-2ubuntu1.10_amd64.deb \
#            /all-packages/libldap-common_2.4.49+dfsg-2ubuntu1.10_all.deb \
#            /all-packages/libnghttp2-14_1.40.0-1ubuntu0.3_amd64.deb \
#            /all-packages/libpsl5_0.21.0-1ubuntu1_amd64.deb \
#            /all-packages/libroken18-heimdal_7.7.0+dfsg-1ubuntu1.4_amd64.deb \
#            /all-packages/librtmp1_2.4+20151223.gitfa8646d.1-2build1_amd64.deb \
#            /all-packages/libsasl2-2_2.1.27+dfsg-2ubuntu0.1_amd64.deb \
#            /all-packages/libsasl2-modules_2.1.27+dfsg-2ubuntu0.1_amd64.deb \
#            /all-packages/libsasl2-modules-db_2.1.27+dfsg-2ubuntu0.1_amd64.deb \
#            /all-packages/libsqlite3-0_3.31.1-4ubuntu0.6_amd64.deb \
#            /all-packages/libssh-4_0.9.3-2ubuntu2.5_amd64.deb \
#            /all-packages/libssl1.1_1.1.1f-1ubuntu2.24_amd64.deb \
#            /all-packages/libwind0-heimdal_7.7.0+dfsg-1ubuntu1.4_amd64.deb \
#            /all-packages/locales_2.31-0ubuntu9.17_all.deb \
#            /all-packages/openssl_1.1.1f-1ubuntu2.24_amd64.deb \
#            /all-packages/publicsuffix_20200303.0012-1_all.deb \
#            /all-packages/mssql-server_16.0.4175.1-3_amd64.deb \
#            /all-packages/mssql-server-fts_16.0.4185.3-3_amd64.deb \
#            /all-packages/file_1%3a5.38-4_amd64.deb \
#            /all-packages/gawk_1%3a5.0.1+dfsg-1ubuntu0.1_amd64.deb \
#            /all-packages/gdb_9.2-0ubuntu1~20.04.2_amd64.deb \
#            /all-packages/gdbserver_9.2-0ubuntu1~20.04.2_amd64.deb \
#            /all-packages/libatomic1_10.5.0-1ubuntu1~20.04_amd64.deb \
#            /all-packages/libbabeltrace1_1.5.8-1build1_amd64.deb \
#            /all-packages/libc++1_1%3a10.0-50~exp1_amd64.deb \
#            /all-packages/libc++1-10_1%3a10.0.0-4ubuntu1_amd64.deb \
#            /all-packages/libc++abi1-10_1%3a10.0.0-4ubuntu1_amd64.deb \
#            /all-packages/libc6-dbg_2.31-0ubuntu9.17_amd64.deb \
#            /all-packages/libcc1-0_10.5.0-1ubuntu1~20.04_amd64.deb \
#            /all-packages/libdw1_0.176-1.1ubuntu0.1_amd64.deb \
#            /all-packages/libelf1_0.176-1.1ubuntu0.1_amd64.deb \
#            /all-packages/libexpat1_2.2.9-1ubuntu0.8_amd64.deb \
#            /all-packages/libglib2.0-0_2.64.6-1~ubuntu20.04.8_amd64.deb \
#            /all-packages/libglib2.0-data_2.64.6-1~ubuntu20.04.8_all.deb \
#            /all-packages/libicu66_66.1-2ubuntu2.1_amd64.deb \
#            /all-packages/libmagic-mgc_1%3a5.38-4_amd64.deb \
#            /all-packages/libmagic1_1%3a5.38-4_amd64.deb \
#            /all-packages/libmpdec2_2.4.2-3_amd64.deb \
#            /all-packages/libnuma1_2.0.12-1_amd64.deb \
#            /all-packages/libpython3.8_3.8.10-0ubuntu1~20.04.18_amd64.deb \
#            /all-packages/libpython3.8-minimal_3.8.10-0ubuntu1~20.04.18_amd64.deb \
#            /all-packages/libpython3.8-stdlib_3.8.10-0ubuntu1~20.04.18_amd64.deb \
#            /all-packages/libreadline8_8.0-4_amd64.deb \
#            /all-packages/libsasl2-modules-gssapi-mit_2.1.27+dfsg-2ubuntu0.1_amd64.deb \
#            /all-packages/libsigsegv2_2.12-2_amd64.deb \
#            /all-packages/libsss-nss-idmap0_2.2.3-3ubuntu0.13_amd64.deb \
#            /all-packages/libunwind8_1.2.1-9ubuntu0.1_amd64.deb \
#            /all-packages/libxml2_2.9.10+dfsg-5ubuntu0.20.04.9_amd64.deb \
#            /all-packages/lsof_4.93.2+dfsg-1ubuntu0.20.04.1_amd64.deb \
#            /all-packages/mime-support_3.64ubuntu1_all.deb \
#            /all-packages/python3.8_3.8.10-0ubuntu1~20.04.18_amd64.deb \
#            /all-packages/curl_7.68.0-1ubuntu2.25_amd64.deb \
#            /all-packages/debconf-utils_1.5.73_all.deb \
#            /all-packages/dirmngr_2.2.19-3ubuntu2.4_amd64.deb \
#            /all-packages/gnupg_2.2.19-3ubuntu2.4_all.deb \
#            /all-packages/gnupg-l10n_2.2.19-3ubuntu2.4_all.deb \
#            /all-packages/gnupg-utils_2.2.19-3ubuntu2.4_amd64.deb \
#            /all-packages/gnupg2_2.2.19-3ubuntu2.4_all.deb \
#            /all-packages/gpg_2.2.19-3ubuntu2.4_amd64.deb \
#            /all-packages/gpg-agent_2.2.19-3ubuntu2.4_amd64.deb \
#            /all-packages/gpg-wks-client_2.2.19-3ubuntu2.4_amd64.deb \
#            /all-packages/gpg-wks-server_2.2.19-3ubuntu2.4_amd64.deb \
#            /all-packages/gpgconf_2.2.19-3ubuntu2.4_amd64.deb \
#            /all-packages/gpgsm_2.2.19-3ubuntu2.4_amd64.deb \
#            /all-packages/libassuan0_2.5.3-7ubuntu2_amd64.deb \
#            /all-packages/libksba8_1.3.5-2ubuntu0.20.04.2_amd64.deb \
#            /all-packages/libnpth0_1.6-1_amd64.deb \
#            /all-packages/pinentry-curses_1.1.0-3build1_amd64.deb \
#            /all-packages/libltdl7_2.4.6-14_amd64.deb \
#            /all-packages/libodbc1_2.3.6-0.1ubuntu0.1_amd64.deb \
#            /all-packages/msodbcsql18_18.5.1.1-1_amd64.deb \
#            /all-packages/mssql-tools18_18.4.1.1-1_amd64.deb \
#            /all-packages/odbcinst_2.3.6-0.1ubuntu0.1_amd64.deb \
#            /all-packages/odbcinst1debian2_2.3.6-0.1ubuntu0.1_amd64.deb \
#            /all-packages/unixodbc_2.3.6-0.1ubuntu0.1_amd64.deb || apt-get install -f -y


# 2️⃣ Добавляем MSSQL Tools в PATH
RUN echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> /etc/profile
RUN ln -s /opt/mssql-tools18/bin/* /usr/local/bin/

# 4️⃣ Очистка временных файлов
RUN rm -rf /all-packages /var/lib/apt/lists/*

EXPOSE 1433

CMD ["/init-db.sh"]
