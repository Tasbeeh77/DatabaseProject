/***************************** Department ******************************/
CREATE TABLE [dbo].[Department](
	[Dept_Id] [int] PRIMARY KEY ,
	[Dept_Name] [nvarchar](50) NULL,
	[Dept_Desc] [nvarchar](100) NULL,
	[Dept_Location] [nvarchar](50) NULL,
	[Dept_Manager] [int] NULL,
	[Manager_hiredate] [date] NULL,)
	
Alter Table [dbo].[Department]  WITH Check ADD  CONSTRAINT C9 FOREIGN KEY([Dept_Manager])
REFERENCES [dbo].[Instructor] ([Ins_Id])

/***************************** STUDENT *********************************/
CREATE TABLE [dbo].[Student](
	[St_Id] [int] Primary key Identity(1,1),
	[St_Fname] [nvarchar](50) NOT NULL,
	[St_Lname] [nvarchar](50) NOT NULL,
	[St_UserName] [nvarchar](50) NOT NULL,
	[St_Password] [nvarchar](20) NOT NULL,
	[St_Phone] [nvarchar](20)  NULL,
	[St_Address] [nvarchar](100) NULL Default 'Alex',
	[St_Age] [int] NULL,
	[St_JoinDate] [Date] NULL Default getDate(),
	[Dept_Id] [int] NULL,
	CONSTRAINT C1 Foreign Key (Dept_Id)
	References Department(Dept_Id) 
	ON Update Cascade ON Delete set NULL
)

/***************************** Instructor ******************************/
CREATE TABLE [dbo].[Instructor](
	[Ins_Id] [int]  PRIMARY KEY,
	[Ins_Name] [nvarchar](50) NULL,
	[Ins_Degree] [nvarchar](50) NULL,
	[Salary] [money] NULL,
	[Dept_Id] [int] NULL,
 CONSTRAINT C2 Foreign Key (Dept_Id)
 References Department(Dept_Id) 
 ON Update Cascade ON Delete set NULL
)

/****************************Course************************************/
CREATE TABLE [dbo].[Course](
	[Crs_Id] [int] PRIMARY KEY,
	[Crs_Name] [nvarchar](50) NULL,
	[Crs_Duration] [int] NULL,
	)

/****************************Std_Crs**********************************/	
CREATE TABLE [dbo].[Stud_Course](
	[Crs_Id] [int] NOT NULL,
	[St_Id] [int] NOT NULL,
	[St_Evalution] [nvarchar](50) NULL,
	Constraint C3 PRIMARY KEY (Crs_Id,St_Id),
	Constraint C4 FOREIGN KEY (Crs_Id) REFERENCES Course (Crs_Id),
	Constraint C5 FOREIGN KEY (St_Id) REFERENCES Student (St_Id)
	)
Alter Table [dbo].[Student]  WITH CHECK ADD  CONSTRAINT C10 FOREIGN KEY([St_Id])
REFERENCES [dbo].[Student] ([St_Id])

/****************************Ins_Crs*********************************/	
CREATE TABLE [dbo].[Ins_Course](
	[Crs_Id] [int] NOT NULL,
	[Ins_Id] [int] NOT NULL,
	[Ins_Evalution] [nvarchar](50) NULL,
	Constraint C6 PRIMARY KEY (Crs_Id,Ins_Id),
	Constraint C7 FOREIGN KEY (Crs_Id) REFERENCES Course (Crs_Id),
	Constraint C8 FOREIGN KEY (Ins_Id) REFERENCES Instructor (Ins_Id)
	)

/****************************Questions******************************/	
	USE[OES]
	create table Questions(
	Ques_Id int identity(1,1) primary key,
	Ques_Text varchar(255),
	Ques_Type varchar(50)
);
ALTER TABLE Questions ADD Crs_Id [int];
ALTER TABLE Questions ADD Constraint C15 FOREIGN KEY (Crs_Id) REFERENCES Course (Crs_Id);
ALTER TABLE Questions ADD Points [int];
ALTER TABLE Questions ADD Correct_Answer [nvarchar](50);

/****************************Choices******************************/	
create table Choices(
	Choice_Id int identity(1,1) primary key,
	Choice_Text varchar(255),
	Ques_Id int foreign key references Questions(Ques_Id)
);

/****************************Exam********************************/	
CREATE TABLE [dbo].[Exam](
    [Exam_Id] [int] PRIMARY KEY Identity(1,1),
	[Crs_Id] [int] NOT NULL,
	[Duration] [nvarchar](20) NULL,
	[Mark] [int] NULL,
	Constraint C14 FOREIGN KEY (Crs_Id) REFERENCES Course (Crs_Id)
	)

/****************************St_Exam******************************/	
CREATE TABLE [dbo].[St_Crs_Exam](
    [Exam_Id] [int] NOT NULL,
	[Ques_Id] [int] NOT NULL,
	[St_Id] [int] NOT NULL,
	[St_Answer] [nvarchar](30) NULL,
	Constraint C16 PRIMARY KEY (Exam_Id,Ques_Id,St_Id),
	)
