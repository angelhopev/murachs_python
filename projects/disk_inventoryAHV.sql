/*Angel Hope D. Valdez
Project 4
13 Oct 2023*/
--PROJECT #2
USE master;
GO
DROP DATABASE IF EXISTS diskinventoryAHV;
GO
CREATE DATABASE diskinventoryAHV;
GO
USE diskinventoryAHV;
GO

--Create login, user, & grant read permission
IF SUSER_ID('diskUserAHV') IS NULL
	CREATE LOGIN diskUserAHV 
	WITH PASSWORD = 'MSPress#1',
	DEFAULT_DATABASE = diskinventoryAHV;
CREATE USER diskUserAHV
ALTER ROLE db_datareader
	ADD MEMBER diskUserAHV;
GO

--Create lookup tables
CREATE TABLE artist_type
	(
	artist_type_id		INT NOT NULL PRIMARY KEY IDENTITY,
	description			VARCHAR(20) NOT NULL UNIQUE
	);
GO

CREATE TABLE disk_type
	(
	disk_type_id		INT NOT NULL PRIMARY KEY IDENTITY,
	description			VARCHAR(20) NOT NULL UNIQUE
	);
GO

CREATE TABLE genre
	(
	genre_id			INT NOT NULL PRIMARY KEY IDENTITY,
	description			VARCHAR(20) NOT NULL UNIQUE
	);
GO

CREATE TABLE status
	(
	status_id			INT NOT NULL PRIMARY KEY IDENTITY,
	description			VARCHAR(20) NOT NULL UNIQUE
	);
GO

-- borrower, disk, artist
CREATE TABLE borrower
	(
	borrower_id		INT NOT NULL PRIMARY KEY IDENTITY,
	fname			NVARCHAR(60) NOT NULL,
	lname			NVARCHAR(60) NOT NULL,
	phone_num		VARCHAR(15) NOT NULL
	);
	GO

CREATE TABLE disk
	(
	disk_id			INT NOT NULL PRIMARY KEY IDENTITY,
	disk_name		NVARCHAR(60) NOT NULL,
	release_date	date NOT NULL,
	genre_id		INT NOT NULL REFERENCES genre(genre_id),
	status_id		INT NOT NULL REFERENCES status(status_id),
	disk_type_id	INT NOT NULL REFERENCES disk_type(disk_type_id)
	);
	GO

CREATE TABLE artist
	(
	artist_id		INT NOT NULL PRIMARY KEY IDENTITY,
	fname			NVARCHAR(60) NOT NULL,
	lname			NVARCHAR(60) NULL,
	artist_type_id	INT NOT NULL REFERENCES artist_type(artist_type_id)
	);
	GO

--Create relationship tables
CREATE TABLE disk_has_borrower
	(
	disk_has_borrower_id	INT NOT NULL PRIMARY KEY IDENTITY,
	borrowed_date			datetime2 NOT NULL,
	due_date				datetime2 NOT NULL DEFAULT (GETDATE() + 30),
	returned_date			datetime2 NULL,
	borrower_id				INT NOT NULL REFERENCES borrower (borrower_id),
	disk_id					INT NOT NULL REFERENCES disk(disk_id)
	);
	GO
CREATE TABLE disk_has_artist
	(
	disk_has_artist_id	INT NOT NULL PRIMARY KEY IDENTITY,
	disk_id				INT NOT NULL REFERENCES disk(disk_id),
	artist_id			INT NOT NULL REFERENCES artist(artist_id)
	UNIQUE (disk_id, artist_id)
	);
	GO

--PROJECT #3
-- Disk Type
INSERT INTO disk_type (description)
VALUES
    ('CD'),
    ('Vinyl'),
    ('DVD'),
    ('Blu-ray'),
    ('Digital Download');

-- Genre
INSERT INTO genre (description)
VALUES
    ('Rock'),
    ('Pop'),
    ('Hip-Hop'),
    ('Country'),
    ('Classical');

-- Status
INSERT INTO status (description)
VALUES
    ('Available'),
    ('Borrowed'),
    ('Damaged'),
    ('Lost'),
    ('On Hold');

