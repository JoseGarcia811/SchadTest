
using SchadTest.DataAccess.Model.Customers;
using System.Collections.Generic; 

namespace SchadTest.Services.Repository
{
    public interface ICustomersRepository
    {
        IEnumerable<CustomersView> GetCustomers();
        Customers GetCustomersById(int idCustomerd);
        IEnumerable<CustomerType> GetCustomersType();
        void Insert(Customers customers);
        void Update(Customers customers); 
        bool Delete(int idCustomer);
    }
}
