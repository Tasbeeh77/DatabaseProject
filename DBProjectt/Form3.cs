using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;

namespace DBProjectt
{
    public partial class Form3 : Form
    {
        DBEntities Ent = new DBEntities();
        int count = 0;
        string answer;
        List<Crs_Exam_Ques> questions;
        string [] answers = new string[10];
        public Form3()
        {
            InitializeComponent();
            button1.Enabled = button3.Enabled = false;
        }
        protected override void OnPaint(PaintEventArgs e)
        {
            Graphics g = this.CreateGraphics();
            g.DrawLine(new Pen(Brushes.CadetBlue, 3), 40, 90, Width - 60, 90);
        }
        #region Functions
        void setVisibility(string type)
        {
            if(type=="MCQ")
            {
                radioButton1.Visible = true;
                radioButton2.Visible = true;
                radioButton3.Visible = true;
                radioButton4.Visible = true;
            }
            else
            {
                radioButton1.Visible = true;
                radioButton2.Visible = true;
                radioButton3.Visible = false;
                radioButton4.Visible = false;
            }
        }

        void checkRadioButton()
        {
            if (radioButton1.Checked == true)
            {
                answer = radioButton1.Text;
            }
            else if (radioButton2.Checked == true)
            {
                answer = radioButton2.Text;
            }
            else if (radioButton3.Checked == true)
            {
                answer = radioButton3.Text;
            }
            else
            {
                answer = radioButton4.Text;
            }
        }

        void DisplayChoices()
        {
            int id = questions[count].Ques_Id;
            var question = (from qt in Ent.Questions where qt.Ques_Id == id select qt).FirstOrDefault();
            label1.Text = question.Ques_Text;
            if (question.Ques_Type == "MCQ")
            {
                var choice = (from ch in Ent.Choices where ch.Ques_Id == id select ch).FirstOrDefault();
                setVisibility("MCQ");
                radioButton1.Text = choice.Choice1;
                radioButton2.Text = choice.Choice2;
                radioButton3.Text = choice.Choice3;
                radioButton4.Text = choice.Choice4;
            }
            else
            {
                setVisibility("T_F");
                radioButton1.Text = "True";
                radioButton2.Text = "False";
            }
        }
        #endregion

        #region Next Button
        private void button2_Click(object sender, EventArgs e)
        {
            button1.Enabled = button3.Enabled = true;
            checkRadioButton();
            if(count<questions.Count && count<answers.Length)
            {
                answers[count] = answer;
                DisplayChoices();
                count++;
            }
            else
            {
                button2.Enabled = false;
            }
        }
        #endregion

        #region Previous Button
        private void button1_Click(object sender, EventArgs e)
        {
            button2.Enabled = true;
            if (count > 0)
            {
                count--;
                DisplayChoices();
            }
            else
            {
                button1.Enabled = false;
            }
        }
        #endregion

        #region Submit Answers
        private void button3_Click(object sender, EventArgs e)
        {
            int examid = Form2.examId;
            int stdid = Form1.studentId;
            for (int i = 0; i < questions.Count; i++)
            {
                int quesid = questions[i].Ques_Id;
                string answ = answers[i];
                IEnumerable<DBEntities> answersInsert = Ent.Database.SqlQuery<DBEntities>($"exec ST_Ques_Exam_insert {examid}, {quesid}, {stdid}, '{answ}'").ToList();
                Ent.SaveChanges();
            }
            IEnumerable<DBEntities> correction = Ent.Database.SqlQuery<DBEntities>($"exec Exam_Correction {stdid}, {examid}").ToList();
            Form4 form4 = new Form4();
            form4.Show();
            this.Hide();
        }
        #endregion

        private void Form3_Load(object sender, EventArgs e)
        {
            questions = (from q in Ent.Crs_Exam_Ques where q.Exam_Id == Form2.examId select q).ToList();
            DisplayChoices();
        }
    }
}
