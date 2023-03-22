/*****************Reports*************/
---------------One-------------------
create procedure GetSetudentByDepartment 
@Dept_Id int 
as
begin
select * from Student where Dept_Id = @Dept_Id
end 
--GetSetudentByDepartment  @Dept_Id = 10

-------------------Two-------------------
alter PROCEDURE GetStudentGrades
    @StudentID INT
AS
BEGIN
    SELECT cc.Crs_Name,  
         FLOOR((sc.Grade*0.01)*c.Mark) AS Grade_Percentage
    FROM Stud_Course AS sc
    JOIN Exam AS c ON sc.Crs_Id = c.Crs_Id
	JOIN Course AS cc ON cc.Crs_Id =sc.Crs_Id
    WHERE sc.St_Id = @StudentID
END
-- GetStudentGrades @StudentID = 1
 
-------------Three----------------
CREATE PROCEDURE GetInstructorCourses
    @InstructorID INT
AS
BEGIN
    SELECT c.Crs_Name, COUNT(sc.St_Id) AS NumberOfStudents
    FROM Course AS c
    JOIN Stud_Course AS sc ON c.Crs_Id = sc.Crs_Id
	join Ins_Course as v on v.Crs_Id= sc.Crs_Id
    WHERE v.Ins_Id = @InstructorID
    GROUP BY c.Crs_Name
END
--GetInstructorCourses @InstructorID = 106

----------Four-------------------
alter proc TopicReport
	@CourseID int
as
select   Crs_Id,Top_Name
from Topic
where Crs_Id = @CourseID
--TopicReport @CourseID = 5

-------------Five--------------
alter proc QuesExamChoiceReport
	@ExamNumber int
as
select q.Ques_Text, c.Choice1, c.Choice2, c.Choice3, c.Choice4
from Questions q, Choices c, Exam e, Crs_Exam_Ques ceq
where e.Exam_Id = ceq.Exam_Id
	and q.Ques_Id = ceq.Ques_Id
	and e.Exam_Id = @ExamNumber
	and q.Ques_Id = c.Ques_Id
--QuesExamChoiceReport @ExamNumber =1

----------------------------------------------
--ExamGeneration 3,9,3
-----------------Six----------------------
create proc StudExamQuesReport
	@ExamNumber int
	,@StudentID int
as
select q.Ques_Text , sqe.St_Answer
from Questions q, Exam e, St_Ques_Exam sqe
where q.Ques_Id = sqe.Ques_Id
	and e.Exam_id = sqe.Exam_Id
	and e.Exam_Id = @ExamNumber
	and sqe.St_Id = @StudentID
	StudExamQuesReport 1,2

--ST_Ques_Exam_insert 2,1,2,'Hypertext Markup Language'

