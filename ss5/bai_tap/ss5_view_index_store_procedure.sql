create database product_management;
use product_management;
create table products (
  id int primary key auto_increment, 
  product_code int, 
  product_name varchar(50), 
  product_price double, 
  product_amount int, 
  product_description varchar(50), 
  product_status bit
);
insert into products (
  product_code, product_name, product_price, 
  product_amount, product_description, 
  product_status
) 
values 
  (1, 'Áo', 100, '10', 'Bền', 1), 
  (
    2, 'Quần', 200, '20', 'Vải đẹp', 
    1
  ), 
  (3, 'Giày', 1000, '1', 'Xinh', 0);
-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
create unique index i_product_code on products(product_code);
-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
create unique index i_product on products(product_name, product_price);
-- Tạo view lấy về các thông tin: productCode, productName, productPrice, 
-- productStatus từ bảng products.
create view show_product as 
select 
  product_code, 
  product_name, 
  product_price, 
  product_status 
from 
  products;
select 
  * 
from 
  show_product;
-- Tiến hành sửa đổi view
update 
  show_product 
set 
  product_price = 200 
where 
  product_name = "áo";
-- Tiến hành xoá view
drop 
  view show_product;
-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter // create procedure p_name () begin 
select 
  * 
from 
  products;
end // delimiter;
call p_name();
-- Tạo store procedure thêm một sản phẩm mới
delimiter // create procedure insert_product(
  in code int, 
  in name varchar(45), 
  in price double, 
  in amount int, 
  in description varchar(45), 
  in status bit
) begin insert into products(
  product_code, product_name, product_price, 
  product_amount, product_description, 
  product_status
) 
values 
  (
    code, name, price, amount, description, 
    status
  );
end // delimiter;
call insert_product(4, 'Gương', 20, 2, 'Bền', 1);
-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter // create procedure update_product (
  in id int, 
  in code int, 
  in name varchar(45), 
  in price double, 
  in amount int, 
  in description varchar(45), 
  in status bit
) begin 
update 
  products as p 
set 
  p.product_code = code, 
  p.product_name = name, 
  p.product_price = price, 
  p.product_amount = amount, 
  p.product_description = description, 
  p.product_status = status 
where 
  id = p.id;
end // delimiter;
call update_product(1, 5, '3', 4, 5, '6', 1);
call p_name();
-- Tạo store procedure xoá sản phẩm theo id
delimiter // create procedure remove_product_by_id(in id int) begin 
delete from 
  products as p 
where 
  p.id = id;
end // delimiter;
call remove_product_by_id(1);
