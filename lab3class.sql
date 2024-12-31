--THIS IS LAB 3 AND THIS LAB IS ON DATA QUERY LANGUAGE DQL
--CREATE DATABASE BCT;
USE BCT;

-- Drop tables if they already exist
DROP TABLE issue;
DROP TABLE phoneNo;
DROP TABLE book;
DROP TABLE student;

-- Parent table: student
CREATE TABLE student (
    s_id INT PRIMARY KEY,
    s_fname VARCHAR(50),
    s_lname VARCHAR(50),
    s_municipality VARCHAR(50),
    s_wardNo INT,
    s_city VARCHAR(50)
);
CREATE TABLE phonedetails (
	ph_id INT,
	simType VARCHAR(10),
	phoneNo BIGINT,
	balance INT,
	s_id INT FOREIGN KEY REFERENCES student(s_id)
	);
-- Book table: contains details of books
CREATE TABLE book (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(100),
    author VARCHAR(50),
    price DECIMAL(8,2),
	s_id INT,
	FOREIGN KEY (s_id) REFERENCES student(s_id) ON DELETE CASCADE ON UPDATE SET NULL,
);

-- Issue table: child table for 1:M relationship
CREATE TABLE issue (
    issue_id INT PRIMARY KEY,
    s_id INT, -- Foreign key referencing student
    book_id INT, -- Foreign key referencing book
    issue_date DATE,
    return_date DATE,
    FOREIGN KEY (s_id) REFERENCES student(s_id) ON DELETE CASCADE ON UPDATE SET NULL,
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE ON UPDATE SET NULL
);

-- Insert data into student table
INSERT INTO student VALUES (1, 'Dipson', 'Adhikari', 'Mulpani', 6, 'Kathmandu');
INSERT INTO student VALUES (2, 'Bipana', 'Ranabhat', 'Kalanki', 9, 'Kathmandu');
INSERT INTO student VALUES (3, 'Dikshya', 'Shrestha', 'Jamal', 5, 'Kathmandu');
INSERT INTO student VALUES (4, 'Dipesh', 'Pradhan', 'Jorpati', 5, 'Kathmandu');
INSERT INTO student VALUES (5, 'Don', 'Sharma', 'Jamal', 5, 'Kathmandu');
INSERT INTO student VALUES (6, 'Danger', 'KC', 'Jamal', 5, 'Kathmandu');
INSERT INTO student VALUES (7, 'Ram', 'Thapa', 'Jamal', 5, 'Kathmandu');
INSERT INTO student VALUES (8, 'Rakesh', 'Jha', 'Jamal', 5, 'Kathmandu');
INSERT INTO student VALUES (9, 'Alex', 'Magar', 'Jamal', 5, 'Kathmandu');
INSERT INTO student VALUES (10, 'Rupesh', 'Magar', 'Jamal', 5, 'Kathmandu');

INSERT INTO phonedetails VALUES(1,'NTC',98400,500,1);
INSERT INTO phonedetails VALUES(1,'NTC',98500,50,1);
INSERT INTO phonedetails VALUES(2,'NCELL',98600,80,2);
INSERT INTO phonedetails VALUES(1,'NCELL',98800,500,2);
INSERT INTO phonedetails VALUES(3,'NTC',98500,50,3);
INSERT INTO phonedetails VALUES(1,'NCELL',98500,50,4);
INSERT INTO phonedetails VALUES(4,'JIO',99500,550,3);
INSERT INTO phonedetails VALUES(1,'NTC',96500,50,4);
INSERT INTO phonedetails VALUES(3,'AIRTEL',94500,50,5);
INSERT INTO phonedetails VALUES(3,'AIRTEL',96800,50,5);



-- Insert data into book table
INSERT INTO book VALUES (101, 'Database Systems', 'Navathe', 500.00,1);
INSERT INTO book VALUES (102, 'Operating Systems', 'Galvin', 600.00,2);
INSERT INTO book VALUES (103, 'Data Structures', 'Weiss', 450.00,3);
INSERT INTO book VALUES (104, 'Computer Networks', 'Tanenbaum', 700.00,4);
INSERT INTO book VALUES (105, 'Discrete Structure', 'A', 800.00,5);
INSERT INTO book VALUES (106, 'Maths', 'B', 900.00,6);
INSERT INTO book VALUES (107, 'Science ', 'C', 200.00,7);
INSERT INTO book VALUES (108, 'Social', 'D', 300.00,8);
INSERT INTO book VALUES (109, 'GK', 'E', 400.00,9);
INSERT INTO book VALUES (110, 'Nepali', 'F', 500.00,10);

