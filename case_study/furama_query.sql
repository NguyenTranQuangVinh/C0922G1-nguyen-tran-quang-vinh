use furama_create_table;
-- 2.Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là 
-- một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.
select * from nhan_vien where substring_index(ho_ten," ",-1) like 'H%' 
or substring_index(ho_ten," ",-1) like 'T%'
or substring_index(ho_ten," ",-1) like 'K%'
and char_length(ho_ten) <= 15;
-- 3.	Hiển thị thông tin của tất cả khách hàng có độ tuổi
--  từ 18 đến 50 tuổi và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
select * from khach_hang where (dia_chi like '%Quảng Trị%' or dia_chi like '%Đà Nẵng%') and (year(curdate()) - year(ngay_sinh) between 18 and 50);
-- 4.	Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
-- Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
-- Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.
select khach_hang.*, count(khach_hang.ma_khach_hang) as so_lan_dat_phong from khach_hang
inner join loai_khach on loai_khach.ma_loai_khach = khach_hang.ma_loai_khach
inner join hop_dong on hop_dong.ma_khach_hang = khach_hang.ma_khach_hang
where
ten_loai_khach = 'Diamond'
group by 
khach_hang.ma_khach_hang
order by
so_lan_dat_phong;
-- 5.	Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, ma_hop_dong, 
-- ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, tong_tien(Với tổng tiền được tính theo công thức như sau: 
-- Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem, hop_dong_chi_tiet) 
-- cho tất cả các khách hàng đã từng đặt phòng. (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
select khach_hang.ma_khach_hang,
 khach_hang.ho_ten,
 loai_khach.ten_loai_khach, 
 hop_dong.ma_hop_dong,
 dich_vu.ten_dich_vu, 
 hop_dong.ngay_lam_hop_dong, 
 hop_dong.ngay_ket_thuc,
 ifnull(dich_vu.chi_phi_thue,0) + sum(ifnull(dich_vu_di_kem.gia*hop_dong_chi_tiet.so_luong,0)) as tong_tien 
 from hop_dong
 right join khach_hang on khach_hang.ma_khach_hang = hop_dong.ma_khach_hang
 left join loai_khach on loai_khach.ma_loai_khach = khach_hang.ma_loai_khach
 left join hop_dong_chi_tiet on hop_dong_chi_tiet.ma_hop_dong = hop_dong.ma_hop_dong 
 left join dich_vu on dich_vu.ma_dich_vu = hop_dong.ma_dich_vu 
 left join dich_vu_di_kem on dich_vu_di_kem.ma_dich_vu_di_kem = hop_dong_chi_tiet.ma_dich_vu_di_kem 
group by 
  hop_dong.ma_hop_dong;

 