Create database EmployeeMgt
Go
Use EmployeeMgt
Go

/*
Write SQL statements for following activities & print out respectively the screenshots to show test data (the
table data that you create to test each query) & query results:
a. Add at least 8 records into each created tables.

b. Specify name, email and department name of the employees that have been working at least six
months.

c. Specify the names of the employees whore have either ‘C++’ or ‘.NET’ skills.

d. List all employee names, manager names, manager emails of those employees.

e. Specify the departments which have >=2 employees, print out the list of departments’ employees right
after each department.

f. List all name, email and skill number of the employees and sort ascending order by employee’s name.

g. Use SUB-QUERY technique to list out the different employees (include name, email, birthday) who are
working and have multiple skills.

h. Create a view to list all employees are working (include: name of employee and skill name, department
name).
*/

--Employe(EmployeeId, EmployeeName, Email,Birthday,StartDate ,DeptNo,SkillNo,MgId)
--Skill(SkillId,SkillName)
--Manager(ManagerId,ManagerName,Email)
--Department(DeptId,DepartmentName)
--EmpSkill(EmployeeId,SkillId)
Create table Skill(
   SkillId  int identity(1,1) not null,
   SkillName varchar(50) not null,
   constraint PK_Skill primary key (SkillId)
)

Create table Manager(
    ManagerId int identity(1,1) not null,
	ManagerName varchar(50) not null,
	constraint PK_Manager primary key (ManagerId)
)

Create table Department(
   DeptId int identity(1,1) not null,
   DepartmentName varchar(100) not null,
   constraint PK_Department primary key (DeptId)
)

Create table Employee(
    EmployeeId int identity(1,1) not null,
	EmployeeName varchar(50) not null,
	Email varchar(100) not null,
	Birthday date,
	StartDate date,
	DeptNo int,
	MgId int,
	constraint PK_Employee primary key (EmployeeId),
	constraint FK_Department foreign key (DeptNo) references  Department(DeptId),
	constraint FK_Manager foreign key (MgId) references  Manager(ManagerId)
)

create table EmployeeSkill(
 EmployeeId int,
 SkillId int,
 constraint PK_EmployeeSkill primary key (EmployeeId,SkillId),
 constraint FK_Employee foreign key (EmployeeId) references  Employee(EmployeeId),
 constraint FK_Skill foreign key (SkillId) references  Skill(SkillId)
)