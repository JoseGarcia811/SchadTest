using SchadTest.DataAccess.Model.Customers;
using SchadTest.Services.CustomerRepository;
using SchadTest.Services.Repository;
using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace SchadTest
{
    public partial class CreateCustomer : Form
    {
        ICustomersRepository customersRepository;
        DataGridView dataGrid;
        public CreateCustomer(int idCustomer, DataGridView dataGridView)
        {
            InitializeComponent();
            DropDownStatus();
            DropDownCustomerType();
            this.dataGrid = dataGridView;
            if (idCustomer != 0)
            {
                lblId.Show();
                label1.Show();
                lblTitle.Text = "Edit Costumer";
                lblId.Text = idCustomer.ToString();
                GetDataCustomerById(idCustomer); 
            }
            else {
                lblId.Hide();
                label1.Hide();
            }
        }
        private void GetDataCustomerById(int idCustomer)
        {
            customersRepository = new CustomersRepository();
            var customers = customersRepository.GetCustomersById(idCustomer);

            txtName.Text = customers.CustName;
            txtAddress.Text = customers.Adress;
            cmbStatus.SelectedValue = customers.Status ? "1" : "0";
            cmbCustomerType.SelectedValue = customers.CustomerTypeId;
        }
        private void DropDownCustomerType()
        {
            customersRepository = new CustomersRepository();
            cmbCustomerType.DataSource = customersRepository.GetCustomersType();

            cmbCustomerType.ValueMember = "Id";
            cmbCustomerType.DisplayMember = "Description";
        }

        private void button1_Click(object sender, System.EventArgs e)
        {
            Hide();
        }

        private void Save_Click(object sender, System.EventArgs e)
        {

            customersRepository = new CustomersRepository();
            Customers customer = new Customers();
            customer.id = Convert.ToInt32(lblId.Text);
            customer.CustName = txtName.Text;
            customer.Adress = txtAddress.Text;
            customer.Status = (cmbStatus.SelectedValue.ToString() == "1") ? true : false;
            customer.CustomerTypeId = Convert.ToInt32(cmbCustomerType.SelectedValue);

            if (customer.id == 0)
            {
                customersRepository.Insert(customer);
                ClearForm();
            }
            else
            {
                customersRepository.Update(customer);
            }
            if(this.dataGrid != null)
                this.dataGrid.DataSource = customersRepository.GetCustomers();
        }

        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtAddress.Text = string.Empty;
            cmbStatus.SelectedValue = "1";
            cmbCustomerType.SelectedValue = 1;
        }

        private void DropDownStatus()
        {
            Dictionary<string, string> list = new Dictionary<string, string>();
            list.Add("1", "Activo");
            list.Add("0", "Inactivo");
            cmbStatus.DataSource = new BindingSource(list, null);
            cmbStatus.DisplayMember = "Value";
            cmbStatus.ValueMember = "Key";

            string value = ((KeyValuePair<string, string>)cmbStatus.SelectedItem).Value;
        }
    }
}
