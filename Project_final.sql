create DATABASE project
GO

use project
GO

----------------DOWN-------------------


if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_OrderLines_Bank_ID')
alter table OrderLines drop constraint fk_OrderLines_Bank_ID


GO
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_OrderLines_Payment_ID')
alter table OrderLines drop constraint fk_OrderLines_Payment_ID
GO
drop table if exists OrderLines


GO
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_BankTransferPayment_Bank_ID')
alter table BankTransferPayment drop constraint fk_BankTransferPayment_Bank_ID

GO
drop table if exists BankTransferPayment
GO

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_BankTransferPayment_Payment_ID')
alter table BankTransferPayment drop constraint fk_BankTransferPayment_Payment_ID

GO


if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_CreditCardPayment_Credit_Card_ID')
alter table CreditCardPayment drop constraint fk_CreditCardPayment_Credit_Card_ID
GO

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_CreditCardPayment_Payment_ID')
alter table CreditCardPayment drop constraint fk_CreditCardPayment_Payment_ID
GO

drop table if exists CreditCardPayment
GO


if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Suppliers_Supplier_Address_ID')
alter table Suppliers drop constraint fk_Suppliers_Supplier_Address_ID
GO



if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Payments_Supplier_ID')
alter table Payments drop constraint fk_Payments_Supplier_ID
GO



if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Payments_Order_ID')
alter table Payments drop constraint fk_Payments_Order_ID
GO

drop table if exists Payments
GO

drop table if exists Products
Go

drop table if exists Suppliers
GO

GO
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Orders_Shipper')
alter table Orders drop constraint fk_Orders_Shipper
GO

GO
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Orders_Employee_ID')
alter table Orders drop constraint fk_Orders_Employee_ID
GO

GO
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Orders_Stakeholder_ID')
alter table Orders drop constraint fk_Orders_Stakeholder_ID
GO

drop table if exists Orders

GO
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Employees_Employee_Team_ID')
alter table Employees drop constraint fk_Employees_Employee_Team_ID
GO
drop table if exists Employees
GO
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Stakeholders_Stakeholder_Team_ID')
alter table Stakeholders drop constraint fk_Stakeholders_Stakeholder_Team_ID
GO

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Stakeholder_Team_Lead_ID')
alter table Stakeholders drop constraint fk_Stakeholder_Team_Lead_ID
GO

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Teams_Project_Team_Lead_ID')
alter table Teams drop constraint fk_Teams_Project_Team_Lead_ID
GO

drop table if exists Stakeholders
GO

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Teams_Project_Project_ID')
alter table Teams drop constraint fk_Teams_Project_Project_ID
GO
drop table if exists Teams
GO
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where CONSTRAINT_NAME='fk_Projects_Project_Address_ID')
alter table Projects drop constraint fk_Projects_Project_Address_ID
GO
drop table if exists Projects
GO
drop table if exists BankAccounts
Go
drop table if exists SupplierAddresses
GO
drop table if exists Shippers
GO
drop table if exists EmployeeTeams
GO
drop table if exists CreditCards
GO
drop table if exists Addresses
GO


------------------UP-------------------

------create table Addresses-----------
--done
create table Addresses(
    Address_id int IDENTITY not null,
    Street_Address_1 VARCHAR(50) not NULL,
    Street_Address_2 VARCHAR(50) not NULL,
    City VARCHAR(20) not NULL,
    States VARCHAR(20) not NULL,
    Zip int not NULL
    constraint pk_Addresses_Address_id PRIMARY key  (Address_id)
    
)
GO

------create table CreditCards-----------

create table CreditCards(
    Credit_card_id int IDENTITY not null,
    Credit_card_No int not NULL,
    Expiration_Month int not NULL,
    Expiration_Year int not NULL,
    Cardholder_Name VARCHAR(30) not NULL
    constraint pk_CreditCards_Credit_card_id PRIMARY key  (Credit_card_id),
    constraint u_CreditCards_Credit_card_No UNIQUE(Credit_card_No)
    
)
GO

------create table EmployeeTeams-----------
--done
create table EmployeeTeams(
    Employee_Team_id int IDENTITY not null,
    Employee_Team_name VARCHAR(20) not NULL
    constraint pk_EmployeeTeams_Employee_Team_id PRIMARY key  (Employee_Team_id)
)
GO