EXEC sp_rename 'student','studentinfos';
--EXEC sp_rename 'studentinfos.s_fname','sFname','column';

CREATE TABLE studenttest(
s_id int,
s_name varchar(50)
);
INSERT INTO studenttest SELECT s_id,s_fname FROM studentinfos;
TRUNCATE TABLE studenttest;
--COPY the details of the student into student destination only if student municipality is Jamal.
INSERT INTO studenttest SELECT s_id,s_fname FROM studentinfos WHERE studentinfos.s_municipality='Jamal';

-- Insert data into issue table (1:M relationship)
INSERT INTO issue (issue_id,s_id, book_id, issue_date, return_date) VALUES (555,1, 101, '2024-06-01', '2024-06-15');
INSERT INTO issue (issue_id,s_id, book_id, issue_date, return_date) VALUES (556,1, 102, '2024-06-05', '2024-06-20');
INSERT INTO issue (issue_id,s_id, book_id, issue_date, return_date) VALUES (557,2, 103, '2024-06-10', '2024-06-25');
INSERT INTO issue (issue_id,s_id, book_id, issue_date, return_date) VALUES (558,3, 104, '2024-06-12', '2024-06-30');

-- Testing ON DELETE CASCADE
DELETE FROM student WHERE s_id = 2; -- Deletes Bipana and her issue records

-- Testing ON UPDATE SET NULL
UPDATE book SET book_id = 200 WHERE book_id = 101; -- Sets book_id in issue table to NULL for 101

-- Select data to verify
--SELECT s_fname,s_municipality FROM studentinfos;
--DISPLAY STUDENT NAME AND MUNICIPALITY WHO BELONGS TO JAMAL MUNICIPALITY
--SELECT s_fname,s_municipality FROM studentinfos WHERE s_municipality!='Jamal';
--DISPLAY THAT AND WARD NO ....
SELECT s_fname,s_municipality FROM studentinfos WHERE s_municipality='Jamal 'AND s_wardNo=5;
--DISPLAY ALL DETAILS OF STUDENT IF HE BELONGS TO JAMAL, MULPANI MUNICIPALITY
SELECT s_fname,s_municipality FROM studentinfos WHERE s_municipality='Jamal 'OR s_municipality='Mulpani ';
--display ALL BOOKS NAME IF THE PRICE IS BETWEEN 100 TO 400
SELECT * FROM book WHERE price BETWEEN 100 AND 300;
--SELECT * FROM book WHERE price>100 AND PRICE<400;--NOT AS TOLD BY SIR
SELECT s_municipality FROM studentinfos;
--SELECT DISTINCT MUNI FROM STUDENT INFOS
SELECT DISTINCT s_municipality FROM studentinfos;
--DISPLAY 
SELECT * FROM studentinfos WHERE s_municipality IN ('Jamal','Mulpani');

INSERT INTO studentinfos VALUES (15, 'RAKESH', 'Magar', NULL, 5, 'Kathmandu');
--WHERE STUDENT MUNI IS NULL
SELECT * FROM studentinfos WHERE s_municipality IS NULL;
--LIKE(SELECT STUDENT FROM WHOSE NAME STARTS FROM D
SELECT * FROM studentinfos WHERE s_fname NOT LIKE'D%';
--ENDS IN MUNICIPALIY (NI) KO STUDENT KO DETAIL
--starts with j and ends with l
SELECT * FROM studentinfos WHERE s_municipality LIKE'j%l';
--order by(display student details in such a way that detials of students are displayed in alpahabetical order 
SELECT *FROM studentinfos ORDER BY s_fname;
--book ko price anusar ascending
SELECT *FROM book ORDER BY price;
--desc
SELECT *FROM book ORDER BY price DESC;
--SAME 2 DATA 
INSERT INTO studentinfos VALUES (18, 'Dipson', 'Adhikari', 'Mulpani', 6, 'Bhaktapur');
INSERT INTO studentinfos VALUES (23, 'Bipana', 'Ranabhat', 'Kalanki', 9, 'Bhaktapur');
INSERT INTO studentinfos VALUES (35, 'Dikshya', 'Shrestha', 'Jamal', 5, 'Bhaktapur');
SELECT *FROM studentinfos WHERE s_fname='Dipson' ORDER BY s_city;
SELECT TOP 3 * FROM book;
--top 3 according to highest price 
SELECT TOP 3 * FROM book ORDER BY price;
SELECT * FROM studentinfos;
SELECT *FROM phonedetails;
SELECT * FROM issue;
SELECT * FROM studenttest;
