FROM gcc:latest
RUN apt-get update
RUN apt-get install -y gcc g++ make postgresql postgresql-contrib libpqxx-dev libpq-dev autoconf automake libtool curl unzip git
WORKDIR /usr/src/myapp


COPY . /usr/src/myapp
COPY ./postgresql.conf /etc/postgresql/13/main/postgresql.conf
COPY ./pg_hba.conf /etc/postgresql/13/main/pg_hba.conf

 CMD ["/bin/bash", "-c", "service postgresql restart && c++ psql.cpp -o myapp -I /usr/include/pqxx/ -L /usr/lib -lpq -lpqxx && ./myapp"]
# RUN ps -ef | grep postgres
# RUN find /tmp/ -name .s.PGSQL.5432
#RUN c++ psql.cpp -o myapp -I /usr/include/pqxx/ -L /usr/lib -lpq -lpqxx
#CMD ["./myapp"]