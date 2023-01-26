using System;
using System.Collections.Generic;
using System.Text;

namespace SchadTest.DataAccess.Model.Customers
{
    public class CustomersView
    {
        public int Id { get; set; }
        public string CustName { get; set; }
        public string Address { get; set; }
        public string Status { get; set; }
        public string CustomerType { get; set; }
    }
}