-- DISK TABLE
--Task D.1 DISK TABLE: 20 rows of data
INSERT INTO disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
    ('Abbey Road', '1969-09-26', 1, 1, 1),
    ('Thriller', '1982-11-30', 2, 1, 1),
    ('The Dark Side of the Moon', '1973-03-01', 1, 1, 1),
    ('Back in Black', '1980-07-25', 1, 1, 1),
    ('Rumours', '1977-02-04', 2, 1, 1),
	('In Black', '1981-07-25', 1, 1, 1),
	('Road', '1970-09-26', 1, 1, 1),
    ('Roller', '1983-11-30', 2, 1, 1),
    ('The Dark', '1974-03-01', 1, 1, 1),
    ('Back in Black', '1981-07-25', 1, 1, 1),
    ('Ours', '1978-02-04', 2, 1, 1),
	('In the Back', '1990-07-25', 1, 1, 1),
	('Be Road', '1976-01-26', 1, 1, 1),
    ('Thrill', '1985-12-30', 2, 1, 1),
    ('The Moon', '1973-05-01', 1, 1, 1),
    ('Back', '1980-08-25', 1, 1, 1),
    ('Murs', '1977-02-04', 2, 1, 1),
	('Bin', '1980-07-30', 1, 1, 1),
	('Mourns', '1990-02-04', 2, 1, 1),
	('Brick', '2000-07-25', 1, 1, 1);

--Task D.2. Update only 1 row using a where clause
UPDATE disk
SET disk_name = 'Disco'
WHERE disk_id = 1;

--Task D.3. 1 disk has only 1 word in the name
INSERT INTO disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Solo', '2020-08-15', 3, 1, 1);

--Task D.4. At least 1 disk has only 2 words in the name
INSERT INTO disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Greatest Hits', '1990-05-10', 4, 1, 1);

--Task D.5. At least 1 disk has more than 2 words in the name
INSERT INTO disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('The Best of Classic Rock', '2005-12-20', 1, 1, 1);

--BORROWER TABLE
-- TASK E.1. Insert at least 21 rows of data into the table using real-world borrower names
INSERT INTO borrower (fname, lname, phone_num)
VALUES
    ('John', 'Doe', '123-456-7890'),
    ('Jane', 'Smith', '987-654-3210'),
    ('Michael', 'Johnson', '555-123-7890'),
    ('Emily', 'Williams', '333-333-3333'),
	('William', 'Johnson', '777-888-9999'),
    ('Samantha', 'Brown', '555-123-7890'),
    ('David', 'Lee', '123-123-1234'),
    ('Michelle', 'Garcia', '987-654-3210'),
    ('Robert', 'Miller', '111-222-3333'),
	('Sarah', 'Davis', '333-444-5555'),
    ('Joseph', 'Anderson', '777-666-5555'),
    ('Linda', 'Wilson', '222-999-4444'),
	('James', 'Taylor', '888-888-8888'),
    ('Donna', 'Harris', '777-777-7777'),
    ('Richard', 'Clark', '666-666-6666'),
    ('Mary', 'Lewis', '999-999-9999'),
    ('Paul', 'Young', '111-111-1111'),
    ('Carol', 'Hall', '222-222-2222'),
    ('Mark', 'White', '333-333-3333'),
    ('Susan', 'Turner', '444-444-4444'),
    ('Kevin', 'Moore', '555-555-5555');

-- Task E.2.
DELETE FROM borrower
WHERE borrower_id = 21;

-- DiskHasBorrower table
-- Task F.1.
INSERT INTO disk_has_borrower (borrowed_date, due_date, returned_date, borrower_id, disk_id)
VALUES
	('2023-03-01', '2023-03-31', '2023-01-06', 2, 1),
	('2023-05-01', '2023-05-31', '2023-01-06', 1, 2),
	('2023-01-01', '2023-01-31', '2023-01-06', 1, 2),
	('2023-01-01', '2023-01-31', '2023-01-06', 3, 1),
	('2023-07-01', '2023-07-31', '2023-01-06', 4, 1),
	('2023-01-01', '2023-01-31', NULL, 5, 6),
	('2023-01-01', '2023-01-31', NULL, 5, 7),
	('2023-01-01', '2023-01-31', NULL, 7, 8),
	('2023-01-01', '2023-01-31', NULL, 8, 9),
	('2023-01-01', '2023-01-31', NULL, 9, 10),
	('2020-10-01', '2020-10-31', '2023-01-06', 10, 3),
	('2001-12-01', '2001-12-31', '2023-01-06', 11, 4),
	('2000-03-01', '2000-03-31', '2023-01-06', 12, 5),
	('2004-07-01', '2004-07-31', '2023-01-06', 10, 12),
	('2005-08-01', '2005-08-31', '2023-01-06', 1, 12),
	('2012-12-01', '2012-12-31', '2023-01-06', 2, 1),
	('2013-10-01', '2013-10-31', '2023-01-06', 3, 11),
	('2014-07-01', '2014-07-31', '2023-01-06', 4, 13),
	('2015-02-01', '2015-03-03', '2023-01-06', 4, 14),
	('2016-01-01', '2016-01-31', '2023-01-06', 5, 15);

