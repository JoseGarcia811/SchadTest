using SchadTest.DataAccess.Model.Invoices;

namespace SchadTest.Services.CommonInterfaces
{
    public interface IInvoicesRepository
    { 
        void Insert(Invoices customers);
    }
}
