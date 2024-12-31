--CREATE DATABASE LAB4;
USE LAB4;
--DQL With complex queries
DROP TABLE issuebt;
DROP TABLE issuebs;
DROP TABLE book;
DROP TABLE student;
DROP TABLE teacher;
CREATE TABLE book(
bid INT PRIMARY KEY,
bname VARCHAR(50),
publication VARCHAR(50),
author VARCHAR(50),
price DECIMAL(8,2)
);
CREATE TABLE student(
sid INT PRIMARY KEY,
sfname VARCHAR(50),
slname VARCHAR(50),
sbranch VARCHAR(50),
address VARCHAR(50)
);
CREATE TABLE teacher(
tid INT PRIMARY KEY,
tfname VARCHAR(50),
tlname VARCHAR(50),
tbranch VARCHAR(50),
tsalary BIGINT,
hid INT FOREIGN KEY REFERENCES teacher(tid),
specialization VARCHAR(50)
);
--CREATE TABLE issue(
--iid INT PRIMARY KEY,
--bid INT FOREIGN KEY REFERENCES book(bid),
--sid INT FOREIGN KEY REFERENCES student(sid) ON DELETE CASCADE ON UPDATE SET NULL,
--tid INT FOREIGN KEY REFERENCES teacher(tid) ON DELETE CASCADE ON UPDATE SET NULL,
--dateOfIssue DATE,
--);
CREATE TABLE issuebs(
bid INT FOREIGN KEY REFERENCES book(bid),
sid INT FOREIGN KEY REFERENCES student(sid),
dateofIssue DATE,
PRIMARY KEY(bid,sid)
);
CREATE TABLE issuebt(
bid INT FOREIGN KEY REFERENCES book(bid),
tid INT FOREIGN KEY REFERENCES teacher(tid),
dateofIssue DATE,
PRIMARY KEY(bid,tid)
);
INSERT INTO book VALUES (101, 'Database Systems','Hamro Publication', 'Navathe', 500.00);
INSERT INTO book VALUES (102, 'Operating Systems', 'Modern Pub','Galvin', 600.00);
INSERT INTO book VALUES (103, 'Data Structures','AdvancePub', 'Weiss', 450.00);
INSERT INTO book VALUES (104, 'Computer Networks', 'Apub','Tanenbaum', 700.00);
INSERT INTO book VALUES (105, 'Discrete Structure','Bpub', 'Anthony', 800.00);
INSERT INTO book VALUES (106, 'Maths', 'Cpub','Bob', 900.00);
INSERT INTO book VALUES (107, 'Science ', 'Dpub','Casey', 200.00);
INSERT INTO book VALUES (108, 'Social', 'Epub','Donald', 300.00);
INSERT INTO book VALUES (109, 'GK', 'Fpub','Emerald', 400.00);
INSERT INTO book VALUES (110, 'Nepali','Gpub', 'Franklin', 500.00);

INSERT INTO book VALUES (111, 'NewBook','Gpub', 'Franklin', 500.00);
INSERT INTO book VALUES (112, 'NoBook','Gpub', 'Franklin', 500.00);
INSERT INTO book VALUES (113, 'NewNepali','Epub', 'Franklin', 500.00);
INSERT INTO book VALUES (114, 'Grammar','Epub', 'Franklin', 500.00);
INSERT INTO book VALUES (115, 'ARTIFICIALINTELLIGENCE','Apub', 'Sujan', 500.00);
INSERT INTO student VALUES  (1, 'Dipson','Adhikari', 'BCT', 'Kageshowri Manohara'),
							(2, 'Bipana','Ranabhat', 'BCE','Kathmandu'),
							(3, 'Dikshya', 'Shrestha','BCT', 'Kathmandu'),
							(4,'Abhiyan','Paudel','BEX','Swayambhu'),
							(5,'Aashutosh','Jha','BEI','Kritipur'),
							(6,'Abhinav','Sharma','BCT','Tokha'),
							(7,'Adrin','Pradhan','BEI','Pokhara'),
							(8,'Bishranta','Paudel','BEX','Chitwan'),
							(9,'Aashutosh','Paudel','BCT','Jamal'),
							(10,'Isha','Karki','BAG','Tokha');

INSERT INTO teacher VALUES  (1, 'Dhawa','Adhikari', 'BCT', 100000,1,'AI'),
							(2, 'Sujan','Ranabhat', 'BCE',200000,1,'DATABASE'),
							(3, 'Ritu', 'Shrestha','BCT',300000, 2,'OS'),
							(4,'Sharad','Paudel','BEX',400000,4,'AI'),
							(5,'Nabin','Jha','BEI',500000,4,'PROGRAMMING'),
							(6,'Anju','Sharma','BCT',600000,4,'SoftwareEngineering'),
							(7,'Aman','Pradhan','BEI',700000,4,'DATABASE'),
							(8,'Rubi','Paudel','BEX',800000,4,'DigitalLogic'),
							(9,'Nikesh','Paudel','BCT',900000,10,'PROGRAMMING'),
							(10,'Ravi','Karki','BAG',950000,10,'EMBEDDED');

