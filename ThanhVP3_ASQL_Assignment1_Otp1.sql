Create database ASQL_Assignment1_Otp1
Go
Use ASQL_Assignment1_Otp1
Go

-- Create table Employee, Status = 1: are working
CREATE TABLE [dbo].[Employee](
	[EmpNo] [int] NOT NULL
,	[EmpName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[BirthDay] [datetime] NOT NULL
,	[DeptNo] [int] NOT NULL
, 	[MgrNo] [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[StartDate] [datetime] NOT NULL
,	[Salary] [money] NOT NULL
,	[Status] [int] NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
,	[Level] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE Employee 
ADD CONSTRAINT PK_Emp PRIMARY KEY (EmpNo)
GO

ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Level] 
	CHECK  (([Level]=(7) OR [Level]=(6) OR [Level]=(5) OR [Level]=(4) OR [Level]=(3) OR [Level]=(2) OR [Level]=(1)))
GO
ALTER TABLE [dbo].[Employee]  
ADD  CONSTRAINT [chk_Status] 
	CHECK  (([Status]=(2) OR [Status]=(1) OR [Status]=(0)))

GO
ALTER TABLE [dbo].[Employee]
ADD Email NCHAR(30) 
GO

ALTER TABLE [dbo].[Employee]
ADD CONSTRAINT chk_Email CHECK (Email IS NOT NULL)
GO

ALTER TABLE [dbo].[Employee] 
ADD CONSTRAINT chk_Email1 UNIQUE(Email)

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_EmpNo DEFAULT 0 FOR EmpNo

GO
ALTER TABLE Employee
ADD CONSTRAINT DF_Status DEFAULT 0 FOR Status

GO
CREATE TABLE [dbo].[Skill](
	[SkillNo] [int] IDENTITY(1,1) NOT NULL
,	[SkillName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Skill
ADD CONSTRAINT PK_Skill PRIMARY KEY (SkillNo)

GO
CREATE TABLE [dbo].[Department](
	[DeptNo] [int] IDENTITY(1,1) NOT NULL
,	[DeptName] [nchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
,	[Note] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Department
ADD CONSTRAINT PK_Dept PRIMARY KEY (DeptNo)

GO
CREATE TABLE [dbo].[Emp_Skill](
	[SkillNo] [int] NOT NULL
,	[EmpNo] [int] NOT NULL
,	[SkillLevel] [int] NOT NULL
,	[RegDate] [datetime] NOT NULL
,	[Description] [nchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT PK_Emp_Skill PRIMARY KEY (SkillNo, EmpNo)
GO

ALTER TABLE Employee  
ADD  CONSTRAINT [FK_1] FOREIGN KEY([DeptNo])
REFERENCES Department (DeptNo)

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_2] FOREIGN KEY ([EmpNo])
REFERENCES Employee([EmpNo])

GO
ALTER TABLE Emp_Skill
ADD CONSTRAINT [FK_3] FOREIGN KEY ([SkillNo])
REFERENCES Skill([SkillNo])

GO

--a
INSERT INTO DEPARTMENT
VALUES ('Department 1', 'None'),('Department 2', 'None'),('Department 3', 'None'),('Department 4', 'None'),
('Department 5', 'None'),('Department 6', 'None'),('Department 7', 'None'),('Department 8', 'None')
GO

INSERT INTO SKILL 
VALUES ('C++', 'None'),('C#', 'None'),('Java', 'None'),('Python', 'None'),('C', 'None'),('NodeJs', 'None'),('.NET', 'None'),('Agular', 'None')
GO 

INSERT INTO [dbo].[Employee]
           ([EmpNo],[EmpName],[BirthDay] ,[DeptNo],[MgrNo],[StartDate],[Salary],[Status],[Note],[Level],[Email])
     VALUES
           (1,'Minh Anh Vu','2000/09/15',1,'Hoang Anh','2021/09/15',3000,1,'None',1,'VuMA@gmail.com'),
		   (2,'Le Hong Quan','2001/08/12',1,'Hoang Anh','2021/09/15',3000,1,'None',1,'QUanHL@gmail.com'),
		   (3,'Le Anh Duc','2001/11/5',2,'Thao Anh','2021/09/15',3000,1,'None',1,'DucAL@gmail.com'),
		   (4,'Bui Tien Dung','2000/12/1',2,'Thao Anh','2021/09/15',3000,1,'None',1,'DungTB@gmail.com'),
		   (5,'Pham Minh Giang','2001/3/3',1,'Cong Anh','2021/09/15',3000,1,'None',1,'GiangMP@mail.com'),
		   (6,'Le ANh Luong','2001/1/1',3,'Cong Anh','2021/09/15',3000,1,'None',1,'LuongAL@gmail.com'),
		   (7,'Bui Tien Dung','2001/2/2',4,'Minh Anh','2021/09/15',3000,1,'None',1,'DungTD@gmail.com'),
		   (8,'Pham Hong Luong','2001/3/2',4,'Minh Anh','2021/09/15',3000,1,'None',1,'LuongHL@gmail.com')
Go
INSERT INTO EMP_SKILL 
     VALUES
('1', '1', '1', '2022/10/1', 'None'),
('2', '2', '1', '2022/5/25', 'None'),
('3', '3', '1', '2022/4/20', 'None'),
('4', '2', '1', '2022/3/15', 'None'),
('5', '2', '1', '2022/1/10', 'None'),
('6', '4', '1', '2022/1/5', 'None'),
('7', '1', '1', '2022/6/02', 'None'),
('8', '6', '1', '2022/5/1', 'None')
GO 

--b Specify name, email and department name of the employees that have been working at least six months.
SELECT e.EmpName, e.Email, DEPARTMENT.DeptName FROM EMPLOYEE e 
INNER JOIN DEPARTMENT ON DEPARTMENT.DeptNo = e.DeptNo
WHERE DATEDIFF(MONTH, e.StartDate, GETDATE()) >= 6

--c. Specify the names of the employees 
--whore have either ‘C++’ or ‘.NET’ skills.

SELECT e.EmpName FROM EMPLOYEE e
INNER JOIN EMP_SKILL ON EMP_SKILL.EmpNo = e.EmpNo
INNER JOIN SKILL ON SKILL.SkillNo = EMP_SKILL.SkillNo
WHERE SKILL.SkillName = 'C++' OR SKILL.SkillName = '.NET'
GO 

--d. List all employee names, manager names, 
--manager emails of those employees.

SELECT EmpName,MgrNo,Email FROM employee 
Go
--e. Specify the departments which have >=2 employees, 
--print out the list of departments’ employees right after each department.
SELECT DEPARTMENT.DeptName, EMPLOYEE.EmpName FROM DEPARTMENT
INNER JOIN EMPLOYEE ON EMPLOYEE.DeptNo = DEPARTMENT.DeptNo
WHERE DEPARTMENT.DeptNo IN (
    SELECT EMPLOYEE.DeptNo FROM EMPLOYEE
    GROUP BY EMPLOYEE.DeptNo
    HAVING COUNT(EMPLOYEE.EmpName) >= 2
)
GO 

--f. List all name, email and skill number of the employees 
--and sort ascending order by employee’s name.

SELECT e.EmpName, e.Email, COUNT(es.SkillNo) AS Skill_Number FROM EMPLOYEE e
INNER JOIN EMP_SKILL es ON es.EmpNo = e.EmpNo
GROUP BY e.EmpName, e.Email
ORDER BY e.EmpName

--g. Use SUB-QUERY technique to list out the different employees 
--(include name, email, birthday) who are working and have 
--multiple skills.

SELECT e.EmpName, e.Email, e.BirthDay FROM EMPLOYEE e 
WHERE e.[Status] = 1 AND e.EmpNo IN (
    SELECT EMP_SKILL.EmpNo FROM EMP_SKILL
    GROUP BY EMP_SKILL.EmpNo
    HAVING COUNT(EMP_SKILL.SkillNo) >= 2
)
GO 

--h. Create a view to list all employees are working 
--(include: name of employee and skill name, department name)

CREATE VIEW vw_InfoEmployee AS
SELECT e.EmpName, s.SkillName, d.DeptName FROM EMPLOYEE e 
INNER JOIN DEPARTMENT d ON d.DeptNo = e.DeptNo
INNER JOIN EMP_SKILL es ON es.EmpNo = e.EmpNo
INNER JOIN SKILL s ON s.SkillNo = es.SkillNo
GO