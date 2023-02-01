create database product_management;
use product_management;
create table products(
  id int auto_increment primary key, 
  product_code int, 
  product_name varchar(50), 
  product_price double, 
  product_amount int, 
  product_description varchar(50), 
  product_status varchar(50)
);

insert into products(id,
  product_code, product_name, product_price, 
  product_amount, product_description, 
  product_status
) 
values 
  (1,1, 'May Giat', 3, 1, 'abc', 'abc'), 
  (2,2, 'Tu Lanh', 5, 23, 'bcd', 'bcd'), 
  (3,3, 'Dieu Hoa', 7, 1, 'cde', 'cde'), 
  (4,4, 'Quat', 1, 4, 'def', 'def'), 
  (5,5, 'Bep Dien', 2, 3, 'efg', 'efg');
  
-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
explain 
select * from products 
where 
  product_code = 3;
create unique index i_code on products (product_code);

-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
explain select * from products 
where 
  product_code = 3 
  and product_price = 7;
create index i_code_price on products(product_code, product_price);

-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view w_product as 
select 
  product_code, 
  product_name, 
  product_price, 
  product_status 
from 
  products;
select * from w_product;
  
-- Tiến hành sửa đổi view
update 
  w_product 
set 
  product_name = 'abcd' 
where 
  product_code = 2;
  
-- Tiến hành xoá view
drop 
  view w_product;
  
-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
delimiter // create procedure sp_get_products() begin 
select * from products;
end // delimiter;
call sp_get_products;

-- Tạo store procedure thêm một sản phẩm mới
delimiter // create procedure sp_add_product(
  in product_code int, 
  in product_name varchar(50), 
  in product_price double, 
  in product_amount int, 
  in product_description varchar(50), 
  in product_status varchar(50)
) begin insert into products(
  product_code, product_name, product_price, 
  product_amount, product_description, 
  product_status
) value (
  product_code, product_name, product_price, 
  product_amount, product_description, 
  product_status
);
end // delimiter;
call sp_add_product(7, 'mnb', 4, 3, 'mnb', 'mnb');

-- Tạo store procedure sửa thông tin sản phẩm theo id
delimiter // 
create procedure sp_set_product(in p_id int) 
begin 
update products 
set product_name = 'mnpq' 
where id = p_id;
end // 
delimiter ;
call sp_set_product(1);

-- Tạo store procedure xoá sản phẩm theo id
delimiter //
create procedure sp_delete_product(in p_id int)
begin 
	delete from products 
	where id = p_id;
end //
delimiter ;
call sp_delete_product(1);