INSERT INTO issuebs VALUES (102,1,'2024-06-01'),
							(101,1,'2024-06-01'),
							(103,2,'2024-06-05'),
							(104,2,'2024-06-05'),
							(105,3,'2024-06-06'),
							(106,4,'2024-06-03'),
							(107,5,'2024-06-01'),
							(108,6,'2024-06-07'),
							(109,7,'2024-06-03'),
							(110,9,'2024-06-06'),
							(111,4,'2024-06-11'),
							(112,5,'2024-06-21'),
							(113,9,'2024-06-29'),
							(114,2,'2024-06-14');

					
INSERT INTO issuebt VALUES (102,1,'2024-05-01'),
							(101,1,'2024-05-01'),
							(103,2,'2024-05-05'),
							(104,2,'2024-08-05'),
							(105,3,'2024-08-06'),
							(106,4,'2024-08-03'),
							(107,5,'2024-05-01'),
							(108,6,'2024-08-07'),
							(109,7,'2024-05-03'),
							(110,9,'2024-07-06'),
							(111,4,'2024-02-11'),
							(112,5,'2024-02-21'),
							(113,9,'2024-01-31'),
							(114,2,'2024-03-14');
--cross product
SELECT *FROM book,issuebs;
--detail of student who has issued book
SELECT *FROM student,issuebs WHERE student.sid=issuebs.sid;--this also ok but dont do this in examination
--next method
SELECT *FROM student
		JOIN issuebs ON student.sid=issuebs.sid;
--using alias
SELECT *FROM student s
		JOIN issuebs i ON s.sid=i.sid;
--only the detail of aashutosh
SELECT *FROM student s
		JOIN issuebs i ON s.sid=i.sid
		WHERE sfname='Aashutosh';
--book nalani ko xa??
SELECT *FROM student s
LEFT OUTER JOIN issuebs i ON s.sid=i.sid;
--RIGHT AND FULL ALSO
SELECT *FROM student s
RIGHT OUTER JOIN issuebs i ON s.sid=i.sid;

SELECT *FROM student s
FULL OUTER JOIN issuebs i ON s.sid=i.sid;

--SELF JOIN DISPLAY TEACHER NAME ALONG WITH HEAD NAME
SELECT *FROM teacher t
		JOIN teacher h ON t.hid=h.tid;

SELECT t.tfname AS teachername,h.tfname AS headName FROM teacher t
		JOIN teacher h ON t.hid=h.tid;		

--display the name of teacher who has also issued a book
SELECT * FROM teacher t
		JOIN book b on t.tfname=b.author;

--display student name who had issued book on which date
SELECT bname,sfname,slname,dateofissue FROM issuebs ibs
		JOIN book b ON b.bid=ibs.bid
		JOIN student s ON ibs.sid=s.sid;
--display yo din ko 
SELECT bname,sfname,slname,dateofissue FROM issuebs ibs
		JOIN book b ON b.bid=ibs.bid
		JOIN student s ON ibs.sid=s.sid
		WHERE dateofIssue='2024-06-01';
--display sab teacher ko naam and student ko naam
SELECT sfname FROM student
		UNION
SELECT tfname FROM teacher;
--student as well as teacher intersect
INSERT INTO teacher VALUES  (15, 'Dipson','Adhikari', 'BCT', 100000,1,'AI');
SELECT sfname FROM student
		INTERSECT
SELECT tfname FROM teacher;
--TEACHER BUT NOT STUDENT
SELECT sfname FROM student
		EXCEPT
SELECT tfname FROM teacher;
--DISPLAY ALL THE TEACHER AND STUDENT NAME WHO HAS ISSUED BOOK ON THIS DATE 
SELECT bname AS bookName,sfname AS personName FROM issuebs ibs
		JOIN book b ON b.bid=ibs.bid
		JOIN student s ON ibs.sid=s.sid
		WHERE dateofIssue='2024-06-01' --OR dateofIssue='2024-05-01'
UNION
SELECT bname,tfname FROM issuebt ibt
		JOIN book b ON b.bid=ibt.bid
		JOIN teacher t ON ibt.tid=t.tid
		WHERE dateofIssue='2024-06-01'; --OR dateofIssue='2024-05-01';
--specialization
--ASSIGNMENT do any realistic system




SELECT *FROM issuebt;
SELECT *FROM issuebs;
SELECT *FROM student;
SELECT *FROM teacher;
SELECT *FROM book;

