using System;
using System.Collections.Generic;
using System.Text;

namespace SchadTest.DataAccess.Model.Invoices
{
    public class Invoices
    {
        public int Id { get; set; }
        public int CustomerId { get; set; }
        public decimal TotalItbis { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Total { get; set; }
    }
}
