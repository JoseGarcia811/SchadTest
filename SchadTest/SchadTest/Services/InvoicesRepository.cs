using Dapper;
using SchadTest.DataAccess;
using SchadTest.DataAccess.Model.Invoices;
using SchadTest.Services.CommonInterfaces;
using System;
using System.Data;
using System.Data.SqlClient;

namespace SchadTest.Services
{
    public class InvoicesRepository : IInvoicesRepository
    {
        public void Insert(Invoices invoices)
        {
            try
            {
                using (var connection = new SqlConnection(AppConfiguration.ConnectionString))
                {
                    DynamicParameters p = new DynamicParameters();
                    p.Add("@CustomerId", invoices.CustomerId);
                    p.Add("@TotalItbis", invoices.TotalItbis);
                    p.Add("@SubTotal", invoices.SubTotal);
                    p.Add("@Total", invoices.Total);
                    connection.Execute("sp_invoice_insert", p, commandType: CommandType.StoredProcedure);
                }

            }
            catch (Exception e) { }
        }
    }
}