------create table Shippers-----------
--done
create table Shippers(
    Shipper_ID int IDENTITY not null,
    Shipper_Name VARCHAR(20) not NULL
    constraint pk_Shippers_Shipper_id PRIMARY key  (Shipper_id)
)
GO

------create table BankAccounts-----------
--done
create table BankAccounts(
    Bank_id int IDENTITY not null,
    BankAccount_No int not NULL,
    Routing_No varchar(10) not NULL,
    Accountholder_Name VARCHAR(30) not NULL
    constraint pk_BankAccounts_Bank_id PRIMARY key  (Bank_id),
    constraint u_BankAccounts_BankAccount_No UNIQUE(BankAccount_No)
)
GO

------create table Projects-----------
--done
create table Projects(
    Project_ID int IDENTITY not null,
    Project_Name VARCHAR(20) not NULL,
    Project_Address_ID int not null
    constraint pk_Projects_Project_id PRIMARY key  (Project_id)
)
GO

alter table Projects
add constraint fk_Projects_Project_Address_ID foreign key(Project_Address_ID)
REFERENCES Addresses(Address_id)
GO

------create table Teams-----------

create table Teams(
    Team_ID int IDENTITY not null,
    Team_Name VARCHAR(20) not NULL,
    Project_ID int not null,
    constraint pk_Teams_Team_ID PRIMARY key  (Team_ID)
)
GO

alter table Teams
add constraint fk_Teams_Project_Project_ID foreign key(Project_ID)
REFERENCES Projects(Project_ID)
GO


------create table Stakeholders-----------

create table Stakeholders(
    Stakeholder_ID int IDENTITY not null,
    Stakeholder_Firstname VARCHAR(20) not NULL,
    Stakeholder_Lastname VARCHAR(20) not NULL,
    Stakeholder_Team_ID int not null,
    Stakeholder_Email_ID VARCHAR(30) not NULL,
    Stakeholder_Contact VARCHAR(15) not NULL,
    Stakeholder_Title VARCHAR(30) not NULL,
    Stakeholder_Team_Lead int not null
    constraint pk_Stakeholders_Stakeholder_ID PRIMARY key  (Stakeholder_ID),
    constraint u_Stakeholders_Stakeholder_Email_ID UNIQUE(Stakeholder_Email_ID)
)
GO

alter table Stakeholders
add constraint fk_Stakeholders_Stakeholder_Team_ID foreign key(Stakeholder_Team_ID)
REFERENCES Teams(Team_ID)
GO

alter table Stakeholders
add constraint fk_Stakeholder_Team_Lead_ID foreign key(Stakeholder_Team_Lead)
REFERENCES Stakeholders(Stakeholder_ID)
GO

------create table Employees-----------
--done

create table Employees(
    Employee_ID int IDENTITY not null,
    Employee_Title VARCHAR(30) not null,
    Employee_Firstname VARCHAR(20) not NULL,
    Employee_Lastname VARCHAR(20) not NULL,
    Employee_Email VARCHAR(30) not NULL,
    Employee_Contact VARCHAR(15) not NULL,
    Employee_Team_ID int not null
    
    constraint pk_Employees_Employee_ID PRIMARY key  (Employee_ID),
    constraint u_Employees_Employee_Email UNIQUE(Employee_Email)
)
GO

alter table Employees
add constraint fk_Employees_Employee_Team_ID foreign key(Employee_Team_ID)
REFERENCES EmployeeTeams(Employee_Team_ID)
GO

------create table Orders-----------

create table Orders(
    Order_ID int IDENTITY not null,
    PO_Nmber VARCHAR(5) not null,
    Order_Date DATE ,
    Stakeholder_ID int not null,
    Employee_ID int not null,
    Shipper int not null,
    constraint pk_Orders_Order_ID PRIMARY key  (Order_ID)
    
)
GO

alter table Orders
add constraint fk_Orders_Stakeholder_ID foreign key(Stakeholder_ID)
REFERENCES Stakeholders(Stakeholder_ID)
GO
alter table Orders
add constraint fk_Orders_Employee_ID foreign key(Employee_ID)
REFERENCES Employees(Employee_ID)
GO
alter table Orders
add constraint fk_Orders_Shipper foreign key(Shipper)
REFERENCES Shippers(Shipper_ID)
GO


------create table Payments-----------
--done

create table Payments(
    Payment_ID int IDENTITY not null,
    Payment_Type VARCHAR(5) not NULL,
    Payment_Date date not NULL,
    Supplier_ID int not null,
    Order_ID int not null
    constraint pk_Payments_Payment_ID PRIMARY key  (Payment_ID)
)
GO

