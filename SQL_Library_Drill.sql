create database db_library

go

use db_Library
go

/*Part1. Table Creation...Starting with tables which has primary key and then create the table that hold those keys as
reference*/

/*LIBRARY BRANCH TABLE*/

create table library_branch (
	BranchID int primary key not null identity (1,1),
	BranchName varchar(50) not null,
	BranchAddress varchar(50)
);
go

create table publisher (
	PublisherName varchar(50) primary key,
	PublisherAddress varchar(50),
	PublisherPhone varchar(50)
);
go

create table books (
	BookID int primary key not null identity (1,1),
	BookTitle varchar(50)not null,
	PublisherName varchar(50) not null constraint FK_publisher_books foreign key references publisher(PublisherName) on update cascade on delete cascade
);
go

create table book_authors (
	BookID int not null constraint FK_bookID_authors foreign key references books(BookID) on update cascade on delete cascade,
	AuthorName varchar(50) not null
);
go

create table borrower (
	CardNo varchar(50) not null primary key,
	BorrowerName varchar(50) not null,
	BorrowerAddress varchar(100),
	BorrowerPhone varchar(50)
);
go

create table book_loans (
	BookID int not null constraint FK_bookID_loans foreign key references books(BookID) on update cascade on delete cascade,
	BranchID int not null constraint FK_branchID_loans foreign key references library_branch(BranchID) on update cascade on delete cascade,
	CardNo varchar(50) not null constraint FK_cardNo_loans foreign key references borrower(CardNo) on update cascade on delete cascade,
	DateOut date,
	DateIn date
);
go

create table book_copies (
	BookID int not null constraint FK_bookID_copies foreign key references books(BookID) on update cascade on delete cascade,
	BranchID int not null constraint FK_branchID_copies foreign key references library_branch(BranchID) on update cascade on delete cascade,
	Number_Of_Copies int
);
go

/*PART2. DATA INSERTION*/

insert into library_branch(BranchName, BranchAddress)
values
	('Sharpstown', 'Seattle, WA'),
	('Central', 'Central, WA'),
	('Kent', 'Kent, WA'),
	('Tacoma', 'Tacoma, WA'),
	('Renton', 'Renton, WA')
;
go


insert into dbo.publisher (PublisherName, PublisherAddress, PublisherPhone)
values
	('Penguin Random House', 'WA, USA', '205-456-1234'),
	('Hachette Livre', 'CA, USA', '209-354-9084'),
	('Springer Nature', 'AK, USA', '(821) 956-7205'),
	('Scholastic', 'AL, USA', '(256) 763-0645'),
	('Wiley (John Wiley & Sons)', 'AR, USA', '(448) 229-0013')
;
go

insert into books(BookTitle, PublisherName)
values
	('Don Quixote', 'Penguin Random House'),
	('Robinson Crusoe', 'Penguin Random House'),
	('Tom Jones', 'Penguin Random House'),
	('Clarissa','Penguin Random House'),
	('Tristram Shandy','Hachette Livre'),
	('Dangerous Liaisons','Hachette Livre'),
	('Emma','Hachette Livre'),
	('Frankenstein', 'Hachette Livre'),
	('Nightmare Abbey','Springer Nature'),
	('The Black Sheep','Springer Nature'),
	('The Charterhouse of Parma','Springer Nature'),
	('The Count of Monte Cristo','Springer Nature'),
	('Sybil','Scholastic'),
	('David Copperfield','Scholastic'),
	('Wuthering Heights','Scholastic'),
	('Jane Eyre','Scholastic'),
	('Vanity Fair','Wiley (John Wiley & Sons)'),
	('The Lost Tribe','Wiley (John Wiley & Sons)'),
	('The Scarlet Letter','Wiley (John Wiley & Sons)'),
	('Moby-Dick','Wiley (John Wiley & Sons)')
;
go

/* SINCE THE DRILL ASKS TO DEPICT THE GIVEN DIAGRAM, I THOUGHT IT COULD BE MORE EFFICIENT IF THERE WAS AN ID FOR AUTHORS 
AND THAT COULD BE REFERENCED IN BOOK TABLE TO AVOID REPEATATION IN AUTHORS TABLE*/

insert into book_authors(BookID, AuthorName)
values
	(1, 'Stephen King'),
	(9,'Stephen King'),
	(2,'Velma Wallis'),
	(20,'Velma Wallis'),
	(3,'Harper Lee'),
	(19,'Harper Lee'),
	(18, 'John Grisham'),
	(4, 'John Grisham'),
	(5,'Jeannette Walls'),
	(17,'Jeannette Walls'),
	(6,'Joan Didion'),
	(16,'Joan Didion'),
	(7,'Ken Kesey'),
	(15,'Ken Kesey'),
	(8, 'Michael Chabon'),
	(14, 'Michael Chabon'),
	(10,'Alice Walker'),
	(13,'Alice Walker'),
	(11,'William Inge'),
	(12,'William Inge')
