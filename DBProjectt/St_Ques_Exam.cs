//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DBProjectt
{
    using System;
    using System.Collections.Generic;
    
    public partial class St_Ques_Exam
    {
        public int Exam_Id { get; set; }
        public int Ques_Id { get; set; }
        public int St_Id { get; set; }
        public string St_Answer { get; set; }
    
        public virtual Student Student { get; set; }
    }
}