alter table Payments
add constraint fk_Payments_Order_ID foreign key(Order_ID)
REFERENCES Orders(Order_ID)
GO

------create table Suppliers-----------
--done

create table Suppliers(
    Supplier_ID int IDENTITY not null,
    Supplier_Name VARCHAR(20) not NULL,
    Supplier_Contact_FName VARCHAR(20) not NULL,
    Supplier_Contact_LName VARCHAR(30) not NULL,
    Supplier_Contact_Email VARCHAR(30) not NULL,
    Supplier_Contact VARCHAR(15) not NULL,
    Supplier_Address_ID int not null
    
    constraint pk_Suppliers_Supplier_ID PRIMARY key  (Supplier_ID)
)
GO

alter table Payments
add constraint fk_Payments_Supplier_ID foreign key(Supplier_ID)
REFERENCES Suppliers(Supplier_ID)
GO

------create table SupplierAddresses-----------
--done

create table SupplierAddresses(
    Supplier_Address_ID int IDENTITY not null,
    Supplier_Address_1 VARCHAR(50) not NULL,
    Supplier_Address_2 VARCHAR(50) not NULL,
    Supplier_City VARCHAR(20) not NULL,
    Supplier_State VARCHAR(20) not NULL,
    Supplier_Zip int not NULL
    constraint pk_SupplierAddresses_Address_id PRIMARY key  (Supplier_Address_ID)
)
GO

alter table Suppliers
add constraint fk_Suppliers_Supplier_Address_ID foreign key(Supplier_Address_ID)
REFERENCES SupplierAddresses(Supplier_Address_ID)
GO

------create table CreditCardPayment-----------

create table CreditCardPayment(
    Payment_ID int not null,
    Credit_Card_ID int  not null,

    constraint pk_CreditCardPayment_Payment_ID_Credit_Card_ID PRIMARY key (Payment_ID,Credit_Card_ID)
)
GO

alter table CreditCardPayment
add constraint fk_CreditCardPayment_Payment_ID foreign key(Payment_ID)
REFERENCES Payments(Payment_ID)
GO
alter table CreditCardPayment
add constraint fk_CreditCardPayment_Credit_Card_ID foreign key(Credit_Card_ID)
REFERENCES CreditCards(Credit_Card_ID)
GO

------create table BankTransferPayment-----------

create table BankTransferPayment(
    Payment_ID int not null,
    Bank_ID int  not null,
   constraint pk_BankTransferPayment_Payment_ID_Bank_ID PRIMARY key  (Payment_ID,Bank_ID)
    
)
GO

alter table BankTransferPayment
add constraint fk_BankTransferPayment_Payment_ID foreign key(Payment_ID)
REFERENCES Payments(Payment_ID)
GO
alter table BankTransferPayment
add constraint fk_BankTransferPayment_Bank_ID foreign key(Bank_ID)
REFERENCES BankAccounts(Bank_ID)
GO

------create table Products-----------
--done

create table Products(
    Product_ID int IDENTITY not null,
    Product_Name VARCHAR(50) not NULL,
    Product_Price int not NULL,
    Product_Reserve int not NULL,
    Product_Discount int not NULL,
    Lead_Time int not NULL,
    Supplier_ID int not null
    
    constraint pk_Products_Product_ID PRIMARY key  (Product_ID)
)
GO

alter table Products
add constraint fk_Products_Supplier_Supplier_ID foreign key(Supplier_ID)
REFERENCES Suppliers(Supplier_ID)
GO

------create table OrderLines-----------

create table OrderLines(
    Order_ID int not null,
    Product_ID int  not null,
    Product_Name VARCHAR(50) not NULL,
    Product_Price int not NULL,
    Product_Quantity int not NULL

    constraint pk_OrderLines_Payment_ID_Bank_ID PRIMARY key  (Order_ID,Product_ID)
    
)
GO

alter table OrderLines
add constraint fk_OrderLines_Payment_ID foreign key(Order_ID)
REFERENCES Orders(Order_ID)
GO
alter table OrderLines
add constraint fk_OrderLines_Bank_ID foreign key(Product_ID)
REFERENCES Products(Product_ID)
GO

----------------INSERTS-------------------

------insert into table Addresses-----------

