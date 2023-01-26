using Dapper;
using SchadTest.DataAccess;
using SchadTest.DataAccess.Model.Customers;
using SchadTest.Services.Repository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SchadTest.Services.CustomerRepository
{
    public class CustomersRepository : ICustomersRepository
    {

        public IEnumerable<CustomersView> GetCustomers()
        {
            var sql = "SELECT * FROM [CustomerView]";
            using (var connection = new SqlConnection(AppConfiguration.ConnectionString))
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();

                return connection.Query<CustomersView>(sql, commandType: CommandType.Text);
            }
        }

        public void Insert(Customers customers)
        {
            try
            {
                using (var connection = new SqlConnection(AppConfiguration.ConnectionString))
                { 
                    DynamicParameters p = new DynamicParameters();
                    p.Add("@CustName", customers.CustName);
                    p.Add("@Address", customers.Adress);
                    p.Add("@Status", customers.Status);
                    p.Add("@CustomerType", customers.CustomerTypeId);
                  connection.Execute("sp_customer_insert", p, commandType: CommandType.StoredProcedure);
                }

            }
            catch (Exception e) { } 
        }

        public void Update(Customers customers)
        {
            try
            {
                using (var connection = new SqlConnection(AppConfiguration.ConnectionString))
                {
                    DynamicParameters p = new DynamicParameters();
                    p.Add("@Id", customers.id);
                    p.Add("@CustName", customers.CustName);
                    p.Add("@Address", customers.Adress);
                    p.Add("@Status", customers.Status);
                    p.Add("@CustomerType", customers.CustomerTypeId);
                    connection.Execute("sp_customer_update", p, commandType: CommandType.StoredProcedure);
                }

            }
            catch (Exception e) { }
        }
        public bool Delete(int idCustomer)
        {
            try
            { 

                var sql = "delete from [Customers] WHERE Id = " + idCustomer;

                using (var connection = new SqlConnection(AppConfiguration.ConnectionString))
                {
                    if (connection.State == ConnectionState.Closed)
                        connection.Open();

                    var result = connection.Query<Customers>(sql, commandType: CommandType.Text);

                    return (result.AsList().Count == 0) ? true : false;
                }
            }
            catch (Exception e) { }

            return false;
        }

        public Customers GetCustomersById(int idCustomer)
        {
            try
            {
                var sql = "SELECT * FROM [Customers] WHERE Id = " + idCustomer;
                using (var connection = new SqlConnection(AppConfiguration.ConnectionString))
                {
                    if (connection.State == ConnectionState.Closed)
                        connection.Open();

                    return connection.QueryFirstOrDefault<Customers>(sql, commandType: CommandType.Text);
                }
            }
            catch (Exception e)
            { }
            return null;
        }

        public IEnumerable<CustomerType> GetCustomersType()
        {
            try
            {
                var sql = "SELECT * FROM [CustomerTypes]";
                using (var connection = new SqlConnection(AppConfiguration.ConnectionString))
                {
                    if (connection.State == ConnectionState.Closed)
                        connection.Open();

                    return connection.Query<CustomerType>(sql, commandType: CommandType.Text);
                }
            }
            catch (Exception e)
            { }
            return null;
        }

    }
}