;
go


insert into borrower(CardNo, BorrowerName, BorrowerAddress, BorrowerPhone)
values
	('4716-5381-4261-6917','Lucille	Montgomery', 'Renton,WA','(804)796-7009'),
	('5101-9538-6251-5076','Lorraine Douglas','Kent,WA','(415)540-6795'),
	('4716-9580-8781-7157','Viola Moss','Seattle,WA','(440)576-8330'),
	('4916-8356-3769-8469','Regina Olson','Central, WA','(306)967-1523'),
	('4556-0965-6411-0292','Shannon	Malone','Renton','(678)324-3982'),
	('5151-9398-4287-5648','Willie Castro','Tacoma','(317)964-2775'),
	('4916-3616-2296-1739','Amber Maldonado','Seattle','(217)877-4833'),
	('4916-2267-0111-1755','Pauline	Rice','Tacoma','(424)235-3033')
;
go

insert into book_copies(BookID,BranchID,Number_Of_Copies)
values
	(1,1,2), (18, 1,2), (2,1,2), (3,1,2), (4,1,2), (5,1,2), (6,1,2), (7,1,2), (8,1,2), (9,1,2),
	(1,2,2), (9,2,2), (20,2,2), (19,2,2), (18,2,2), (17,2,2), (16,2,2), (15,2,2), (14,2,2), (13,2,2),
	(10,3,2), (11,3,2), (12,3,2), (13,3,2), (14,3,2), (15,3,2), (16,3,2), (17,3,2), (18,3,2), (19,3,2), 
	(1,4,2), (2,4,2), (3,4,2), (4,4,2), (5,4,2), (6,4,2), (7,4,2), (8,4,2), (9,4,2), (10,4,2),
	(20,5,2), (19,5,2), (18,5,2), (17,5,2), (16,5,2), (15,5,2), (14,5,2), (13,5,2), (12,5,2), (11,5,2)
;
go

insert into book_loans(BookID, BranchID, CardNo, DateOut, DateIn)
values
	(20, 5,	'4556-0965-6411-0292',	'2019-02-19', '2019-03-21'),
	(19, 5, '4556-0965-6411-0292', '2019-01-20', '2019-02-19'),
	(18, 5,	'4556-0965-6411-0292', '2018-12-12', '2019-01-11'),
	(17, 5, '4556-0965-6411-0292', '2018-10-10', '2018-11-09'),
	(1, 1, '4556-0965-6411-0292', '2018-09-08', '2018-10-08'),
	(18, 1, '4556-0965-6411-0292', '2019-03-20', '2019-04-19'),
	(2, 1, '4556-0965-6411-0292', '2018-08-07', '2018-09-06'),
	(3,	1,	'4716-5381-4261-6917', '2019-01-04', '2019-02-03'),
	(4,	1,	'4716-5381-4261-6917', '2019-03-02', '2019-04-01'),
	(5,	1,	'4716-5381-4261-6917', '2019-02-19', '2019-03-21'),
	(16, 5,	'4716-5381-4261-6917', '2018-12-10', '2019-01-09'),
	(15, 5, '4716-5381-4261-6917', '2018-06-07', '2018-07-07'),
	(14, 5, '4716-5381-4261-6917', '2018-07-08', '2018-08-07'),
	(13, 5, '4716-5381-4261-6917', '2018-10-10', '2018-11-09'),
	(6, 1, '4716-9580-8781-7157', '2019-02-28', '2019-03-30'),
	(7, 1, '4716-9580-8781-7157', '2019-01-08', '2019-02-07'),
	(8, 1, '4716-9580-8781-7157', '2018-12-09', '2019-01-08'),
	(9, 1, '4716-9580-8781-7157', '2018-04-06', '2018-05-06'),
	(12, 5, '4716-9580-8781-7157', '2018-09-10', '2018-10-10'),
	(11, 5, '4716-9580-8781-7157', '2018-09-27', '2018-10-27'),
	(1, 4, '4916-2267-0111-1755', '2019-02-07', '2019-03-09'),
	(2, 4, '4916-2267-0111-1755', '2018-04-17', '2018-05-17'),
	(10, 3, '4916-2267-0111-1755', '2018-08-22', '2018-09-21'),
	(3, 4, '4916-2267-0111-1755', '2018-09-25', '2018-10-25'),
	(9, 3, '4916-2267-0111-1755', '2018-10-19', '2018-11-18'),
	(4, 4, '4916-2267-0111-1755', '2018-12-05', '2019-01-04'),
	(3, 4, '4916-3616-2296-1739', '2019-02-13', '2019-03-15'),
	(20, 5, '4916-3616-2296-1739', '2018-04-27', '2018-05-27'),
	(19, 5, '4916-3616-2296-1739', '2018-08-17', '2018-09-16'),
	(10, 1, '4916-3616-2296-1739', '2018-10-24', '2018-11-23'),
	(1, 1, '4916-3616-2296-1739', '2018-11-06', '2018-12-06'),
	(2, 1, '4916-3616-2296-1739', '2019-01-21', '2019-02-20'),
	(1, 2, '4916-8356-3769-8469', '2019-03-05', '2019-04-04'),
	(9, 2, '4916-8356-3769-8469', '2018-05-01', '2018-05-31'),
	(20, 2, '4916-8356-3769-8469', '2018-08-02', '2018-09-01'),
	(8, 3, '4916-8356-3769-8469', '2018-12-19', '2019-01-18'),
	(18, 5,'4916-8356-3769-8469', '2018-11-16', '2018-12-16'),
	(4, 4, '4916-8356-3769-8469', '2018-07-30', '2018-08-29'),
	(7, 3, '5101-9538-6251-5076', '2019-03-11', '2019-04-10'),
	(6, 3, '5101-9538-6251-5076','2018-05-29', '2018-06-28'),
	(5, 3, '5101-9538-6251-5076', '2018-07-31', '2018-08-30'),
	(16, 5, '5101-9538-6251-5076', '2018-12-21', '2019-01-20'),
	(5, 4, '5101-9538-6251-5076', '2018-12-04', '2019-01-03'),
	(4, 1, '5101-9538-6251-5076', '2018-09-14', '2018-10-14'),
	(6, 4, '5151-9398-4287-5648', '2019-03-21', '2019-04-20'),
	(7, 4, '5151-9398-4287-5648', '2018-06-04', '2018-07-04'),
	(8, 4, '5151-9398-4287-5648', '2018-07-16', '2018-08-15'),
	(4, 3, '5151-9398-4287-5648', '2018-10-22', '2018-11-21'),
	(17, 5, '5151-9398-4287-5648', '2018-09-13', '2018-10-13'),
	(3, 1, '5151-9398-4287-5648', '2018-10-02', '2018-11-01')
