CREATE DATABASE BSQL_Assignment_201;

GO
USE BSQL_Assignment_201;
GO
SET DATEFORMAT dmy;
GO
--Q1.1:
CREATE TABLE EMPLOYEE (
	EmpNo int,
	EmpName nvarchar(100),
	BirthDay date,
	DeptNo int,
	MgrNo int NOT NULL,
	StartDate date,
	Salary money,
	[Level] int,
	[Status] int,
	Note nvarchar(max),
	CONSTRAINT PK_EmpNo PRIMARY KEY (EmpNo),
	CONSTRAINT CHK_Level CHECK ([Level] BETWEEN 1 AND 7),
	CONSTRAINT CHK_Status CHECK ([Status] BETWEEN 0 AND 2)
);

GO
--Q1.2

CREATE TABLE SKILL (
	SkillNo int IDENTITY(1,1),
	SkillName nvarchar(100),
	Note nvarchar(max),
	CONSTRAINT PK_SkillNo PRIMARY KEY (SkillNo)
);
GO
--Q1.3:

CREATE TABLE DEPARTMENT (
	DeptNo int IDENTITY(1,1),
	DeptName nvarchar(100),
	Note nvarchar(max),
	CONSTRAINT PK_DeptNo PRIMARY KEY (DeptNo)
);
GO
--Q1.4:

CREATE TABLE EMP_SKILL (
	 SkillNo int,
	 EmpNo int,
	 SkillLevel int,
	 RegDate date,
	 [Description] nvarchar(max), 
	 CONSTRAINT FK_SkillNo FOREIGN KEY (SkillNo) REFERENCES SKILL(SkillNo),
	 CONSTRAINT FK_EmpNo FOREIGN KEY (EmpNo) REFERENCES EMPLOYEE(EmpNo),
	 CONSTRAINT CHK_SkillLevel CHECK (SkillLevel BETWEEN 1 AND 3),
	 CONSTRAINT PK_SkillNo_EmpNo PRIMARY KEY (SkillNo, EmpNo)
);
GO
--Q2.1:

ALTER TABLE EMPLOYEE
ADD Email nvarchar(100) ;
GO
--Q2.2:

ALTER TABLE EMPLOYEE
ADD CONSTRAINT DF_MgrNo DEFAULT 0 FOR MgrNo;
GO

ALTER TABLE EMPLOYEE
ADD CONSTRAINT DF_Status DEFAULT 0 FOR [Status];
GO
--Q3.1:
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_DeptNo FOREIGN KEY (DeptNo) REFERENCES DEPARTMENT(DeptNo);
GO
--Q3.2:
ALTER TABLE EMP_SKILL
DROP COLUMN [Description];
GO
--Q4.1:
INSERT INTO DEPARTMENT VALUES 
('Project_1', 'None'),
('Project_2', 'None'),
('Project_3', 'None'),
('Project_4', 'None'),
('Project_5', 'None');
GO

INSERT INTO SKILL VALUES 
('Skill_1', 'None'),
('Skill_2', 'None'),
('Skill_3', 'None'),
('Skill_4', 'None'),
('Skill_5', 'None');
GO

INSERT INTO EMPLOYEE VALUES
(1, 'Nguyen Van A', '2001/10/3', 1, 1, '2022/10/1', '10000000', 3, 0, 'None', 'nguyenvana@gmail.com'),
(2, 'Nguyen Van B', '2001/4/15', 2, 2, '2022/10/2', '12000000', 4, 0, 'None', 'nguyenvanb@gmail.com'),
(3, 'Nguyen Van C', '2001/1/1', 3, 3, '2022/10/3', '14000000', 5, 0, 'None', 'nguyenvanc@gmail.com'),
(4, 'Nguyen Van D', '2001/3/4', 4, 4, '2022/10/4', '16000000', 6, 0, 'None', 'nguyenvand@gmail.com'),
(5, 'Nguyen Van E', '2001/7/8', 5, 5, '2022/10/5', '18000000', 7, 0, 'None', 'nguyenvane@gmail.com');
GO
--Q4.2

CREATE VIEW EMPLOYEE_TRACKING AS  
SELECT EmpNo, EmpName, [Level] FROM EMPLOYEE
WHERE Level BETWEEN 3 AND 5;