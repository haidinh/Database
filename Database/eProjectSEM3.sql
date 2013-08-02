create database EprojectSem3Team5
go
use EprojectSem3Team5
go
create table tblCareerer -- the table holds job seeker's info
(
	CareererID int identity(1,1) primary key,
	EmailAddress varchar(100) unique,
	[Password] varchar(20),
	FullName varchar(100),
	Age int,
	Gender bit,
	[Address] varchar(50),
	City varchar(50),
	Nation varchar(50),
	CV varchar(100), --Careerer's resume'
	
)
create table tblAdmin
(
	AdminID int identity(1,1) primary key,
	UserName varchar(20),
	[Password] varchar(20),	
)
create table tblEmail2Careerer -- the table holds info that admin had sent to Careerer
(
	Email2CareererID int identity(1,1) primary key,
	AdminID int ,
	CareererID int,
	--CONSTRAINT pk_tblEmail2Careerer PRIMARY KEY (AdminID,CareererID),
	CONSTRAINT fk_tblEmail2Careerer_tblAdmin FOREIGN KEY (AdminID) REFERENCES tblAdmin(AdminID),
	CONSTRAINT fk_tblEmail2Careerer_tblCareerer FOREIGN KEY (AdminID) REFERENCES tblCareerer(CareererID),
	Title varchar(50),
	Content varchar(500),
	SentDate Date DEFAULT getdate()
)
go

--create table tblEmailGuest -- the table that contains guest's email
--(
--	EmailGuestID int identity(1,1) primary key,
--	EmailGuest varchar(100)
	
--)
create table tblGuestFeedBack -- the table that contains feedback's content
(
	FeedBackID int identity(1,1) primary key,
	Email varchar(100),
	FullName varchar(100),
	EmailAddress varchar(100),
	CompanyName varchar(100),
	[Address] varchar(50),
	City varchar(50),
	Nation varchar(50),
	PhoneNumber varchar(50),
	PostalCode varchar(20),
	Comment varchar(500)
)


create table tblCategory
(
	CategoryID int identity(1,1) primary key,
	CategoryName varchar(50),
)
create table tblProduct
(
	ProductID int identity(1,1) primary key,
	CategoryID int FOREIGN KEY REFERENCES tblCategory(CategoryID),
	ProductName varchar(100),
	[Output] int,-- San luong
	MadeGoodsSize float, --Kich' co thanh` pham duoc tao ra
	MachineSize varchar(50),
	[Weight] float,
	Picture varchar(100),
	[ExtraDescription] varchar(300),-- more details of this product
)

--	SELECT
select * from tblCareerer
select * from tblAdmin
select * from tblEmail2Careerer
select * from tblProduct
select * from tblCategory
select * from tblEmailGuest
select * from tblGuestFeedBack


-- INSERT
-- admin
insert into tblAdmin values('Admin1','1234')
insert into tblAdmin values('Admin2','1234')
-- careerer
--insert into tblCareerer(EmailAddress,[Password]) values('hung@gmail.com','1234')
--insert into tblCareerer(EmailAddress,[Password]) values('mai@gmail.com','1234')
--insert into tblCareerer(EmailAddress,[Password]) values('cuong@gmail.com','1234')

-- 
--insert into tblEmail2Careerer(AdminID,CareererID,Title) values(1,1,'go interview')
--insert into tblEmail2Careerer(AdminID,CareererID,Title) values(1,1,'cancel the interview')
--insert into tblEmail2Careerer(AdminID,CareererID,Title) values(1,3,'go interview on thur')
--insert into tblEmail2Careerer(AdminID,CareererID,Title) values(1,3,'carry IDs')
--insert into tblEmail2Careerer(AdminID,CareererID,Title) values(1,3,'also visa')

-- tblCategory
insert into tblCategory(CategoryName) values('Encapsulation')
insert into tblCategory(CategoryName) values('Tablet')
insert into tblCategory(CategoryName) values('Liquid Filling')
-- tblProduct
insert into tblProduct(CategoryID,ProductName,[Output],MadeGoodsSize,MachineSize,[Weight]) values(1,'En1',100,4,'3x3x3',300)
insert into tblProduct(CategoryID,ProductName,[Output],MadeGoodsSize,MachineSize,[Weight]) values(1,'En2',200,5,'4x3x6',600)
insert into tblProduct(CategoryID,ProductName,[Output],MadeGoodsSize,MachineSize,[Weight]) values(1,'En3',300,7,'3x3x3',500)
insert into tblProduct(CategoryID,ProductName,[Output],MadeGoodsSize,MachineSize,[Weight]) values(2,'Ta1',400,4,'3x3x3',1000)
insert into tblProduct(CategoryID,ProductName,[Output],MadeGoodsSize,MachineSize,[Weight]) values(2,'Ta2',200,4,'3x3x3',800)
insert into tblProduct(CategoryID,ProductName,[Output],MadeGoodsSize,MachineSize,[Weight]) values(3,'Fil1',400,4,'5x2x1',5000)
insert into tblProduct(CategoryID,ProductName,[Output],MadeGoodsSize,MachineSize,[Weight]) values(3,'Fil2',200,4,'8x26x37',8800)

GO
-- STORED PROCEDURE
CREATE PROCEDURE sp_InsertPicture @Picture varchar(100),@ProductName varchar(100)
AS
UPDATE tblProduct SET Picture=@Picture WHERE ProductName=@ProductName
GO