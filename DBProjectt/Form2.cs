using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Windows.Forms;

namespace DBProjectt
{
    public partial class Form2 : Form
    {
        DBEntities Ent= new DBEntities();
        int id;
        int crsId;
        List<string> list;
        IQueryable<Stud_Course> studentCourses;
        List<Button> Buttons = new List<Button>();  
        public static int examId { get; set;}
        public Form2()
        {
            InitializeComponent();
            Buttons.Add(button1);
            Buttons.Add(button2);
            Buttons.Add(button3);
            Buttons.Add(button4);
            Buttons.Add(button5);
        }
        #region Display available courses
        private void Form2_Load(object sender, EventArgs e)
        {
            id = Form1.studentId;
            list = new List<string>();
            studentCourses = from s in Ent.Stud_Course where s.St_Id == id select s;
            foreach (var item in studentCourses)
            {
                list.Add(item.Course.Crs_Name);
            }
            for (int i = 0; i < list.Count; i++)
            {
                Buttons[i].Visible = true;
                Buttons[i].Text = list[i];
            }
        }
        #endregion

        #region Generate Exam Function
        void GenerateExams(Button button , int MCQ , int T_F)
        {
            foreach (var item in studentCourses)
            {
                if (item.Course.Crs_Name == button.Text)
                {
                    crsId = item.Course.Crs_Id;
                    MessageBox.Show($"You Chose {button.Text} course");
                    break;
                }
            }
            IEnumerable<DBEntities> examDetails = Ent.Database.SqlQuery<DBEntities>($"exec ExamGeneration {crsId}, {MCQ},{T_F}").ToList();
            Ent.SaveChanges();
            examId = (from ex in Ent.Crs_Exam_Ques where ex.Crs_Id == crsId select ex.Exam_Id).FirstOrDefault();
        }
        #endregion

        private void button1_Click(object sender, EventArgs e)
        {
            GenerateExams(button1, 7, 3);
        }
        private void button2_Click(object sender, EventArgs e)
        {
            GenerateExams(button2, 6, 4);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            GenerateExams(button3, 5, 5);
        }

        private void button4_Click(object sender, EventArgs e)
        {
            GenerateExams(button4, 5, 5);
        }

        private void button5_Click(object sender, EventArgs e)
        {
            GenerateExams(button5, 5, 5);
        }
        private void button6_Click(object sender, EventArgs e)
        {
            Form3 form3 = new Form3();
            form3.Show();
            this.Hide();
        }
    }
}
