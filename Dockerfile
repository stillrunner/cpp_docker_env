FROM gcc:latest
RUN apt-get update
RUN apt-get install -y gcc g++ make postgresql postgresql-contrib libpqxx-dev libpq-dev autoconf automake libtool curl unzip git
WORKDIR /usr/src/myapp


COPY . /usr/src/myapp
COPY ./postgresql.conf /etc/postgresql/13/main/postgresql.conf
COPY ./pg_hba.conf /etc/postgresql/13/main/pg_hba.conf

CMD ["/bin/bash", "-c", "service postgresql restart && createdb playground --username=postgres && c++ psql.cpp -o myapp -I /usr/include/pqxx/ -L /usr/lib -lpq -lpqxx && ./myapp"]