insert into Addresses
(Street_Address_1,Street_Address_2,City,States,Zip)
VALUES
('436 Columbus Avenue','Next to Chase','Syracuse','NY','13210'),
('567 Akerman Avenue','Next to BOA','NYC','NY','13250'),
('343 Lancaster Avenue','Next to Fedex','Olympia','NJ','13211'),
('757 Maryland Avenue','Next to UPS','Syracuse','NY','13210'),
('222 Hawthorne Avenue','Next to Walmart','Syracuse','NY','13210'),
('888 Richard Avenue','Next to Pricerite','Boston','MA','14333'),
('222 Livingston Avenue','Next to Hendricks','Syracuse','NY','13210'),
('441 Kensington Avenue','Next to Alto Cinco','Los Angeles','CA','15321'),
('909 Ostrom Avenue','Next to SU','Syracuse','NY','13210'),
('245 Bell Avenue','Next to Chase','Los Angeles','CA','15321')
GO



------insert into table CreditCards-----------


insert into CreditCards
(Credit_card_No,Expiration_Month,Expiration_Year,Cardholder_Name)
VALUES
('2444222','01','2023','Mikhail Pinto'),
('2446422','08','2027','Pranali Shenvi'),
('2444202','12','2025','Ruchak Vira')
GO



------insert into table EmployeeTeams-----------
 

insert into EmployeeTeams
(Employee_Team_name)
VALUES
('Billing'),
('HR'),
('Finance'),
('IT'),
('Support'),
('Enrollment'),
('Cloud'),
('Tech'),
('Analytics'),
('Presentations')
GO


GO

------insert into table Shippers-----------
insert into Shippers
(Shipper_Name)
VALUES
('UPS'),
('Fedex'),
('USPS'),
('DHL')
GO



------insert into table BankAccounts-----------
insert into BankAccounts
(BankAccount_No,Routing_No,Accountholder_Name)
VALUES
('3456322','CS0927','Mikhail Pinto'),
('6677442','RO8329','Pranali Shenvi'),
('3424563','LD0393','Ruchak Vira')
GO




------insert into table Projects-----------

insert into Projects
(Project_Name,Project_Address_ID)
VALUES
('BCBS','9'),
('Verizon','3'),
('Blake','8'),
('T-Mobile','1'),
('Walgreens','2'),
('SU','5'),
('Orange','7'),
('ZS','6'),
('GM','4'),
('Seagate','10')
GO


------insert into table SupplierAddresses-----------

insert into SupplierAddresses
(Supplier_Address_1,Supplier_Address_2,Supplier_City,Supplier_State,Supplier_Zip)
VALUES
('466 Columbus Avenue','Next to Chase','Syracuse','NY','13210'),
('568 Akerman Avenue','Next to Chase','New York','NY','13250'),
('343 Lancaster Avenue','Next to Fedex','Olympia','NJ','13210'),
('754 Maryland Avenue','Next to Fedex','Syracuse','NY','13210'),
('221 Hawthorne Avenue','Next to Walmart','Syracuse','NY','13210')

GO



------insert into table Employees-----------
insert into Employees
(Employee_Firstname,Employee_Lastname,Employee_Email,Employee_Contact,Employee_Team_ID, Employee_Title)
VALUES
('Rachel','Greene','raGreene@gmail.com','31599206309','8','Sourcing Manager'),
('Jung','Ho','Jnh@gmail.com','31599006309','2','Sourcing Associate'),
('Pranav','Sheth','psheth189@gmail.com','31599208809','4', 'Procurement Associate'),
('Ashish','Waghmare','awagh1@gmail.com','31109206309','7','Procurement Manager'),
('Ankita','Agarwal','aagrawal@gmail.com','31599204409','1', 'Contracts Associate'),
('Harsh','Athavale','haathawale@gmail.com','31599206209','5', 'Contracts Manager'),
('Naruto','Uzumaki','hiddenleaf_123@gmail.com','31339206309','10', 'Procurement Associate'),
('Sasuke','Uchiha','rogue_ninja@gmail.com','31599208809','9','Contracts Associate'),
('Eren','Yaeger','titan12@gmail.com','31508206309','6', 'Sourcing Associate'),
('Misa','Amane','kira2@gmail.com','31592306309','3', 'Group Manager')
GO




------insert into table Suppliers-----------