ALTER TABLE St_Crs_Exam ADD CONSTRAINT C17 FOREIGN KEY (Ques_Id) REFERENCES Questions (Ques_Id)
ALTER TABLE St_Crs_Exam ADD CONSTRAINT C18 FOREIGN KEY (Exam_Id) REFERENCES Exam (Exam_Id)
ALTER TABLE St_Crs_Exam ADD CONSTRAINT C19 FOREIGN KEY (St_Id) REFERENCES Student (St_Id)


/*******************************************INSERT**************************************************************/

                                        /***STUDENT***/
USE [OES]
INSERT INTO Student ( St_Fname, St_Lname , Dept_Id ,St_Phone , St_UserName , St_Password , St_Address , St_Age , St_JoinDate )
VALUES ('Nada' , 'Bassiouny' , 10 , '+201018394746' , 'Nada_B' , 'ITI_1234' , 'Tanta' , 23 , '2022-10-9');

INSERT INTO Student ( St_Fname, St_Lname , Dept_Id ,St_Phone , St_UserName , St_Password , St_Address , St_Age , St_JoinDate )
VALUES ('Tasbeeh' , 'Gamal' , 10 , '+201226494742' , 'Tasbeeh_G' , 'ITI_7777' , 'Alex' , 23 , '2022-10-9');

INSERT INTO Student ( St_Fname, St_Lname , Dept_Id ,St_Phone , St_UserName , St_Password , St_Address , St_Age , St_JoinDate )
VALUES ('Mennatallah' , 'Elsayed' , 10 , '+201975494742' , 'Menna_E' , 'ITI_6565' , 'Alex' , 24 , '2022-10-9');

SET IDENTITY_INSERT Student ON

INSERT INTO Student (St_Id, St_Fname, St_Lname , Dept_Id ,St_Phone , St_UserName , St_Password , St_Address , St_Age , St_JoinDate )
VALUES (1,'Jessica' , 'Safwat' , 10 , '+201540194742' , 'Jessica_S' , 'ITI_2792' , 'Alex' , 24 , '2022-10-9');

INSERT INTO Student (St_Id, St_Fname, St_Lname , Dept_Id ,St_Phone , St_UserName , St_Password , St_Address , St_Age , St_JoinDate )
VALUES (2,'Reem' , 'Samy' , 10 , '+201540194742' , 'Reem_S' , 'ITI_4321' , 'Tanta' , 23 , '2022-10-9');

INSERT INTO Student (St_Id, St_Fname, St_Lname , Dept_Id ,St_Phone , St_UserName , St_Password , St_Address , St_Age , St_JoinDate )
VALUES (6,'Claudine' , 'Bahgat' , 10 , '+201277264305' , 'Claudine_B' , 'ITI_5656' , 'Alex' , 23 , '2022-10-9');

SET IDENTITY_INSERT Student OFF

/*****************************************************************************************************************/
                                             /***DEPARTMENT***/

INSERT INTO Department(Dept_Id, Dept_Name, Dept_Desc , Dept_Location )
VALUES (20,'UX/UI' , 'UX & UI Design' , 'Cairo');

INSERT INTO Department(Dept_Id, Dept_Name, Dept_Desc , Dept_Location )
VALUES (30 ,'Open Source' , 'Linux Open Souce' , 'Alex');

INSERT INTO Department(Dept_Id, Dept_Name, Dept_Desc , Dept_Location )
VALUES (40,'DB' , 'Data Base ' , 'Alex');



/***************************************************************************************************************/
                                 /***INSTRUCTOR***/

INSERT INTO Instructor(Ins_Id, Ins_Name, Dept_Id , Ins_Degree , Salary )
VALUES (100,'Ghada Qadous' , 10 , 'Manager', 12000);

INSERT INTO Instructor(Ins_Id, Ins_Name, Dept_Id , Ins_Degree , Salary )
VALUES (101,'Mahmoud Ouf' , 10 , 'Head', 15000);

INSERT INTO Instructor(Ins_Id, Ins_Name, Dept_Id , Ins_Degree , Salary )
VALUES (102,'Marwa Ibrahim' , 20 , 'Manager', 12000);

INSERT INTO Instructor(Ins_Id, Ins_Name, Dept_Id , Ins_Degree , Salary )
VALUES (103,'Noha salah' , 30 , 'Manager', 12000);

INSERT INTO Instructor(Ins_Id, Ins_Name, Dept_Id , Ins_Degree , Salary )
VALUES (104,'Noha Amer' , 40 , 'Manager', 12000);

INSERT INTO Instructor(Ins_Id, Ins_Name, Dept_Id , Ins_Degree , Salary )
VALUES (105,'Iman Bendary' , 10 , 'Specialist', 10000);

INSERT INTO Instructor(Ins_Id, Ins_Name, Dept_Id , Ins_Degree , Salary )
VALUES (106,'Rami Nagi' , 10 , 'Specialist', 12000);

INSERT INTO Instructor(Ins_Id, Ins_Name, Dept_Id , Ins_Degree , Salary )
VALUES (107,'Rehab Farouq' , 10 , 'Specialist', 12000);

INSERT INTO Instructor(Ins_Id, Ins_Name, Dept_Id , Ins_Degree , Salary )
VALUES (108,'Sara Ahmed' , 10 , 'Specialist', 10000);

