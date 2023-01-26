using SchadTest.Views.Invoice;
using System; 
using System.Windows.Forms;

namespace SchadTest
{
    public partial class ScreenLaunch : Form
    {
        public ScreenLaunch()
        {
            InitializeComponent();
        } 
        private void button1_Click(object sender, EventArgs e)
        {
            Hide();
            Invoice screen = new Invoice();
            screen.ShowDialog();
            Close();
        }
    }
}