;
go

/*PART3 - PROCEDURE CREATION */


/*1.) How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?*/

create proc TheLostTribe_Sharptown 
as
Select 
	t1.BookTitle, t2.BranchName, t2.BranchAddress
	from books t1
	inner join library_branch t2 on BookID= t1.BookID
	where BookTitle =  'The Lost Tribe' and BranchName='Sharpstown'
go


/*2.)How many copies of the book titled "The Lost Tribe" are owned by each library branch?*/
/*The book "The Lost Tribe" ID is 18*/
create proc TheLostTribe_Count
as
	select count(BookID)  from book_copies where BookID = 18 

go


/*3.) Retrieve the names of all borrowers who do not have any books checked out.*/
create proc CheckOut
as
	select * from borrower where CardNo not in (select CardNo from book_loans)

go


/*4.) For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.*/
create proc Sharpstown
as
	select t1.BranchName, t2.BookTitle, t3.DateOut, t3.DateIn, t4.BorrowerName, t4.BorrowerAddress
	from
	library_branch t1
	inner join book_loans t3 on t3.BranchID=t1.BranchID
	inner join books t2 on t2.BookID=t3.BookID
	inner join borrower t4 on t4.CardNo = t3.CardNo
	
	where 
	BranchName='Sharpstown' and DateIn = '2019-03-22'
go


/*5.) For each library branch, retrieve the branch name and the total number of books loaned out from that branch.*/
CREATE PROC BRANCH_COUNT
AS
SELECT COUNT(CASE WHEN BranchID = 1 THEN 1
                  ELSE NULL
             END) AS 'Sharpstown'
       ,COUNT(CASE WHEN BranchID = 2 THEN 1
                   ELSE NULL
              END) AS 'Central'
		,COUNT(CASE WHEN BranchID = 3 THEN 1
                   ELSE NULL
              END) AS 'Kent'
		,COUNT(CASE WHEN BranchID = 4 THEN 1
                   ELSE NULL
              END) AS 'Tacoma'
		,COUNT(CASE WHEN BranchID = 5 THEN 1
                   ELSE NULL
              END) AS 'Renton'

    FROM book_loans
	
go


/*6.) Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out.*/
create proc book_loan_count
as
	select t1.BorrowerName, t1.BorrowerAddress, count(t2.CardNo) as 'Number of books loaned'
	from borrower t1
	inner join book_loans t2 on t2.CardNo=t1.CardNo
	group by t1.BorrowerName, t1.BorrowerAddress
	having COUNT(t2.CardNo)>5

go


/*7.) For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".*/
create proc Stephen_King
as
	select t1.BookTitle, t2.Number_Of_Copies

	from books t1
	inner join book_authors t3 on t3.BookID = t1.BookID
	inner join book_copies t2 on t2.BookID = t1.BookID
	inner join library_branch t4 on t4.BranchID = t2.BranchID

	where t3.AuthorName = 'Stephen King' and t4.BranchName='Central'