/*************************************************************************************************************/
                                  /***COURSE***/
INSERT INTO Course(Crs_Id, Crs_Name, Crs_Duration )
VALUES (1,'C#' , 12 );

INSERT INTO Course(Crs_Id, Crs_Name, Crs_Duration )
VALUES (2,'Sql Server' , 6);

INSERT INTO Course(Crs_Id, Crs_Name, Crs_Duration )
VALUES (3,'Html5' , 3 );

INSERT INTO Course(Crs_Id, Crs_Name, Crs_Duration )
VALUES (4,'CSS3' , 3 );

INSERT INTO Course(Crs_Id, Crs_Name, Crs_Duration )
VALUES (6,'DB' , 4);

INSERT INTO Course(Crs_Id, Crs_Name, Crs_Duration )
VALUES (5,'SW' , 8);

INSERT INTO Course(Crs_Id, Crs_Name, Crs_Duration )
VALUES (7,'Soft Skills' , 6);

INSERT INTO Course(Crs_Id, Crs_Name, Crs_Duration )
VALUES (8,'English' , 33);

INSERT INTO Course(Crs_Id, Crs_Name, Crs_Duration )
VALUES (9,'Adobe Illustrator' , 9);



/*************************************************************************************************************/
                                   /***INS_COURSE***/
INSERT INTO Ins_Course(Crs_Id, Ins_Id )
VALUES (1,101);
INSERT INTO Ins_Course(Crs_Id, Ins_Id )
VALUES (2,106);
INSERT INTO Ins_Course(Crs_Id, Ins_Id )
VALUES (3,107);
INSERT INTO Ins_Course(Crs_Id, Ins_Id )
VALUES (4,107);
INSERT INTO Ins_Course(Crs_Id, Ins_Id )
VALUES (5,100);
INSERT INTO Ins_Course(Crs_Id, Ins_Id )
VALUES (7,105);
INSERT INTO Ins_Course(Crs_Id, Ins_Id )
VALUES (8,108);
INSERT INTO Ins_Course(Crs_Id, Ins_Id )
VALUES (6,104);
INSERT INTO Ins_Course(Crs_Id, Ins_Id )
VALUES (9,102);

/************************************************************************************************************/
                                /***ST_COURSE***/
ALTER TABLE Stud_Course
DROP COLUMN St_Evalution;

ALTER TABLE Stud_Course
ADD [Grade] [nvarchar](20);

INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (1,1 ,'good');
INSERT INTO Stud_Course(St_Id, Crs_Id, St_Evalution )
VALUES (1,2,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (1,3,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (1,4,'Excellent');

INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (2,1 ,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (2,2,' very good');
INSERT INTO Stud_Course(St_Id, Crs_Id, St_Evalution )
VALUES (2,3,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (2,4,'very good');

INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (3,1 ,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (3,2,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id, St_Evalution )
VALUES (3,3,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (3,4,' good');

INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (4,1 ,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (4,2,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id, St_Evalution )
VALUES (4,3,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (4,4,'very good');

INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (5,1 ,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (5,2,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id, St_Evalution )
VALUES (5,3,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (5,4,'very good');

INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (6,1 ,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (6,2,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id, St_Evalution )
VALUES (6,3,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (6,4,'Excellent');

INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (1,5 ,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (2,5,'Excellent');
INSERT INTO Stud_Course(St_Id, Crs_Id, St_Evalution )
VALUES (3,5,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (4,5,'Excellent');

INSERT INTO Stud_Course(St_Id, Crs_Id, St_Evalution )
VALUES (6,5,'very good');
INSERT INTO Stud_Course(St_Id, Crs_Id , St_Evalution)
VALUES (5,5,'Excellent');

/*****************************************************************************************************/
                                      /***EXAM***/
INSERT INTO Exam(Crs_Id,Duration,Mark)
VALUES ( 1 , '2H' , 60 );

INSERT INTO Exam(Crs_Id,Duration,Mark)
VALUES ( 2 , '2H' , 60 );

INSERT INTO Exam(Crs_Id,Duration,Mark)
VALUES ( 3, '2H' , 60 );

INSERT INTO Exam(Crs_Id,Duration,Mark)
VALUES ( 4 , '2H' , 60 );

INSERT INTO Exam(Crs_Id,Duration,Mark)
VALUES ( 5 , '2H' , 60 );

/*****************************************************************************************************/
/******** HTML Questions ********/
USE [OES]
insert into Questions (Ques_Text, Ques_Type) values ('What does the abbreviation HTML stand for?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('What is the smallest header in HTML by default?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which tag do we use in HTML for inserting a line-break?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('In HTML, the tags are', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('What is the correct way in which we can start an ordered list that has the numeric value count of 5 in HTML?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Comments are visible on the browsers window in HTML.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('<h1> tag is used to specify heading in a document in HTML.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('<p> tag in HTML is used to give headings in the web page.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('The "div" tag defines a division or a section in an HTML document.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Each choice in HTML in a checkbox list can be either on or off.', 'T/F');

/******** CSS Questions ********/
insert into Questions (Ques_Text, Ques_Type) values ('The HTML attribute used to define the internal stylesheet is', 'MCQ'); 
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following property is used as the shorthand property for the padding properties?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following syntax is correct in CSS to make each word of a sentence start with a capital letter?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following is the correct syntax to select the p siblings of a div element?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('The CSS property used to make the rounded borders, or rounded corners around an element is', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following selector in CSS is used to select the elements that do not match the selectors?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following CSS property is used to represent the overflowed text which is not visible to the user?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('The correct syntax to give a line over text is', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('The CSS property which is used to set the text wider or narrower compare to the default width of the font is', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which if the following CSS function allows us to perform calculations?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('The link element should be placed at the top of the body section in HTML.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Specifying an element position as absolute removes it from the normal flow of elements on the page.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('To specify the boldness of text, use the font-boldness property.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('The CSS property which is used to define the set the difference between two lines of your content is min-height property.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('The span element is a block-level element.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('The CSS property used to specify the transparency of an element is Hover.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('The CSS property used to specify the order of flex item in the grid container is order property.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('The negative values are allowed in padding property.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('To display the hyperlinks without any underline a {text-decoration : underline;}.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('The CSS property used to set the background image of an element is background-attachment.', 'T/F');

UPDATE Questions SET Points = 6
WHERE Ques_Id BETWEEN 1 AND 80;

UPDATE Questions SET Crs_Id = 3
WHERE Ques_Id BETWEEN 1 AND 10;

UPDATE Questions SET Crs_Id = 4
WHERE Ques_Id BETWEEN 11 AND 30;

UPDATE Questions SET Crs_Id = 1
WHERE Ques_Id BETWEEN 31 AND 54;

UPDATE Questions SET Crs_Id = 2
WHERE Ques_Id BETWEEN 55 AND 68;

UPDATE Questions SET Crs_Id = 5
WHERE Ques_Id BETWEEN 69 AND 80;

/******** C# Questions ********/
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following operator represents a conditional operation in C#?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following method copies the reference to the memory location of an argument into the formal parameter?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following is correct about params in C#?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following is true about catch block in C#?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('How many Bytes are stored by ‘Long’ Data type in C# .net?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('C# runs on the', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('C# programming language is used to develop', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which is the correct order for explicit type conversion to convert a larger to a smaller type in C#?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('What is the difference between Console.Write() and Console.WriteLine() methods in C#?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which is the correct for() statement to run an infinite loop?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which of the correct syntax to declare an array with 2 rows and 3 columns in C#?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which is not a type of constructor in C#?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('We can use reserved keywords as identifiers in C#.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Function overloading is a kind of static polymorphism.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('C++ an alias of C#.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('We can obtain the array index using foreach loop in C#.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('C# break keyword is used to come out from the loop.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('ToUpper() is the correct method to convert given string in uppercase.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('String.Length in C# is a property.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('MaxLen is  an array property used to get the total number of elements in C#.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Polymorphism is a C# concept that has the capability of an object to take number of different forms and hence display behavior as accordingly.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('In C#, by default, the default interface methods are virtual.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Abstract class does not have its own objects but acts as a base class for its subclass in C#.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Only one catch block can be used with a single try block in C#.', 'T/F');

/******** DB & SQL Questions ********/
insert into Questions (Ques_Text, Ques_Type) values ('Which type of data can be stored in the database?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('In which of the following formats data is stored in the database management system?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which SQL statement is used to extract data from a database?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Which of the following is a feature of DBMS?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('What is information about data called?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Procedural language among the following is', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Why the following statement is erroneous? SELECT dept_name, ID, avg (salary) FROM instructor GROUP BY dept_name;', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Atomicity ensures that all operations within the work unit are completed successfully.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('A column or a combination of columns which can be used to identify one or more rows (tuples) in a table is called a key of the table.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('A transaction is a unit of work that is performed against a database.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('The most popular type of DBMS today for PCs as well as for larger computers and mainframes is the hierarchical DBMS.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('In an entity-relationship diagram, boxes represent entities and diamonds represent relationships.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Political resistance is one challenge in changing the current DBMS or going into a new one.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('The presence of duplicate data in multiple data files is called program-data dependence.', 'T/F');

/******** Software Engineering Questions ********/
insert into Questions (Ques_Text, Ques_Type) values ('What is defined as the process of generating analysis and designing documents?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('The activity that distributes estimated effort across the planned project duration by allocating the effort to specific software developing tasks is ', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('What is an indirect measure of software development process.', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('In which step of SDLC actual programming of software code is done?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('What is a software development life cycle model that is chosen if the development team has less experience on similar projects?', 'MCQ');
insert into Questions (Ques_Text, Ques_Type) values ('Software safety is equivalent to software reliability.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Quality of design encompasses requirements and specifications of the system.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Agility is defined as the ability of a project team to respond rapidly to a change.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('In agile development it is more important to build software that meets the customers’ needs today than worry about features that might be needed in the future.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Programmers prefer programming to testing and sometimes they take shortcuts when writing tests. For example, they may write incomplete tests that do not check for all possible exceptions that may occur.', 'T/F');
insert into Questions (Ques_Text, Ques_Type) values ('Tests are automated in Extreme Programming.', 'T/F');

/** Correct Answers 
UPDATE Questions SET Correct_Answer = 'Hypertext Markup Language'
WHERE Ques_Id = 1;
UPDATE Questions SET Correct_Answer = 'c'
WHERE Ques_Id = 1;
UPDATE Questions SET Correct_Answer = 'b'
WHERE Ques_Id = 1;
UPDATE Questions SET Correct_Answer = 'd'
WHERE Ques_Id = 1;
UPDATE Questions SET Correct_Answer = 'a'
WHERE Ques_Id = 1; **/

/*************************************************************************************************************/
                                /** CHOICES **/
insert into Choices (Choice_Text, Ques_Id) values ('Hypertext Markup Language', 1);
insert into Choices (Choice_Text, Ques_Id) values ('High Text Markup Language', 1);
insert into Choices (Choice_Text, Ques_Id) values ('Hyper Text Markdown Language', 1);
insert into Choices (Choice_Text, Ques_Id) values ('None of the above', 1);

insert into Choices (Choice_Text, Ques_Id) values ('h1', 2);
insert into Choices (Choice_Text, Ques_Id) values ('h2', 2);
insert into Choices (Choice_Text, Ques_Id) values ('h6', 2);
insert into Choices (Choice_Text, Ques_Id) values ('h4', 2);

insert into Choices (Choice_Text, Ques_Id) values ('<a>', 3);
insert into Choices (Choice_Text, Ques_Id) values ('<br>', 3);
insert into Choices (Choice_Text, Ques_Id) values ('<b>', 3);
insert into Choices (Choice_Text, Ques_Id) values ('<pre>', 3);

insert into Choices (Choice_Text, Ques_Id) values ('in upper case', 4);
insert into Choices (Choice_Text, Ques_Id) values ('case-sensitive', 4);
insert into Choices (Choice_Text, Ques_Id) values ('in lowercase', 4);
insert into Choices (Choice_Text, Ques_Id) values ('not case sensitive', 4);

insert into Choices (Choice_Text, Ques_Id) values ('<ol type = “1” start = “5”>', 5);
insert into Choices (Choice_Text, Ques_Id) values ('<ol type = “1” num = “5”>', 5);
insert into Choices (Choice_Text, Ques_Id) values ('<ol type = “1” begin = “5”>', 5);
insert into Choices (Choice_Text, Ques_Id) values ('<ol type = “1” initial = “5”>', 5);

insert into Choices (Choice_Text, Ques_Id) values ('True', 6);
insert into Choices (Choice_Text, Ques_Id) values ('False', 6);

insert into Choices (Choice_Text, Ques_Id) values ('True', 7);
insert into Choices (Choice_Text, Ques_Id) values ('False', 7);

insert into Choices (Choice_Text, Ques_Id) values ('True', 8);
insert into Choices (Choice_Text, Ques_Id) values ('False', 8);

insert into Choices (Choice_Text, Ques_Id) values ('True', 9);
insert into Choices (Choice_Text, Ques_Id) values ('False', 9);

insert into Choices (Choice_Text, Ques_Id) values ('True', 10);
insert into Choices (Choice_Text, Ques_Id) values ('False', 10);

insert into Choices (Choice_Text, Ques_Id) values ('<style>', 11);
insert into Choices (Choice_Text, Ques_Id) values ('style', 11);
insert into Choices (Choice_Text, Ques_Id) values ('<link>', 11);
insert into Choices (Choice_Text, Ques_Id) values ('<script>', 11);

insert into Choices (Choice_Text, Ques_Id) values ('padding-left', 12);
insert into Choices (Choice_Text, Ques_Id) values ('padding-right', 12);
insert into Choices (Choice_Text, Ques_Id) values ('padding', 12);
insert into Choices (Choice_Text, Ques_Id) values ('all of the above', 12);

insert into Choices (Choice_Text, Ques_Id) values ('text-style: capital;', 13);
insert into Choices (Choice_Text, Ques_Id) values ('transform: capitalize;', 13);
insert into Choices (Choice_Text, Ques_Id) values ('text-transform: capital;', 13);
insert into Choices (Choice_Text, Ques_Id) values ('text-transform: capitalize;', 13);

insert into Choices (Choice_Text, Ques_Id) values ('p', 14);
insert into Choices (Choice_Text, Ques_Id) values ('div+p;', 14);
insert into Choices (Choice_Text, Ques_Id) values ('div p', 14);
insert into Choices (Choice_Text, Ques_Id) values ('div~p', 14);

insert into Choices (Choice_Text, Ques_Id) values ('border-collapse', 15);
insert into Choices (Choice_Text, Ques_Id) values ('border-radius', 15);
insert into Choices (Choice_Text, Ques_Id) values ('border-spacing', 15);
insert into Choices (Choice_Text, Ques_Id) values ('none of the above', 15);

insert into Choices (Choice_Text, Ques_Id) values (':! selector', 16);
insert into Choices (Choice_Text, Ques_Id) values (':not selector', 16);
insert into Choices (Choice_Text, Ques_Id) values (':empty selector', 16);
insert into Choices (Choice_Text, Ques_Id) values ('none of the above', 16);

insert into Choices (Choice_Text, Ques_Id) values ('text-shadow', 17);
insert into Choices (Choice_Text, Ques_Id) values ('text-stroke', 17);
insert into Choices (Choice_Text, Ques_Id) values ('text-overflow', 17);
insert into Choices (Choice_Text, Ques_Id) values ('text-decoration', 17);

insert into Choices (Choice_Text, Ques_Id) values ('text-decoration: line-through', 18);
insert into Choices (Choice_Text, Ques_Id) values ('text-decoration: none', 18);
insert into Choices (Choice_Text, Ques_Id) values ('text-decoration: overline', 18);
insert into Choices (Choice_Text, Ques_Id) values ('text-decoration: underline', 18);

insert into Choices (Choice_Text, Ques_Id) values ('font-stretch property', 19);
insert into Choices (Choice_Text, Ques_Id) values ('font-weight property', 19);
insert into Choices (Choice_Text, Ques_Id) values ('font-transform property', 19);
insert into Choices (Choice_Text, Ques_Id) values ('font-variant property', 19);

insert into Choices (Choice_Text, Ques_Id) values ('calc() function', 20);
insert into Choices (Choice_Text, Ques_Id) values ('calculator() function', 20);
insert into Choices (Choice_Text, Ques_Id) values ('calculate() function', 20);
insert into Choices (Choice_Text, Ques_Id) values ('cal() function', 20);

insert into Choices (Choice_Text, Ques_Id) values ('True', 21);
insert into Choices (Choice_Text, Ques_Id) values ('False', 21);

insert into Choices (Choice_Text, Ques_Id) values ('True', 22);
insert into Choices (Choice_Text, Ques_Id) values ('False', 22);

insert into Choices (Choice_Text, Ques_Id) values ('True', 23);
insert into Choices (Choice_Text, Ques_Id) values ('False', 23);

insert into Choices (Choice_Text, Ques_Id) values ('True', 24);
insert into Choices (Choice_Text, Ques_Id) values ('False', 24);

insert into Choices (Choice_Text, Ques_Id) values ('True', 25);
insert into Choices (Choice_Text, Ques_Id) values ('False', 25);

insert into Choices (Choice_Text, Ques_Id) values ('True', 26);
insert into Choices (Choice_Text, Ques_Id) values ('False', 26);

insert into Choices (Choice_Text, Ques_Id) values ('True', 27);
insert into Choices (Choice_Text, Ques_Id) values ('False', 27);

insert into Choices (Choice_Text, Ques_Id) values ('True', 28);
insert into Choices (Choice_Text, Ques_Id) values ('False', 28);

insert into Choices (Choice_Text, Ques_Id) values ('True', 29);
insert into Choices (Choice_Text, Ques_Id) values ('False', 29);

insert into Choices (Choice_Text, Ques_Id) values ('True', 30);
insert into Choices (Choice_Text, Ques_Id) values ('False', 30);

insert into Choices (Choice_Text, Ques_Id) values ('?:', 31);
insert into Choices (Choice_Text, Ques_Id) values ('is', 31);
insert into Choices (Choice_Text, Ques_Id) values ('as', 31);
insert into Choices (Choice_Text, Ques_Id) values ('*', 31);

insert into Choices (Choice_Text, Ques_Id) values ('Value parameters', 32);
insert into Choices (Choice_Text, Ques_Id) values ('Reference parameters', 32);
insert into Choices (Choice_Text, Ques_Id) values ('Output parameters', 32);
insert into Choices (Choice_Text, Ques_Id) values ('None of the above', 32);

insert into Choices (Choice_Text, Ques_Id) values ('By using the params keyword, a method parameter can be specified which takes a variable number of arguments or even no argument.', 33);
insert into Choices (Choice_Text, Ques_Id) values ('Additional parameters are not permitted after the params keyword in a method declaration.', 33);
insert into Choices (Choice_Text, Ques_Id) values ('Only one params keyword is allowed in a method declaration.', 33);
insert into Choices (Choice_Text, Ques_Id) values ('All of the above', 33);

insert into Choices (Choice_Text, Ques_Id) values ('A program catches an exception with an exception handler at the place in a program where you want to handle the problem.', 34);
insert into Choices (Choice_Text, Ques_Id) values ('The catch keyword indicates the catching of an exception.', 34);
insert into Choices (Choice_Text, Ques_Id) values ('Both of the above', 34);
insert into Choices (Choice_Text, Ques_Id) values ('None of the above', 34);

insert into Choices (Choice_Text, Ques_Id) values ('8', 35);
insert into Choices (Choice_Text, Ques_Id) values ('4', 35);
insert into Choices (Choice_Text, Ques_Id) values ('2', 35);
insert into Choices (Choice_Text, Ques_Id) values ('1', 35);

insert into Choices (Choice_Text, Ques_Id) values ('.NET Framework', 36);
insert into Choices (Choice_Text, Ques_Id) values ('Java Virtual Machine', 36);
insert into Choices (Choice_Text, Ques_Id) values ('Both of the above', 36);
insert into Choices (Choice_Text, Ques_Id) values ('None of the above', 36);

insert into Choices (Choice_Text, Ques_Id) values ('Web apps', 37);
insert into Choices (Choice_Text, Ques_Id) values ('Desktop apps', 37);
insert into Choices (Choice_Text, Ques_Id) values ('Mobiles apps', 37);
insert into Choices (Choice_Text, Ques_Id) values ('All of the above', 37);

insert into Choices (Choice_Text, Ques_Id) values ('double -> float -> long -> int -> char -> bool', 38);
insert into Choices (Choice_Text, Ques_Id) values ('double -> float -> long -> int -> char', 38);
insert into Choices (Choice_Text, Ques_Id) values ('float -> double -> long -> int -> char', 38);
insert into Choices (Choice_Text, Ques_Id) values ('float -> double -> long -> int -> char -> bool', 38);

insert into Choices (Choice_Text, Ques_Id) values ('Write() writes a single character while Console.WriteLine() writes a complete line', 39);
insert into Choices (Choice_Text, Ques_Id) values ('Write() writes the data on the console without printing a newline while Console.WriteLine() writes the data on the console along with printing a newline', 39);
insert into Choices (Choice_Text, Ques_Id) values ('Write() writes the string on the console while Console.WriteLine() writes the string as well as values of the variables on the console', 39);
insert into Choices (Choice_Text, Ques_Id) values ('Both can be used for the same purpose', 39);

insert into Choices (Choice_Text, Ques_Id) values ('for(;;)', 40);
insert into Choices (Choice_Text, Ques_Id) values ('for(;;);', 40);
insert into Choices (Choice_Text, Ques_Id) values ('for(::)', 40);
insert into Choices (Choice_Text, Ques_Id) values ('for(1;1;1)', 40);

insert into Choices (Choice_Text, Ques_Id) values ('int arr[2][3] = new int[2][3];', 41);
insert into Choices (Choice_Text, Ques_Id) values ('int arr[2,3] = new int[2,3];', 41);
insert into Choices (Choice_Text, Ques_Id) values ('int [,] arr = new int[2,3];', 41);
insert into Choices (Choice_Text, Ques_Id) values ('int [,] arr = new [2,3]int;', 41);

insert into Choices (Choice_Text, Ques_Id) values ('Static Constructor', 42);
insert into Choices (Choice_Text, Ques_Id) values ('Private Constructor', 42);
insert into Choices (Choice_Text, Ques_Id) values ('Body Constructor', 42);
insert into Choices (Choice_Text, Ques_Id) values ('Parameterized Constructor', 42);

insert into Choices (Choice_Text, Ques_Id) values ('True', 43);
insert into Choices (Choice_Text, Ques_Id) values ('False', 43);

insert into Choices (Choice_Text, Ques_Id) values ('True', 44);
insert into Choices (Choice_Text, Ques_Id) values ('False', 44);

insert into Choices (Choice_Text, Ques_Id) values ('True', 45);
insert into Choices (Choice_Text, Ques_Id) values ('False', 45);

insert into Choices (Choice_Text, Ques_Id) values ('True', 46);
insert into Choices (Choice_Text, Ques_Id) values ('False', 46);

insert into Choices (Choice_Text, Ques_Id) values ('True', 47);
insert into Choices (Choice_Text, Ques_Id) values ('False', 47);

insert into Choices (Choice_Text, Ques_Id) values ('True', 48);
insert into Choices (Choice_Text, Ques_Id) values ('False', 48);

insert into Choices (Choice_Text, Ques_Id) values ('True', 49);
insert into Choices (Choice_Text, Ques_Id) values ('False', 49);

insert into Choices (Choice_Text, Ques_Id) values ('True', 50);
insert into Choices (Choice_Text, Ques_Id) values ('False', 50);

insert into Choices (Choice_Text, Ques_Id) values ('True', 51);
insert into Choices (Choice_Text, Ques_Id) values ('False', 51);

insert into Choices (Choice_Text, Ques_Id) values ('True', 52);
insert into Choices (Choice_Text, Ques_Id) values ('False', 52);

insert into Choices (Choice_Text, Ques_Id) values ('True', 53);
insert into Choices (Choice_Text, Ques_Id) values ('False', 53);

insert into Choices (Choice_Text, Ques_Id) values ('True', 54);
insert into Choices (Choice_Text, Ques_Id) values ('False', 54);

insert into Choices (Choice_Text, Ques_Id) values ('Image oriented data', 55);
insert into Choices (Choice_Text, Ques_Id) values ('Text, files containing data', 55);
insert into Choices (Choice_Text, Ques_Id) values ('Data in the form of audio or video', 55);
insert into Choices (Choice_Text, Ques_Id) values ('All of the above', 55);

insert into Choices (Choice_Text, Ques_Id) values ('Image', 56);
insert into Choices (Choice_Text, Ques_Id) values ('Text', 56);
insert into Choices (Choice_Text, Ques_Id) values ('Table', 56);
insert into Choices (Choice_Text, Ques_Id) values ('Graph', 56);

insert into Choices (Choice_Text, Ques_Id) values ('SELECT', 57);
insert into Choices (Choice_Text, Ques_Id) values ('EXTRACT', 57);
insert into Choices (Choice_Text, Ques_Id) values ('OPEN', 57);
insert into Choices (Choice_Text, Ques_Id) values ('GET', 57);

insert into Choices (Choice_Text, Ques_Id) values ('Minimum Duplication and Redundancy of Data', 58);
insert into Choices (Choice_Text, Ques_Id) values ('High Level of Security', 58);
insert into Choices (Choice_Text, Ques_Id) values ('Single-user Access only', 58);
insert into Choices (Choice_Text, Ques_Id) values ('Support ACID Property', 58);

insert into Choices (Choice_Text, Ques_Id) values ('Hyper data', 59);
insert into Choices (Choice_Text, Ques_Id) values ('Tera data', 59);
insert into Choices (Choice_Text, Ques_Id) values ('Meta data', 59);
insert into Choices (Choice_Text, Ques_Id) values ('Relations', 59);

insert into Choices (Choice_Text, Ques_Id) values ('Domain relational calculus', 60);
insert into Choices (Choice_Text, Ques_Id) values ('Tuple relational calculus', 60);
insert into Choices (Choice_Text, Ques_Id) values ('Relational algebra', 60);
insert into Choices (Choice_Text, Ques_Id) values ('Query language', 60);

insert into Choices (Choice_Text, Ques_Id) values ('Dept_id should not be used in group by clause', 61);
insert into Choices (Choice_Text, Ques_Id) values ('Group by clause is not valid in this query', 61);
insert into Choices (Choice_Text, Ques_Id) values ('Avg(salary) should not be selected', 61);
insert into Choices (Choice_Text, Ques_Id) values ('None', 61);

insert into Choices (Choice_Text, Ques_Id) values ('True', 62);
insert into Choices (Choice_Text, Ques_Id) values ('False', 62);

insert into Choices (Choice_Text, Ques_Id) values ('True', 63);
insert into Choices (Choice_Text, Ques_Id) values ('False', 63);

insert into Choices (Choice_Text, Ques_Id) values ('True', 64);
insert into Choices (Choice_Text, Ques_Id) values ('False', 64);

insert into Choices (Choice_Text, Ques_Id) values ('True', 65);
insert into Choices (Choice_Text, Ques_Id) values ('False', 65);

insert into Choices (Choice_Text, Ques_Id) values ('True', 66);
insert into Choices (Choice_Text, Ques_Id) values ('False', 66);

insert into Choices (Choice_Text, Ques_Id) values ('True', 67);
insert into Choices (Choice_Text, Ques_Id) values ('False', 67);

insert into Choices (Choice_Text, Ques_Id) values ('True', 68);
insert into Choices (Choice_Text, Ques_Id) values ('False', 68);

insert into Choices (Choice_Text, Ques_Id) values ('Re-engineering', 69);
insert into Choices (Choice_Text, Ques_Id) values ('b.	Reverse engineering', 69);
insert into Choices (Choice_Text, Ques_Id) values ('c.	Software re-engineering', 69);
insert into Choices (Choice_Text, Ques_Id) values ('d.	Science and engineering ', 69);

insert into Choices (Choice_Text, Ques_Id) values ('a.	Project scheduling', 70);
insert into Choices (Choice_Text, Ques_Id) values ('b.	Detailed schedule', 70);
insert into Choices (Choice_Text, Ques_Id) values ('c.	Macroscopic schedule', 70);
insert into Choices (Choice_Text, Ques_Id) values ('d.	None of the mentioned', 70);

insert into Choices (Choice_Text, Ques_Id) values ('Cost', 71);
insert into Choices (Choice_Text, Ques_Id) values ('Effort applied', 71);
insert into Choices (Choice_Text, Ques_Id) values ('Efficiency', 71);
insert into Choices (Choice_Text, Ques_Id) values ('All of the above', 71);

insert into Choices (Choice_Text, Ques_Id) values ('Development and Documentation', 72);
insert into Choices (Choice_Text, Ques_Id) values ('Maintenance and Evaluation', 72);
insert into Choices (Choice_Text, Ques_Id) values ('Design', 72);
insert into Choices (Choice_Text, Ques_Id) values ('Analysis', 72);

insert into Choices (Choice_Text, Ques_Id) values ('Iterative Enhancement Model', 73);
insert into Choices (Choice_Text, Ques_Id) values ('RAD', 73);
insert into Choices (Choice_Text, Ques_Id) values ('Spiral', 73);
insert into Choices (Choice_Text, Ques_Id) values ('Waterfall', 73);

insert into Choices (Choice_Text, Ques_Id) values ('True', 74);
insert into Choices (Choice_Text, Ques_Id) values ('False', 74);

insert into Choices (Choice_Text, Ques_Id) values ('True', 75);
insert into Choices (Choice_Text, Ques_Id) values ('False', 75);

insert into Choices (Choice_Text, Ques_Id) values ('True', 76);
insert into Choices (Choice_Text, Ques_Id) values ('False', 76);

insert into Choices (Choice_Text, Ques_Id) values ('True', 77);
insert into Choices (Choice_Text, Ques_Id) values ('False', 77);

insert into Choices (Choice_Text, Ques_Id) values ('True', 78);
insert into Choices (Choice_Text, Ques_Id) values ('False', 78);

insert into Choices (Choice_Text, Ques_Id) values ('True', 79);
insert into Choices (Choice_Text, Ques_Id) values ('False', 79);

