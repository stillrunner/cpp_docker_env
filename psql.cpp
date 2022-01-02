#include <iostream>
#include <pqxx/pqxx>


pqxx::result query()
{
  pqxx::connection c{"user=postgres password=postgres"};
  pqxx::work txn{c};

  pqxx::result r{txn.exec("SELECT* FROM playground")};

  txn.commit();
  return r;
}


int main(int, char *argv[])
{
  try
  {
    pqxx::result r{query()};
    for (auto row: r)
    {
      std::cout << "Row: ";
      for (auto field: row) std::cout << field.c_str() << " ";
      std::cout << std::endl;
    }
  }
  catch (pqxx::sql_error const &e)
  {
    std::cerr << "SQL error: " << e.what() << std::endl;
    std::cerr << "Query was: " << e.query() << std::endl;
    return 2;
  }
  catch (std::exception const &e)
  {
    std::cerr << "Error: " << e.what() << std::endl;
    return 1;
  }
}