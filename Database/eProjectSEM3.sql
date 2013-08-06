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
	Email varchar(100),
	Name nvarchar(100)
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
	FrequentlyViewed int,
	UnitPrice money,
	AddedDate Date DEFAULT getdate(),
	[ExtraDescription] varchar(300),-- more details of this product
)


--	SELECT
select * from tblCareerer
select * from tblAdmin
select * from tblEmail2Careerer
select * from tblProduct
select * from tblCategory
select * from tblGuestFeedBack

--update  tblProduct set Picture=''
--where ProductID=1
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
--CREATE PROCEDURE sp_InsertPicture @Picture varchar(100),@ProductName varchar(100)
--AS
--UPDATE tblProduct SET Picture=@Picture WHERE ProductName=@ProductName
GO
-- Stored procedure for get all category
CREATE PROCEDURE sp_getAllCategory
AS
SELECT * from tblCategory
GO
exec sp_getAllCategory
go
-- Stored procedure for get products viewed most frequently
CREATE PROC sp_GetProductByFrequentlyViewed
AS
select TOP 6[ProductName],[Output],MadeGoodsSize,MachineSize,[Weight], [UnitPrice],[Picture],FrequentlyViewed,ProductID,[ExtraDescription] from dbo.tblProduct order by FrequentlyViewed DESC
GO

exec sp_GetProductByFrequentlyViewed
go

CREATE PROC sp_GetProductByAddedDate 
AS
select TOP 3[ProductName],[Output],MadeGoodsSize,MachineSize,[Weight], [UnitPrice],[Picture],FrequentlyViewed,ProductID,[ExtraDescription] from dbo.tblProduct order by AddedDate DESC
GO
exec sp_GetProductByAddedDate
go

-- procduce Admin
Create Proc sp_AdminSelectAll 
AS
BEGIN
	SELECT * FROM tblAdmin
END
Go

CREATE PROC sp_AdminSelectById
	@AdminID int
AS
BEGIN
	SELECT * FROM tblAdmin WHERE [AdminID] = @AdminID
END
GO

CREATE PROC sp_AdminCheckLogin
	@Username nvarchar(20),
	@Password nvarchar(20)
AS
BEGIN
	SELECT * FROM tblAdmin Where [UserName] = @Username and [Password] = @Password
END
GO

Create Proc sp_AdminInsert
	@Username nvarchar(20),
	@Password nvarchar(20),
	@Email varchar(100),
	@Name nvarchar(50)
AS
BEGIN
	Insert into tblAdmin values (@Username,@Password,@Email,@Name) 
END
GO

Create Proc sp_AdminChangePassword
	@AdminID int,
	@Password varchar(20),
	@NewPassword varchar(20)
AS
BEGIN
	Update tblAdmin set [Password] = @NewPassword where [AdminID] = @AdminID and [Password] = @Password
END
Go

Create Proc sp_AdminUpdateProfile
	@AdminID int,
	@Email varchar(100),
	@Name nvarchar(50)
AS
Begin
	Update tblAdmin set [Email] = @Email,[Name]=@Name where [AdminID] = @AdminID
End
go
-- procduce Category
Create Proc sp_CategorySelectAll 
AS
BEGIN
	SELECT * FROM tblCategory
END
Go

Create Proc sp_CategorySelectByID
	@CategoryId int
AS
BEGIN
	SELECT * FROM tblCategory WHERE [CategoryID] = @CategoryId
END
go

Create Proc sp_CategoryInsert
	@Category nvarchar(50)	
AS
BEGIN
	Insert into tblCategory values (@Category) 
END
GO

Create Proc sp_CategoryUpdate
	@CategoryName nvarchar(50),
	@CategoryID int
AS
BEGIN
	Update tblCategory set CategoryName = @CategoryName where CategoryID = @CategoryID
END
Go

Create proc sp_CategoryDelete
	@CategoryId int
AS
BEGIN
	Delete from tblCategory where CategoryID=@CategoryId
END
GO	

-- procduce tblCareerer
Create proc sp_CareererSelectAll
As
Begin
	Select * from [tblCareerer]
end
go

CREATE PROC sp_CareererSelectByID
	@CareererID int
AS
BEGIN
	SELECT * FROM [tblCareerer] WHERE [CareererID] = @CareererID
END
GO

CREATE PROC sp_CareererCheckLogin
	@EmailAddress nvarchar(100),
	@Password nvarchar(20)
AS
BEGIN
	SELECT * FROM tblCareerer Where [EmailAddress] = @EmailAddress and [Password] = @Password
END
GO

CREATE PROC sp_CareererInsert
	@EmailAddress varchar(100),
	@Password varchar(20),
	@FullName varchar(100),
	@Age int,
	@Gender bit,
	@Address varchar(50),
	@City varchar(50),
	@Nation varchar(50),
	@CV varchar(100)
AS
Begin
	Insert into tblCareerer values (@EmailAddress,@Password,@FullName,@Age,@Gender,@Address,@City,@Nation,@CV)
End
GO

Create PROC sp_CareererChangePassword
	@CareererID int,
	@EmailAddress varchar(100),
	@Password varchar(20),
	@Newpassword varchar(20)
AS
BEGIN
	Update tblCareerer set [Password]= @NewPassword where EmailAddress = @EmailAddress and [Password] = @Password and CareererID = @CareererID
END
GO

Create PROC sp_CareererUpdateProfile
	@CareererID int,
	@FullName varchar(100),
	@Age int,
	@Gender bit,
	@Address varchar(50),
	@City varchar(50),
	@Nation varchar(50)
AS
BEGIN
	Update tblCareerer set [FullName] = @FullName,[Age] = @Age,[Gender] = @Gender,[Address] = @Address,[City] = @City,[Nation]=@Nation where [CareererID] = @CareererID
	
END
GO

CREATE PROC sp_CareererUploadCV
	@CV nvarchar(100)
AS
BEGIN
	Update tblCareerer set [CV] = @CV
END
GO
	