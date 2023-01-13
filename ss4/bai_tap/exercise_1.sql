use quan_ly_sinh_vien;
-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất. --
select * from `subject` where credit = (select max(credit) from `subject`);
-- Hiển thị các thông tin môn học có điểm thi lớn nhất.-- 
select `subject`.sub_name, mark.mark from `subject` 
inner join mark on `subject`.sub_id = mark.sub_id where mark.mark = (select max(mark) from mark);
-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, 
-- xếp hạng theo thứ tự điểm giảm dần-- 
select student_name,avg(mark) as `avg`from mark
inner join student on mark.student_id = student.student_id
group by student_name
order by `avg` desc;
