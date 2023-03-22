using System;
using System.Data;
using System.Linq;
using System.Windows.Forms;

namespace DBProjectt
{
    public partial class Form1 : Form
    {
        DBEntities Ent = new DBEntities();
        public static int studentId { get; set; }
        public Form1()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            if (textBox1.Text != "" && textBox2.Text.Length >= 4)
            {
                button1.Enabled = true;
            }
            else
            {
                button1.Enabled = false;
            }
        }
        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            if (textBox1.Text != "" && textBox2.Text.Length >= 4)
            {
                button1.Enabled = true;
            }
            else
            {
                button1.Enabled = false;
            }
        }
        private void button1_Click(object sender, EventArgs e)
        {
            Student std = new Student();
            var studentName = (from s in Ent.Students where s.St_UserName == textBox1.Text select s).FirstOrDefault();
            var studentPass = (from s in Ent.Students where s.St_Password == textBox2.Text select s).FirstOrDefault();
            if (studentName!=null && studentPass != null)
            {
                studentId = studentName.St_Id;
                Form2 form2 = new Form2();
                form2.Show();
                this.Hide();
            }
            else
            {
                MessageBox.Show("Invalid");
            }
        }
    }
}
