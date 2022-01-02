FROM gcc:latest
RUN apt-get update
RUN apt-get install -y gcc g++ make postgresql libpqxx-dev libpq-dev autoconf automake libtool curl unzip git

WORKDIR /usr/src/myapp

COPY . /usr/src/myapp

RUN c++ psql.cpp -o myapp -I /usr/include/pqxx/ -L /usr/lib -lpq -lpqxx
CMD ["./myapp"]