--INSERT INTO issue VALUES (1001,101,NULL,2,'2024-06-01'),
	--					(1002,102,1,NULL,'2024-06-02'),
		--				(1003,103,7,NULL,'2024-06-03'),
			--			(1004,104,NULL,9,'2024-06-04'),
				--		(1005,105,5,NULL,'2024-06-05'),
					--	(1006,106,NULL,8,'2024-06-06'),
						--(1007,107,8,NULL,'2024-06-07'),
						--(1008,108,NULL,6,'2024-06-08'),
						--(1009,109,3,NULL,'2024-06-09'),
						--(1010,110,NULL,5,'2024-06-10');
--1.Update the salary of teacher by 10% if teacher earns in between 110000 to 140000, by 5% if teacher earns more than 140000 else by 20% (1)
UPDATE teacher SET tsalary = CASE WHEN tsalary>110000 AND tsalary<140000 THEN 1.1*tsalary
								WHEN tsalary>140000 THEN 1.05*tsalary
								ELSE 1.2*tsalary
								END
--2.What is the maximum salary of teacher, total salary of all teachers, no of teachers getting salary, minimun salary of teacher, average salary of teachers(5)
SELECT  MAX(tsalary) FROM teacher;
SELECT  MAX(tsalary) AS maximun_salary FROM teacher;
SELECT  SUM(tsalary) AS TOTAL_SALARY FROM teacher;
SELECT  COUNT(tsalary)AS noOfPeopleGettingSalary FROM teacher;
SELECT  MIN(tsalary) AS minimumSalary FROM teacher;
SELECT  AVG(tsalary) AS averageSalary FROM teacher;

--3.Display the detials of all the teachers with maximum salary(1)
SELECT *FROM teacher WHERE tsalary=(SELECT MAX(tsalary) FROM teacher);  
--4.Display the detials of teacher with 2nd maximum salary(1)
SELECT MAX (tsalary) AS SecondMaxSalary FROM teacher WHERE tsalary<(SELECT MAX(tsalary) FROM teacher);
--5.Display the count of the book according to the book publisher/ publication (1)
SELECT publication,COUNT(bid) AS BOOKCOUNT FROM book GROUP BY publication ;

--5.2Display the count of the book according to the book publisher/publication having count greater than 2(1)
SELECT publication,COUNT(bid) AS BOOKCOUNT FROM book GROUP BY publication HAVING COUNT(bid)>2;
--6.Display the count of the book according to the book publisher/publication and author (1)
SELECT publication,author,COUNT(bid) AS BOOKCOUNT FROM book GROUP BY publication,author ;
--6.2Display the count of the book according to the book author and  publisher/publication(reverse)(1)
SELECT author,publication,COUNT(bid) AS BOOKCOUNT FROM book GROUP BY author,publication ;





SELECT *FROM student;
SELECT *FROM teacher;
SELECT *FROM book;
--1.Update the price of book by 10% if the price of the book is in between 300 to 600 , by 5% if the price of the book is more than 600 else increase the price of the book by 20%. 
UPDATE book SET price= CASE WHEN price>300 AND price<600 
							THEN 1.1*price
							WHEN price>600 
							THEN 1.05*price
							ELSE 1.2*price
							END

--2. What is the maximum price of the book, total price of all books, no of books, minimum price of the book and average price of books.
SELECT MAX(price) AS maximumPriceOfBook FROM book;
SELECT SUM(price) AS totalPriceOfAllBooks FROM book;
SELECT COUNT(price) AS noOfBooks FROM book;
SELECT MIN(price) AS minimumPriceOfBook FROM book;
SELECT AVG(price) AS averagePriceOfBooks FROM book;

--3. Display the detials of books with maximum price
SELECT *FROM book WHERE price=(SELECT MAX(price) FROM book);
--4. Display the details of book with 2nd maximum price 
SELECT * FROM book WHERE price=(SELECT MAX(price) FROM book WHERE price<(SELECT MAX(price) FROM book));
--5. Display the count of teacher according to the teachers last name
SELECT tlname,COUNT(tid) AS CountteachersLastName FROM teacher GROUP BY tlname;
--6. Display the count of teacher according to the teachers branch if count is greater than 3
SELECT tbranch,COUNT(tid) AS teachersBranch FROM teacher GROUP BY tbranch HAVING COUNT(tid)>3;
--7. Display the count of teacher according to the teachers last name if the count is greater than 2
SELECT tlname,COUNT(tid) AS teachersLastName FROM teacher GROUP BY tlname HAVING COUNT(tid)>2;
--8. Display the count of the teacher according to the branch and head id
SELECT tbranch,hid,COUNT(tid) AS teacherCount FROM teacher GROUP BY tbranch,hid;
--9. Display the count of the teacher according to the  head id and branch 
SELECT hid,tbranch,COUNT(tid) AS teacherCount FROM teacher GROUP BY tbranch,hid;
SELECT *FROM issue;