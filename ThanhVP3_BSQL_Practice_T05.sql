--a

Create database GuitarShopDB;
Go

Use GuitarShopDB
Go

Create table Categories(
CategoryID int identity(1,1) primary key,
CategoryName varchar(60) unique not null,
)

Insert Into Categories 
values ('Ram'),('Card'),('Keyboard'),('Mourse')
Go

Create table Products(
ProductID int identity(1,1) primary key,
ProductCode char(10) unique not null,
ProductName varchar(60) not null,
[Description] nvarchar(500) not null,
UnitPrice money not null,
DiscountPercent float default 0.00,
DateAdded datetime,
CategoryID int,
Constraint FK_Categories foreign key (CategoryID) references  Categories(CategoryID)    
)

Insert Into Products Values
('A123456789','Red Switch','Red Color',10,0.5,'2022/09/20',3),
('A123456788','Brown Switch','Brown Color',9,0.6,'2022/09/20',3),
('A123456787','Blue Switch','Blue Color',7,0.5,'2022/09/19',3),
('A123456786','Yellow Switch','Yellow Color',10,0.5,'2022/09/18',3),
('A123456785','Acer Mourse','Mourse Gaming',100,0.5,'2022/09/20',4),
('A123456784','Red	Mourse','Red Mourse',100,0.5,'2022/09/21',4),
('A123456783','Blue Mourse','Blue Mourse',100,0.4,'2022/09/22',4),
('A123456782','Ram 16gb','16GB Ram Modules',1000,0.5,'2022/09/20',1),
('A123456781','Ram 32 gb','32 GB Ram Modules',1000,0.5,'2022/09/20',1),
('A123456780','VGA ASUS TUF GTX 1660 Super-6G ','6GB GDDR6, 192-bit, DVI+HDMI+DP, 1x8-pin',4999,0.1,'2022/09/20',2)
Go

Create table Customers(
CustomerID int identity(1,1) primary key,
Email varchar(60) unique not null,
[Password] varchar(60) not null,
FirstName nvarchar(60) not null,
LastName nvarchar(60) not null,
[Address] varchar(255),
IsPasswordChanged bit default 'false'
)

INSERT INTO Customers values
('ANV@gmail.com','A123456',N'Nguyen','A',N'Ha Noi',0),
('BNV@gmail.com','A123457',N'Nguyen','B',N'Ha NAM',1),
('CNV@gmail.com','A123458',N'Nguyen','C',N'Ninh Binh',1),
('DNV@gmail.com','A123459',N'Nguyen','D',N'Quang Ninh',0),
('ENV@gmail.com','A123450',N'Nguyen','E',N'Thai Binh',0),
('FNV@gmail.com','A123451',N'Nguyen','F',N'Hue',1),
('GNV@gmail.com','A123452',N'Nguyen','G',N'TP HCM',1),
('HNV@gmail.com','A123453',N'Nguyen','H',N'Nam Dinh',0),
('INV@gmail.com','A123454',N'Nguyen','I',N'Thanh Hoa',0),
('KNV@gmail.com','A123455',N'Nguyen','K',N'Ha Noi',1)
Go

Create table Orders(
OrderID int identity(1,1) primary key,
CustomerID int,
OrderDate datetime not null,
ShipAddress nvarchar(255),
Constraint FK_Customer foreign key (CustomerID) references  Customers(CustomerID)    
)

Insert Into Orders values
(3,'2022/09/21','Axxxxxx'),
(4,'2022/09/21','Bxxxxxx'),
(5,'2022/09/22','Cxxxxxx'),
(6,'2022/09/22','Dxxxxxx'),
(7,'2022/09/23','Exxxxxx'),
(7,'2022/09/23','Fxxxxxx'),
(4,'2022/09/24','Gxxxxxx'),
(8,'2022/09/25','Hxxxxxx'),
(9,'2022/09/26','Ixxxxxx'),
(4,'2022/09/27','Axxxxxx')
Go

create table OrderItems(
OrderID int,
ProductID int,
Quantity int not null,
UnitPrice money not null,
DiscountPrcernt decimal(3,2) not null,
primary key (OrderID,ProductID),
Constraint Fk_Order foreign key (OrderID) references  Orders(OrderID),
Constraint FK_Product foreign key (ProductID) references  Products(ProductID)    
)

Insert Into OrderItems values
(2,1,63,999,2.5),
(2,2,120,1000,2.35),
(3,3,63,1999,2.5),
(4,6,140,2000,2.5),
(5,10,1,1100,0.5),
(6,4,3,1300,4.5),
(7,7,12,300,7.5),
(8,8,17,100,2.5),
(9,9,13,400,2.5),
(4,4,9,600,2.5)
Go


--b
Insert Into Products Values
('A123456770','Purple Switch','Purple Color',10,0.0,'2021/01/20',3)
Go


UPDATE Products
SET DiscountPercent = 0.35
WHERE DATEDIFF(month,DateAdded,GETDATE()) >= 12;

--c
INSERT INTO Customers values
('rick@raven.com','A123456',N'Raven','Rick',N'USA',0)
Go

UPDATE Customers
SET Password = 'Secret@1234'
WHERE Email = 'rick@raven.com' and IsPasswordChanged = 'false'

--d

Select concat(FirstName,', ',LastName) as FullName
from Customers 
where LastName like'M%'
OR LastName like'O%'
OR LastName like 'P%'
OR LastName like 'Q%'
OR LastName like 'R%'
OR LastName like 'S%'
OR LastName like 'T%'
OR LastName like 'V%'
OR LastName like 'W%'
OR LastName like 'X%'
OR LastName like'Y%'
OR LastName like 'Z%'
order by LastName ASC

--e
Insert Into Products Values
('A123456666','White Switch','White Color',1000,0.0,'2021/01/20',3)
Go

select ProductName, UnitPrice, DateAdded
from Products
where UnitPrice BETWEEN  500 AND 2000
Order by DateAdded DESC

--f

with t as (
Select c.CustomerID,concat(c.FirstName,' ',c.LastName) as FullName,
c.Email,c.[Address], (oi.Quantity*oi.UnitPrice*(1 - DiscountPrcernt/100)) As [Amount]
from  Customers c inner join Orders o
on c.CustomerID = o.CustomerID
inner join OrderItems oi 
on o.OrderID = oi.OrderID
)
select CustomerID,FullName,Email,[Address],Sum(Amount) as [Total Amount]
from t 
group by CustomerID,FullName,Email,[Address]