--TASK G
SELECT borrower_id, disk_id, borrowed_date, returned_date 
FROM disk_has_borrower
WHERE returned_date IS NULL;

--with date FORMAT
/*SELECT borrower_id, disk_id, FORMAT (borrowed_date, 'dd-MM-yy') as borrowedDate, FORMAT (returned_date, 'dd-MM-yy') as returnedDate
FROM disk_has_borrower
WHERE returned_date IS NULL;*/

--PROJECT #4
/* Modification Log:
-- 1. Created a new view, View_Borrower_No_Loans_Join.
-- 2. Created a new view, View_Borrower_No_Loans_SubQ.
-- 3. Added queries to show borrowers who have borrowed more than 1 disk.*/

-- Query 1: Show all disks in your database, the type, & status.
SELECT d.disk_name AS "Disk Name",
       d.release_date AS "Release Date",
       dt.description AS "Type",
       g.description AS "Genre",
       s.description AS "Status"
FROM disk d
JOIN disk_type dt ON d.disk_type_id = dt.disk_type_id
JOIN genre g ON d.genre_id = g.genre_id
JOIN status s ON d.status_id = s.status_id;
GO

-- Query 2: Show all borrowed disks and who borrowed them.
SELECT b.lname AS "Last",
       b.fname AS "First",
       d.disk_name AS "Disk Name",
       dhb.borrowed_date AS "Borrowed Date",
       dhb.returned_date AS "Returned Date"
FROM disk_has_borrower dhb
JOIN borrower b ON dhb.borrower_id = b.borrower_id
JOIN disk d ON dhb.disk_id = d.disk_id;
GO

-- Query 3: Show the disks that have been borrowed more than once.
SELECT d.disk_name AS "Disk Name",
       COUNT(*) AS "Times Borrowed"
FROM disk_has_borrower dhb
JOIN disk d ON dhb.disk_id = d.disk_id
GROUP BY d.disk_name
HAVING COUNT(*) > 1;
GO

-- Query 4: Show the disks outstanding or on-loan and who took each disk.
SELECT d.disk_name AS "Disk Name",
       dhb.borrowed_date AS "Borrowed",
       CASE
           WHEN dhb.returned_date IS NULL THEN 'Outstanding'
           ELSE 'Returned'
       END AS "Returned",
       b.lname AS "Last Name",
       b.fname AS "First Name"
FROM disk_has_borrower dhb
JOIN disk d ON dhb.disk_id = d.disk_id
JOIN borrower b ON dhb.borrower_id = b.borrower_id
WHERE dhb.returned_date IS NULL;
GO

-- Query 5: Create a view called View_Borrower_No_Loans_Join.
IF EXISTS(SELECT 1 FROM sys.views WHERE Name = 'View_borrower_No_Loans_Join')
DROP VIEW dbo.View_borrower_No_Loans_Join
GO

CREATE VIEW View_Borrower_No_Loans_Join
AS
SELECT b.lname AS [Last Name],
       b.fname AS [First Name]
FROM borrower b
LEFT JOIN disk_has_borrower dhb ON b.borrower_id = dhb.borrower_id
WHERE dhb.borrowed_date IS NULL;
GO

-- Query 6: Create a view called View_Borrower_No_Loans_SubQ.
IF EXISTS(SELECT 1 FROM sys.views WHERE Name = 'View_borrower_No_Loans_SubQ')
DROP VIEW dbo.View_borrower_No_Loans_SubQ
GO

CREATE VIEW View_Borrower_No_Loans_SubQ
AS
SELECT b.lname AS [Last Name],
       b.fname AS [First Name]
FROM borrower b
WHERE NOT EXISTS (
    SELECT 1
    FROM disk_has_borrower dhb
    WHERE dhb.borrower_id = b.borrower_id
);
GO

-- Query 7: Show the borrowers who have borrowed more than 1 disk.
SELECT b.lname AS "Last Name",
       b.fname AS "First Name",
       COUNT(*) AS "Disks Borrowed"
FROM disk_has_borrower dhb
JOIN borrower b ON dhb.borrower_id = b.borrower_id
GROUP BY b.lname, b.fname
HAVING COUNT(*) > 1;
GO