insert into Suppliers
(Supplier_Name,Supplier_Contact_FName,Supplier_Contact_LName,Supplier_Contact_Email,
Supplier_Contact,Supplier_Address_ID)
VALUES
('Ballistic Machines','Bill','Gray','Billie@gmail.com','3109928933','2'),
('Houser Electronics','John','Greene','Teled@gmail.com','3109921133','3'),
('3D Microtec','Agatha ','Christie','ASI_emp@gmail.com','3119928933','5'),
('ProServ Servers','Nick','Fury','US_Demp@gmail.com','3109922233','4'),
('Teledyne Electronics','Peter','Dinklage','WpetEmp@gmail.com','3009928933','1')

GO


------insert into table Teams-----------

insert into Teams
(Team_Name,Project_ID)
VALUES
('Seagate Deployment','10'),
('Verizon Execution','2'),
('GM Research','9')
GO



------insert into table Stakeholders-----------

insert into Stakeholders
(Stakeholder_Firstname,Stakeholder_Lastname,Stakeholder_Team_ID,Stakeholder_Email_ID,Stakeholder_Contact,
Stakeholder_Title, Stakeholder_Team_Lead)
VALUES
('Pranali','Shenvi','1','psehnvi@gmail.com','3159803790', 'Project Manager','1'),
('Mikhail','Pinto','2','mike112@gmail.com','3159803791', 'Project Manager','2'),
('Ruchak','Vira','3','rnvira47@gmail.com','3159803792', 'Project Manager','3'),
('Neel','Samant','1','neelsa123@gmail.com','3159803793', 'Research Scientist','1'),
('Pranjali','Shenvi','1','prahsen@gmail.com','3159803794', 'Software Engineer','1'),
('Usha','Sen','1','usen@gmail.com','3159803795', 'Hardware Engineer','1'),
('Manik','Tiles','2','mati@gmail.com','3159803796', 'Hardware Engineer','2'),
('Rupa','Saarees','2','rusa@gmail.com','3159803797', 'Software Engineer','2'),
('Kachrina','Kemph','2','kake@gmail.com','3159803798', 'Research Scientist','2'),
('Dolan','Tump','3','dolund@gmail.com','3159803799', 'Software Engineer','3'),
('Nurinder','Moody','3','nurinchamp@gmail.com','3159803700', 'Research Scientist','3'),
('Pappu','Gandhi','3','pape@gmail.com','3159803701', 'Hardware Engineer','3'),
('Saif Ali','Ramprasad','1','nawab@gmail.com','3159803702', 'Data Analyst','1'),
('Raja','Hindustani','2','emirkhun@gmail.com','3159803703', 'Data Analyst','2'),
('Mader','Chodh','3','hogatu@gmail.com','3159803704', 'Data Analyst','3')



------insert into table Orders-----------
insert into Orders
(PO_Nmber,Order_Date,Stakeholder_ID,Employee_ID,Shipper)
VALUES
('367','2018-12-31','4','6','2'),
('639','2019-10-31','5','10','4'),
('892','2018-07-10','9','4','3'),
('938','2019-06-08','13','9','1'),
('739','2019-11-30','15','2','1'),
('999','2018-06-23','14','1','2'),
('157','2017-05-31','7','7','3'),
('493','2018-10-12','8','5','3'),
('902','2018-08-19','10','8','2'),
('678','2018-05-30','6','3','1')
GO


------insert into table Payments-----------

insert into Payments
(Payment_Type,Payment_Date,Supplier_ID, Order_ID)
VALUES
('CC','2021-11-30','1','1'),
('BT','2020-05-06','1','2'),
('CC','2020-12-10','2','3'),
('CC','2020-03-02','2','4'),
('CC','2020-12-31','2','5'),
('BT','2021-11-12','3','6'),
('BT','2020-12-31','3','7'),
('CC','2020-04-05','4','8'),
('BT','2020-06-07','4','9')
GO

------insert into table Products-----------

insert into Products
(Product_Name,Product_Price,Product_Reserve,Product_Discount,Lead_Time,Supplier_ID)
VALUES
('Servers','100000','50','5','14','1'),
('Probes','200','1000','40','4','1'),
('Tablithe Waifer','4500','500','20','5','2'),
('3-DM Pro Neurometer','26000','35','10','5','2'),
('Oscilloscope','53000','120','15','14','3'),
('3-D Printers','21000','190','5','8','3'),
('Inferometer','32000','100','8','9','3'),
('Plasma Cutter','17000','400','0','7','4'),
('Pro-Gen Graphite Cable','400','5600','50','15','4'),
('Ultrasound Machine','67000','70','25','20','5')
GO



------insert into table BankTransferPayment-----------

