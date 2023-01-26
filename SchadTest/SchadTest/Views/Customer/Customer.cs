using SchadTest.Services.CustomerRepository;
using SchadTest.Services.Repository;
using SchadTest.Views.Invoice;
using System;
using System.Windows.Forms;

namespace SchadTest
{
    public partial class Customer : Form
    {
        ICustomersRepository customersRepository;

        public Customer()
        {
            InitializeComponent();
            GetDataList();
        }

        private void GetDataList()
        {
            customersRepository = new CustomersRepository();
            dataGrid.DataSource = customersRepository.GetCustomers();
        }

        private void dataGrid_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var idCustomer = Convert.ToInt32(dataGrid.Rows[e.RowIndex].Cells[0].Value);
            if (dataGrid.Columns[e.ColumnIndex].Name == "Edit")
            {
                CreateCustomer createCustomer = new CreateCustomer(idCustomer, dataGrid);
                createCustomer.ShowDialog();
            }
            else if (dataGrid.Columns[e.ColumnIndex].Name == "Delete")
            {
                if (MessageBox.Show("Are you sure to delete customer ID: " + idCustomer + "?", "Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                { 
                    customersRepository = new CustomersRepository();
                    var result = customersRepository.Delete(idCustomer);

                    if (result)
                        GetDataList();
                }
            }

        }

        private void button1_Click(object sender, System.EventArgs e)
        {
            CreateCustomer createCustomer = new CreateCustomer(0, dataGrid);
            createCustomer.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Hide();
            Invoice invoice = new Invoice();
            invoice.ShowDialog();
            Close();
        }
    }
}
