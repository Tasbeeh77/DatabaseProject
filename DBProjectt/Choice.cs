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
    
    public partial class Choice
    {
        public int Choisces_Id { get; set; }
        public int Ques_Id { get; set; }
        public string Choice1 { get; set; }
        public string Choice2 { get; set; }
        public string Choice3 { get; set; }
        public string Choice4 { get; set; }
    
        public virtual Question Question { get; set; }
    }
}
