using SchadTest.DataAccess.Model.Invoices;
using SchadTest.Services;
using SchadTest.Services.CommonInterfaces;
using SchadTest.Services.CustomerRepository;
using SchadTest.Services.Repository;
using System; 
using System.Windows.Forms;

namespace SchadTest.Views.Invoice
{
    public partial class Invoice : Form
    {
        ICustomersRepository customersRepository; 
        IInvoicesRepository invoicesRepository;
        public Invoice()
        {
            InitializeComponent();
            DropDownCustomer();
        }
        private void DropDownCustomer()
        {
            customersRepository = new CustomersRepository();
            cmbCustomer.DataSource = customersRepository.GetCustomers();

            cmbCustomer.ValueMember = "Id";
            cmbCustomer.DisplayMember = "CustName";
        }

        private void button2_Click(object sender, EventArgs e)
        { 
            CreateCustomer createCustomer = new CreateCustomer(0, null);
            createCustomer.ShowDialog(); 
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Hide();
            Customer customer = new Customer();
            customer.ShowDialog();
            Close();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            DropDownCustomer();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            invoicesRepository = new InvoicesRepository();
            Invoices invoices = new Invoices();
            invoices.CustomerId = Convert.ToInt32(cmbCustomer.SelectedValue);
            invoices.TotalItbis = Convert.ToDecimal(txtTotalItebis.Text);
            invoices.SubTotal = Convert.ToDecimal(txtSubTotal.Text);
            invoices.Total = Convert.ToDecimal(txtTotal.Text);


            invoicesRepository.Insert(invoices);
            ClearForm(); 
        }

        private void ClearForm()
        {
            cmbCustomer.Text = string.Empty;
            txtTotalItebis.Text = string.Empty;
            txtSubTotal.Text = string.Empty;
            txtTotal.Text = string.Empty;
        }
    }
}
