create database ss1_student_management;
use ss1_student_management;

-- bảng class. 
CREATE TABLE class (
    id INT,
    `name` VARCHAR(50),
    PRIMARY KEY (id)
);

-- bảng teacher.
create table teacher (
id int,
`name` varchar(50),
age int,
country varchar(50),
primary key(id)
); 
insert into class(id,`name`)values (1,"C1022G1");
insert into teacher(id,`name`,age,country) values
(5,"Quang Vinh",18,"VietNam"),
(6,"Nương cute số 1",18,"VietNam");
select * from teacher;
select * from class;