insert into BankTransferPayment
(Payment_ID,Bank_ID)
VALUES
('7','2'),
('2','1'),
('6','2'),
('9','3')
GO


------insert into table CreditCardPayment-----------

insert into CreditCardPayment
(Payment_ID,Credit_Card_ID)
VALUES
('1','1'),
('8','2'),
('3','2'),
('5','3'),
('4','1')
GO



------insert into table OrderLines-----------



insert into OrderLines
(Order_ID,Product_ID,Product_Name,Product_Price,Product_Quantity)
VALUES
('1','1','Servers','100000','3'),
('2','1','Servers','100000','8'),
('1','2','Probes','200','6'),
('2','2','Probes','200','3'),
('3','3','Tablithe Wafer','4500','4'),
('4','3','Tablithe Wafer','4500','2'),
('4','4','3-DM Pro Neurometer','26000','7'),
('5','4','3-DM Pro Neurometer','26000','9'),
('6','5','Oscilloscope','53000','8'),
('6','6','3-D Printers','21000','6'),
('7','6','3-D Printers','21000','10'),
('6','7','Inferometer','32000','6'),
('8','8','Plasma Cutter','17000','8'),
('8','9','Pro-gen Graphite cable','400','5'),
('9','9','Pro-gen Graphite cable','400','3'),
('10','10','Ultrasound Machine','67000','4')
GO



------QUERIES------
--1
--We would like a list of product names with product id  and type along with a count of product
--quantities (shipper names). There should be a column for each of the Shippers.

with pivot_source as (
    select ol.Product_ID,ol.Product_Name,o.Shipper,ol.Product_Quantity
    from OrderLines ol
    join Orders o on ol.Order_ID=o.Order_ID
)
select * from
pivot_source pivot(
    count(Product_Quantity) for Shipper IN (ok,low_bid,item_seller)
)as pivot_table

--2 What is the spend of each Stakeholder team?

CREATE VIEW Spend_By_StakeholderTeam
AS
Select distinct t.Team_Name, sum((ol.Product_Price*ol.Product_Quantity)) OVER (PARTITION by t.Team_Name) as TotalSpend
from Teams t JOIN Stakeholders s
on t.Team_ID=s.Stakeholder_Team_ID
JOIN Orders o on s.Stakeholder_ID = o.Stakeholder_ID
JOIN OrderLines ol on o.Order_ID=ol.Order_ID
JOIN Products p on ol.Product_ID=p.Product_ID 


--3 Which orders have not been paid for?

Select o.Order_ID, s.Stakeholder_Firstname + ' ' + s.Stakeholder_Lastname as StakeholderName, 
s1.Stakeholder_Firstname + ' ' + s1.Stakeholder_Lastname as TeamLead, t.Team_Name, o.Order_Date
from Teams t JOIN Stakeholders s
on t.Team_ID = s.Stakeholder_Team_ID
join Stakeholders s1 on s1.Stakeholder_ID = s.Stakeholder_Team_Lead
join Orders o on s.Stakeholder_ID = o.Stakeholder_ID
left join Payments p on o.Order_ID = p.Order_ID
where p.Order_ID is NULL


--4 How many orders correspond to each zip code?

with pivot_source AS
(
    Select Zip
    from Addresses a join Projects p
    on a.Address_id=p.Project_Address_ID
    join Teams t on p.Project_ID=t.Project_ID
    JOIN Stakeholders s on t.Team_ID=s.Stakeholder_Team_ID
    JOIN Orders o on s.Stakeholder_ID=o.Stakeholder_ID
)
SELECT * from pivot_source PIVOT (
    COUNT(zip) for Zip in ("15321","13210","13211")
) as pivot_table


--5 Find all projects in the state of New York. Print name, spend, city, State, Zip?



--6 Create list of product names, price and payment method?

with pivot_source1 AS
(
    Select p.Product_Name, p.Product_Price ,pa.Payment_Type
    from Products p join Suppliers s
    on p.Supplier_ID = s.Supplier_ID
    join Payments pa on s.Supplier_ID=pa.Supplier_ID
)

SELECT * from pivot_source1 PIVOT (
    sum(Product_Price) for Payment_Type in ("BT","CC")
) as pivot_table1


--7 Which Stakeholder is ordering an order with most products?

Select count(Product_ID)
from Stakeholders s join Orders o 
on s.Stakeholder_ID=o.Order_ID join OrderLines ol
on o.Order_ID=ol.Order_ID
GROUP by Product_ID



