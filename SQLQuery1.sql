CREATE DATABASE KEC;
USE KEC;
DROP TABLE phonedetails;
DROP TABLE student;
CREATE TABLE student(
s_id INT PRIMARY KEY,
s_fname VARCHAR(50),
s_lname VARCHAR(50),
s_street VARCHAR(50),
s_ward INT,
s_city VARCHAR(50),
);
CREATE TABLE phonedetails(
ph_id INT,
simType VARCHAR(10),
phoneNo BIGINT,
balance INT,
s_id INT FOREIGN KEY REFERENCES student(s_id) ON DELETE CASCADE ON UPDATE SET NULL
);

INSERT INTO student VALUES(1,'Dipson','Adhikari','Mulpani',6,'Kathmandu');
INSERT INTO student VALUES(2,'Bipana','Ranabhat','Kalanki',9,'Kathmandu');
INSERT INTO student VALUES(3,'Dikshya','Shrestha','Jamal',5,'Kathmandu');
INSERT INTO student VALUES(4,'RAM','Adhikari','Mulpani',8,'Kathmandu');
INSERT INTO student VALUES(5,'HARI','Adhikari','Mulpani',10,'Kathmandu');

--inserting new data which is not linked to child class
INSERT INTO student VALUES(8,'Krishna','Shrestha','kalimati',4,'kathmandu');

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

--INSERT INTO phonedetails VALUES(10,'NTC',9851,150,1000);-->CANT insert the data whose foreign key DOESNT LINK AND IS NOT A PRIMARY KEY OF BASE TABLE
INSERT INTO phonedetails VALUES(10,'NTC',1234,45,8); --> CAN INSERT THE DATA WHOSE FOREIGN KEY CAN BE LINKED
DELETE FROM phonedetails WHERE phoneNo=94500;--CAN DO THIS WHICH MEANS CAN DELETE IT FROM CHILD TABLE
DELETE FROM student WHERE s_fname='HARI';-->CANT DELETE THE DATA FROM THE PARENT TABLE TAKE 2- WHEN USING ON DELETE CASCADE OR ON UPDATE SET NULL THERE WAS NO ERROR
DELETE FROM student WHERE s_fname='Krishna';-->can delete the data from parent class because its not linked to the child class
INSERT INTO student VALUES(8,'Krishna','Shrestha','kalimati',4,'kathmandu');
UPDATE student SET s_id=100 WHERE s_id=1;--> error, cant update the base table which is linked to the child table TAKE 2: NO ERROR AFTER ON UPDATE SET NULL

UPDATE student SET s_id=100 WHERE s_id=8;--> NO ERROR AS IT ISNT LINKED TO THE CHILD TABLE 

UPDATE phonedetails SET phoneNo=5635 WHERE phoneNo=96800;--> CAN UPDATE THE PHONENUMBER IN PHONEDETAILS TABLE AS IT IS CHILD TABLE


SELECT *FROM student;
SELECT *FROM phonedetails;